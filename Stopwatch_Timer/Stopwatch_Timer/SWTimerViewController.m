//
//  SWTimerViewController.m
//  Stopwatch_Timer
//
//  Created by Varindra Hart on 8/22/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "SWTimerViewController.h"

@interface SWTimerViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic) NSInteger startButtonState;
@property (nonatomic) NSInteger pauseButtonState;
@property (nonatomic, strong) NSTimer *countdown_Timer;
@end

@implementation SWTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startButtonState = -1;
    self.pauseButtonState = -1;
    if (self.viewTimer == nil) {
        
    } else {
        self.datePickerView.hidden = YES;
    }
    
}
- (IBAction)pauseButton:(UIButton *)sender {
    
    if(self.pauseButtonState == -1){
        [self exitView];
    }
    else{
        [self invalidateTimer];
        
        [self updateAllButtonStates];
        [self startButtonChanges:self.startButton];
        [self pauseButtonChanges:sender];
        
    }
    
    
}

- (IBAction)startTimerButton:(UIButton *)sender {
    if(self.startButtonState == -1){
        [self setUpTimer];
        
        [self updateAllButtonStates];
        [self startButtonChanges:sender];
        [self pauseButtonChanges:self.pauseButton];
    }
    else{
        self.viewTimer.secondsForTimer +=60;
        [self updateTimerLabel];
    }
    
}

- (void) updateAllButtonStates{
    self.startButtonState *= -1;
    self.pauseButtonState *= -1;
}

- (void)setUpTimer{
    self.countdown_Timer = [[NSTimer alloc]initWithFireDate:self.datePicker.date interval: 0.5f target:self selector:@selector(fireCountdownTimer) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.countdown_Timer forMode:NSRunLoopCommonModes];
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
    }
    else{
        [button setTitle:@"Cancel" forState:UIControlStateNormal];
        
    }
    
}

-(void) exitView{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)okDatePicker:(UIButton *)sender {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"k:mm"];
    NSString *time = [outputFormatter stringFromDate:self.datePicker.date];
    self.timerLabel.text = [NSString stringWithFormat:@"%@:00", time];
    [self timerFromTimeString:(NSString*)time];
    
    self.datePickerView.hidden = YES;
    
    
}

- (IBAction)cancelDatePicker:(UIButton *)sender {
    [self exitView];
}


- (void) timerFromTimeString:(NSString *)time{
    NSArray *components = [time componentsSeparatedByString:@":"];
    int hour = [components[0] intValue];
    int min = [components[1] intValue];
    self.viewTimer = [[Timer alloc] initWithHours:hour minutes:min];
}


- (void) updateTimerLabel{
    
    self.timerLabel.text = [self.viewTimer timeStringFromTimer];
    
}

- (void) fireCountdownTimer{
    self.viewTimer.secondsForTimer -=.5;
    if (self.viewTimer.secondsForTimer <=0.0) {
        [self invalidateTimer];
        self.timerLabel.text = @"00:00:00";
        [self exitView];
    }
    else{
        [self updateTimerLabel];
    }
}

- (void) invalidateTimer{
    [self.countdown_Timer invalidate];
    self.countdown_Timer = nil;
}

@end
