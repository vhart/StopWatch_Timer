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
@property (nonatomic) double originalTime;

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
    self.musicLabel.layer.borderColor = [[UIColor blackColor]CGColor];
    self.musicLabel.layer.borderWidth = 1.0f;
    self.navigationItem.title = @"Timer";
    self.animatedLabelsManager = [[LabelAnimator alloc] initWithLabels:self.secondsLabel medium:self.minutesLabel large:self.hoursLabel];
    [self.animatedLabelsManager setUpAllPropertyLabels];
    [self defaultAudioFile];
    
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

- (void)defaultAudioFile{
    NSString* audioString = [NSString stringWithFormat:@"%@/%@.mp3", [[NSBundle mainBundle] resourcePath], @"Warning"];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: audioString];
    
    self.timerPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
}

#pragma mark Button State and Button Content Methods
- (void)buttonsDefaultState{
    
    self.startButtonState = -1;
    self.pauseButtonState = -1;
    
}

- (void) updateAllButtonStates{
    
    self.startButtonState *= -1;
    self.pauseButtonState *= -1;
}

//BORDERS*******************
- (void) addBorderToButtons{
    
    self.startButton.layer.borderWidth = 2.0f;
    self.startButton.layer.borderColor = [[UIColor blackColor] CGColor];
    
    self.pauseButton.layer.borderWidth = 2.0f;
    self.pauseButton.layer.borderColor = [[UIColor blackColor] CGColor];
    
}

//**********************
// Button Content Methods Below

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
//*******************************************************

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

//*************************************

- (IBAction)pauseButton:(UIButton *)sender {
    
    if(self.pauseButtonState == -1){
        
        //Cancelling
        [self reset];
        self.datePickerView.hidden=NO;
        self.originalTime = 0;
        
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
        self.originalTime += 60;
        [self updateTimerLabel];
    }
    
}

//****************************************************

#pragma mark Reading Date Picker
- (void) readDatePicker{
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"k:mm"];
    NSString *time = [outputFormatter stringFromDate:self.datePicker.date];
    
    self.timerLabel.text = [NSString stringWithFormat:@"%@:00", time];
    [self timerFromTimeString:(NSString*)time];
    
    self.datePickerView.hidden = YES;
    
    
}
//BEGIN COUNTDOWN
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

//*************************************************

#pragma mark Timer Object

- (void) timerFromTimeString:(NSString *)time{
    
    NSArray *components = [time componentsSeparatedByString:@":"];
    int hour = [components[0] intValue];
    hour = hour!=24? hour: 0;
    int min = [components[1] intValue];
    
    self.viewTimer = [[Timer alloc] initWithHours:hour minutes:min];
    self.originalTime = self.viewTimer.secondsForTimer;
}

//Timer Label
- (void) updateTimerLabel{
    
    self.timerLabel.text = [self.viewTimer timeStringFromTimer];
    
}

//*****************
#pragma mark Setting up NSTimer and Selector

- (void)setUpTimer{
    
    self.countdown_Timer = [[NSTimer alloc]initWithFireDate:self.datePicker.date interval: 0.04f target:self selector:@selector(fireCountdownTimer) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.countdown_Timer forMode:NSRunLoopCommonModes];
    
}


- (void) fireCountdownTimer{
    
    self.viewTimer.secondsForTimer -=.04;
    
    if (self.viewTimer.secondsForTimer <=0.0) {
        [self.animatedLabelsManager.smallLabel setProgress:0.0];
        [self invalidateTimer];
        self.timerLabel.text = @"00:00:00";
        [self.timerPlayer play];
        [self deployAlertView];
        //[self reset];
        
    }
    else{
        
        [self updateTimerLabel];
        [self.animatedLabelsManager updateWithOriginal:self.originalTime new:self.viewTimer.secondsForTimer];
    }
}

//*************************************

# pragma  Reset Methods

- (void)reset{
    [self invalidateTimer];
    self.viewTimer = nil;
    
}


- (void) invalidateTimer{
    
    if(self.countdown_Timer!=nil){
        
        [self.countdown_Timer invalidate];
        self.countdown_Timer = nil;
        
    }
}
//*************************************
#pragma UIAlertView Implementation and Delegate methods
-(void) deployAlertView{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done!!" message:@"Time's up!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    alert.delegate = self;
    [alert show];
    
}


- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"logging");
    if ([self.timerPlayer isPlaying]){
        [self.timerPlayer stop];
    }
    [self reset];
    [self buttonsDefaultState];
    [self startButtonChanges:self.startButton];
    [self pauseButtonChanges:self.pauseButton];
    self.originalTime = 0;
    self.datePickerView.hidden = NO;
}

//*************************************

#pragma mark Playing and Stopping Audio Player

- (IBAction)playAudioButtonSelected:(UIButton *)sender {
    
    NSLog(@"audio play, audio stop?");
    if([self.timerPlayer isPlaying]){
        [self.timerPlayer stop];
        
    }
    else{
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:2.0f target:self selector:@selector(stopPlaying:) userInfo:nil repeats:NO];
        [self.timerPlayer play];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
    }
}

- (void) stopPlaying:(NSTimer *)timer{
    [timer invalidate];
    timer = nil;
    if ([self.timerPlayer isPlaying]){
        [self.timerPlayer stop];
    }
}
//**************************************

#pragma mark <SWTimerTableDelegate>

- (void) dictionaryForTimerSelected:(NSDictionary *)dictionary{
    
    [self reset];
    self.segmentedController.selectedSegmentIndex=0;
    [self segmentToggled:self.segmentedController];
    
    self.viewTimer = [[Timer alloc]initWithTimer:[dictionary objectForKey:@"timer"]];
    self.originalTime = self.viewTimer.secondsForTimer;
    self.navigationItem.title = [dictionary objectForKey:@"name"];
    [self buttonsDefaultState];
    [self countdownBegins];
}


#pragma mark <SWAudioSelectorDelegate> and Transition to SWAudioTableViewContoller

-(void)didSelectAudioFilename:(NSString*)string {
    
    NSString* audioString = [NSString stringWithFormat:@"%@/%@.mp3", [[NSBundle mainBundle] resourcePath], string];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: audioString];
    
    self.timerPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
    self.musicChoiceLabel.text = string;
    
    
}

//************************************************

#pragma mark Transition to SWAudioTableViewController

-(IBAction)audioButton:(UIButton*)sender {
    SWAudioTableViewController *audioTable = [self.storyboard instantiateViewControllerWithIdentifier:@"AudioTable"];
    audioTable.delegate = self;
    audioTable.oldSelection = self.musicChoiceLabel.text;
    [self.navigationController pushViewController:audioTable animated:YES];

}

//


@end
