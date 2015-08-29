//
//  SWTimerViewController.m
//  Stopwatch_Timer
//
//  Created by Varindra Hart on 8/22/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "SWTimerViewController.h"
#import "SWTimerTableViewController.h"
#import "KAProgressLabel.h"
#import "LabelAnimator.h"


@interface SWTimerViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIView *timerView;
@property (weak, nonatomic) IBOutlet KAProgressLabel *hoursLabel;
@property (weak, nonatomic) IBOutlet KAProgressLabel *minutesLabel;
@property (weak, nonatomic) IBOutlet KAProgressLabel *secondsLabel;

@property (weak, nonatomic) IBOutlet UILabel *musicChoiceLabel;
@property (weak, nonatomic) IBOutlet UIView *play_stopView;
@property (weak, nonatomic) IBOutlet UIView *tableView_view;
@property (weak, nonatomic) IBOutlet UIView *musicLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedController;

@property (nonatomic) NSInteger startButtonState;
@property (nonatomic) NSInteger pauseButtonState;

@property (nonatomic, strong) NSTimer *countdown_Timer;

@property (nonatomic) SWTimerTableViewController *presetsTableView;

@property (nonatomic) LabelAnimator * animatedLabelsManager;

@property (nonatomic) AVAudioPlayer* timerPlayer;


@end

@implementation SWTimerViewController


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.presetsTableView.view.frame = self.tableView_view.bounds;
    
    // this is not beautiful but its the best of the hack options.
    // make sure the content inset (inside padding) is set to 0 all
    // the way around
    ((UITableView *)self.presetsTableView.view).contentInset = UIEdgeInsetsZero;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self embedTableView];
    [self buttonsDefaultState];
    [self addBorderToButtons];
    self.navigationController.navigationBarHidden = NO;
    self.musicLabel.layer.borderColor = [[UIColor purpleColor]CGColor];
    self.musicLabel.layer.borderWidth = 1.0f;
    self.navigationItem.title = @"Timer";
    self.animatedLabelsManager = [[LabelAnimator alloc] initWithLabels:self.secondsLabel medium:self.minutesLabel large:self.hoursLabel];
    [self.animatedLabelsManager setUpAllPropertyLabels];
    
    
}

-(void) embedTableView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.presetsTableView = [storyboard instantiateViewControllerWithIdentifier:@"presetsTableView"];
    self.presetsTableView.delegate = self;
    [self addChildViewController:self.presetsTableView];
    
    self.presetsTableView.view.frame = self.tableView_view.bounds;
    [self.tableView_view addSubview:self.presetsTableView.view];
    
    [self.presetsTableView willMoveToParentViewController:self];
}



- (IBAction)segmentToggled:(UISegmentedControl *)sender {
    
    if (self.segmentedController.selectedSegmentIndex == 0){
        
        self.tableView_view.hidden = YES;
        self.play_stopView.hidden = NO;
        
    }
    else if(self.segmentedController.selectedSegmentIndex == 1) {
        
        self.tableView_view.hidden = NO;
        self.play_stopView.hidden = YES;
        
    }
    
}

- (IBAction)pauseButton:(UIButton *)sender {
    
    if(self.pauseButtonState == -1){
        
        //Cancelling
        [self reset];
        self.datePickerView.hidden=NO;
        
    }
    else{
        //Paused Triggered
        [self invalidateTimer];
        
        [self updateAllButtonStates];
        [self startButtonChanges:self.startButton];
        [self pauseButtonChanges:sender];
        
    }
    
    
}

- (IBAction)startTimerButton:(UIButton *)sender {
    
    if(self.startButtonState == -1){
        
        //If there is no timer object then read in the date picker
        [self countdownBegins];
    }
    else{
        self.viewTimer.secondsForTimer +=60;
        [self updateTimerLabel];
    }
    
}


//start and pause (cancel) should go to default states
- (void)buttonsDefaultState{
    
    self.startButtonState = -1;
    self.pauseButtonState = -1;
    
}

- (void) updateAllButtonStates{
    
    self.startButtonState *= -1;
    self.pauseButtonState *= -1;
}

- (void) addBorderToButtons{
    
    self.startButton.layer.borderWidth = 2.0f;
    self.startButton.layer.borderColor = [[UIColor blackColor] CGColor];
    
    self.pauseButton.layer.borderWidth = 2.0f;
    self.pauseButton.layer.borderColor = [[UIColor blackColor] CGColor];
    
}


