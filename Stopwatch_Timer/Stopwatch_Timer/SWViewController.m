//
//  SWViewController.m
//  Stopwatch_Timer
//
//  Created by Jackie Meggesto on 8/21/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//



#import "SWViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SWTableViewController.h"

CFTimeInterval const frameInterval = 1.0/60.0f;

@interface SWViewController ()
@property (nonatomic) CADisplayLink* stopwatchDisplayLink;
@property (weak, nonatomic) IBOutlet UILabel* lapTimerLabel;
@property (nonatomic, weak) IBOutlet UILabel* runningTimerLabel;
@property (nonatomic) CFTimeInterval startTime;
@property (nonatomic) CFTimeInterval runningTimerValue;
@property (weak, nonatomic) IBOutlet UIView *tableViewSpace;
@property (nonatomic,strong) SWTableViewController *lapTableView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (nonatomic) int startButtonState;
@property (nonatomic) int stopButtonState;


@end

@implementation SWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.runningTimerValue = 0.0f;
    self.startButtonState = -1;
    self.stopButtonState = -1;
    self.stopButton.hidden = YES;
   
    [self embedTableViewController];
}

-(void)setUpTimerLabel{
    
}

-(void)setUpStopwatchLink {
    self.stopwatchDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(fireStopwatchDisplayLink)];
    [self.stopwatchDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}
-(void)fireStopwatchDisplayLink {
    
    self.runningTimerValue += frameInterval;
    self.runningTimerLabel.text = [NSString stringWithFormat:@"%.2lf", self.runningTimerValue];
    
    self.lapTimerLabel.text = [NSString stringWithFormat:@"%.2lf", [self.stopwatchDisplayLink timestamp] - self.startTime];

    
}


-(IBAction)startWatch:(id)sender {
    switch (self.startButtonState) {
        case -1:
            <#statements#>
            break;
        case 1:
            
            break;
        default:
            break;
    }
    
//    self.startTime = CACurrentMediaTime();
//    [self.stopwatchDisplayLink invalidate];
//    [self setUpStopwatchLink];
}
-(IBAction)stopWatch:(id)sender {
    switch (self.stopButtonState) {
        case -1:
            <#statements#>
            break;
        case 1:
            
            break;
        default:
            break;
    }
//    self.stopwatchDisplayLink.paused = YES;
    
}
-(void)startButtonOn {
    self.startButton.backgroundColor = [UIColor redColor];
    [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
    self.stopButton.backgroundColor = [UIColor lightGrayColor];
    [self.stopButton setTitle:@"Lap" forState:UIControlStateNormal];
    if (self.stopwatchDisplayLink == nil) {
        [self setUpStopwatchLink];
    } else {
        self.stopwatchDisplayLink.paused = YES;
    }
    self.startTime = CACurrentMediaTime();
    
    
    self.startButtonState *= -1;
}
-(void)startButtonOff {
    self.startButton.backgroundColor = [UIColor greenColor];
    [self.startButton setTitle:@"Resume" forState:UIControlStateNormal];
    [self.stopButton setTitle:@"Reset" forState:UIControlStateNormal];
    self.stopwatchDisplayLink.paused = NO;
}
-(void)stopButtonOn {
    
}
-(void)stopButtonOff {
    
}

- (void) embedTableViewController{
    
    self.lapTableView = [self.storyboard instantiateViewControllerWithIdentifier:@"LapTableViewCtrlIdentifier"];
    
    [self addChildViewController:self.lapTableView];
    
    self.lapTableView.view.frame = self.tableViewSpace.bounds;
    [self.tableViewSpace addSubview:self.lapTableView.view];
    [self.lapTableView willMoveToParentViewController:self];
    
}



@end
