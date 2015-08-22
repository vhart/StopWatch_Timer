//
//  SWViewController.m
//  Stopwatch_Timer
//
//  Created by Jackie Meggesto on 8/21/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//



#import "SWViewController.h"
#import <QuartzCore/QuartzCore.h>

CFTimeInterval const frameInterval = 1.0/60.0f;

@interface SWViewController ()
@property (nonatomic) CADisplayLink* stopwatchDisplayLink;
@property (weak, nonatomic) IBOutlet UILabel* lapTimerLabel;
@property (nonatomic, weak) IBOutlet UILabel* runningTimerLabel;
@property (nonatomic) CFTimeInterval startTime;
@property (nonatomic) CFTimeInterval runningTimerValue;



@end

@implementation SWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.runningTimerValue = 0.0f;
    
}

-(void)setUpTimerLabel{
    
}

-(void)setUpStopwatchLink {
    self.stopwatchDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(fireStopwatchDisplayLink)];
    [self.stopwatchDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}
-(void)fireStopwatchDisplayLink {
    
    self.runningTimerValue += frameInterval;
    self.runningTimerLabel.text = [NSString stringWithFormat:@"%lf", self.runningTimerValue];
    
    self.lapTimerLabel.text = [NSString stringWithFormat:@"%lf", [self.stopwatchDisplayLink timestamp] - self.startTime];
    
}


-(IBAction)startWatch:(id)sender {
    self.startTime = CACurrentMediaTime();
    [self.stopwatchDisplayLink invalidate];
    [self setUpStopwatchLink];
}
-(IBAction)stopWatch:(id)sender {
    self.stopwatchDisplayLink.paused = YES;
    
}





@end