-(void)startButtonChanges:(UIButton *)button{
    
    if(self.startButtonState == 1){
        
        [button setTitle:@"+1" forState:UIControlStateNormal];
        
    }
    
    else{
        
        [button setTitle:@"Start" forState:UIControlStateNormal];
        [button setTintColor:[UIColor greenColor]];
        
    }
    
}

-(void)pauseButtonChanges:(UIButton *)button{
    
    if (self.pauseButtonState == 1) {
        
        [button setTitle:@"Pause" forState:UIControlStateNormal];
        [button setTintColor:[UIColor redColor]];
        [self.animatedLabelsManager reset];
        
    }
    else{
        
        [button setTitle:@"Cancel" forState:UIControlStateNormal];
        
    }
    
}


- (void) readDatePicker{
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"k:mm"];
    NSString *time = [outputFormatter stringFromDate:self.datePicker.date];
    
    self.timerLabel.text = [NSString stringWithFormat:@"%@:00", time];
    [self timerFromTimeString:(NSString*)time];
    
    self.datePickerView.hidden = YES;
    
    
}

- (void) countdownBegins{
    
    if(!self.viewTimer){
        [self readDatePicker];
        
    }
    
    //Change all buttons and update States
    [self updateAllButtonStates];
    [self startButtonChanges:self.startButton];
    [self pauseButtonChanges:self.pauseButton];
    [self updateTimerLabel];
    
    //Set up NSTimer
    [self.animatedLabelsManager reset];
    [self setUpTimer];
    self.datePickerView.hidden = YES;
}


- (void)reset{
    [self invalidateTimer];
    self.viewTimer = nil;
    
}


- (void) timerFromTimeString:(NSString *)time{
    
    NSArray *components = [time componentsSeparatedByString:@":"];
    int hour = [components[0] intValue];
    hour = hour!=24? hour: 0;
    int min = [components[1] intValue];
    
    self.viewTimer = [[Timer alloc] initWithHours:hour minutes:min];
}


- (void) updateTimerLabel{
    
    self.timerLabel.text = [self.viewTimer timeStringFromTimer];
    
}


- (void)setUpTimer{
    
    self.countdown_Timer = [[NSTimer alloc]initWithFireDate:self.datePicker.date interval: 0.04f target:self selector:@selector(fireCountdownTimer) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.countdown_Timer forMode:NSRunLoopCommonModes];
}


- (void) fireCountdownTimer{
    
    self.viewTimer.secondsForTimer -=.5;
    
    if (self.viewTimer.secondsForTimer <=0.0) {
        [self.animatedLabelsManager.smallLabel setProgress:1.0];
        [self invalidateTimer];
        self.timerLabel.text = @"00:00:00";
        [self deployAlertView];
        //[self reset];
        
    }
    else{
        
        [self updateTimerLabel];
        [self.animatedLabelsManager update];
    }
}

-(void) deployAlertView{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done!!" message:@"Time's up!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    
}
- (void) invalidateTimer{
    
    if(self.countdown_Timer!=nil){
        
        [self.countdown_Timer invalidate];
        self.countdown_Timer = nil;
        
    }
}

#pragma mark <SWTimerTableDelegate>

- (void) dictionaryForTimerSelected:(NSDictionary *)dictionary{
    
    [self reset];
    self.segmentedController.selectedSegmentIndex=0;
    [self segmentToggled:self.segmentedController];
    
    self.viewTimer = [[Timer alloc]initWithTimer:[dictionary objectForKey:@"timer"]];
    self.navigationItem.title = [dictionary objectForKey:@"name"];
    [self buttonsDefaultState];
    [self countdownBegins];
}
- (IBAction)musicViewSelected:(UIButton *)sender {
    NSLog(@"Music view selected");
}
- (IBAction)playAudioButtonSelected:(UIButton *)sender {
    NSLog(@"audio play, audio stop?");
}


- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    [self reset];
}

#pragma mark <SWAudioSelectorDelegate>

-(IBAction)audioButton:(UIButton*)sender {
    
}

-(void)didSelectAudioFile:(NSString*)string {
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: string];
    
    self.timerPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
    
}


@end
