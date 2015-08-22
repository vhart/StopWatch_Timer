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
#import "SWStopWatchHandler.h"

CFTimeInterval const frameInterval = 1.0/60.0f;

@interface SWViewController ()
@property (nonatomic) CADisplayLink* stopwatchDisplayLink;
@property (nonatomic) NSString* lapTimerText;
@property (nonatomic, weak) IBOutlet UILabel* runningTimerLabel;
@property (nonatomic) CFTimeInterval startTime;
@property (nonatomic) CFTimeInterval runningTimerValue;
@property (weak, nonatomic) IBOutlet UIView *tableViewSpace;
@property (nonatomic,strong) SWTableViewController *lapTableView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *lapButton;
@property (nonatomic) int startButtonState;
@property (nonatomic) int lapButtonState;
@property (nonatomic) CFTimeInterval lapTimerRef;


@end

@implementation SWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpButtons];
   
    [self embedTableViewController];
}

-(void)setUpButtons{
    self.runningTimerValue = 0.0f;
    self.startButtonState = -1;
    self.lapTimerRef = 0.0f;
    self.lapButtonState = -1;
    self.lapButton.enabled = NO;
}

-(void)setUpStopwatchLink {
    self.stopwatchDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(fireStopwatchDisplayLink)];
    [self.stopwatchDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}
-(void)fireStopwatchDisplayLink {
    
    self.runningTimerValue += frameInterval;
    self.runningTimerLabel.text = [NSString stringWithFormat:@"%.2lf", self.runningTimerValue];
    
   
   
    
}


-(IBAction)startWatch:(id)sender {
    switch (self.startButtonState) {
        case -1:
            [self startButtonSelected];
            
            break;
        case 1:
            [self stopButtonSelected];
            break;
        default:
            break;
    }
    
//    self.startTime = CACurrentMediaTime();
//    [self.stopwatchDisplayLink invalidate];
//    [self setUpStopwatchLink];
}
-(IBAction)lapButton:(id)sender {
    switch (self.lapButtonState) {
        case -1:
            [self lapButtonSelected];
            break;
        case 1:
            [self resetButtonSelected];
            break;
        default:
            break;
    }
//    self.stopwatchDisplayLink.paused = YES;
    
}
             
#pragma mark ActionsForStates

//START/STOP
-(void)startButtonSelected {
    self.startButton.backgroundColor = [UIColor redColor];
    [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
    self.lapButton.backgroundColor = [UIColor lightGrayColor];
    [self.lapButton setTitle:@"Lap" forState:UIControlStateNormal];
    self.lapButton.enabled = YES;
    
    if (self.stopwatchDisplayLink == nil) {
        [self setUpStopwatchLink];
    } else {
        self.stopwatchDisplayLink.paused = NO;
    }
    self.startTime = CACurrentMediaTime();
    
    self.lapButtonState = -1;
    self.startButtonState *= -1;
}
//************
             
-(void)stopButtonSelected {
    
    self.startButton.backgroundColor = [UIColor greenColor];
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    
    [self.lapButton setTitle:@"Reset" forState:UIControlStateNormal];
    self.lapButtonState *= -1;
    self.startButtonState *= -1;
    self.stopwatchDisplayLink.paused = YES;
    self.lapTimerRef = [self.lapTimerText doubleValue];
    
}

//***************************************

- (void) lapButtonSelected{
    
    double timeElapse = [self.stopwatchDisplayLink timestamp] - self.startTime;
    
    [self.lapTableView.lapTimesArray insertObject:[NSString stringWithFormat:@"%.2lf", self.lapTimerRef + timeElapse] atIndex:0];
    
    [self.lapTableView.tableView reloadData];
    self.lapTimerRef = 0.0f;
    self.startTime = CACurrentMediaTime();
    [self.stopwatchDisplayLink invalidate];
    [self setUpStopwatchLink];
    
    
    
    
}

- (void) resetButtonSelected{
    
    [self setUpButtons];
    self.runningTimerLabel.text = @"00.00";

    [self.lapTableView.lapTimesArray removeAllObjects];
    [self.lapTableView.tableView reloadData];
    
}

#pragma mark Embedding
//EMBEDDING METHOD
- (void) embedTableViewController{
    
    self.lapTableView = [self.storyboard instantiateViewControllerWithIdentifier:@"LapTableViewCtrlIdentifier"];
    
    [self addChildViewController:self.lapTableView];
    
    self.lapTableView.view.frame = self.tableViewSpace.bounds;
    [self.tableViewSpace addSubview:self.lapTableView.view];
    [self.lapTableView willMoveToParentViewController:self];
    
}

//***************************************

@end
