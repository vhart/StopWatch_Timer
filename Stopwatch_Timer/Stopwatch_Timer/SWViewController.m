//
//  SWViewController.m
//  Stopwatch_Timer
//
//  Created by Jackie Meggesto on 8/21/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "SWViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SWViewController ()
@property (nonatomic) CADisplayLink* stopwatchDisplayLink;
@property (weak, nonatomic) IBOutlet UILabel* timerLabel;
@property (nonatomic) NSDate* now;

@end

@implementation SWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)setUpStopwatchLink {
    self.stopwatchDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(fireStopwatchDisplayLink)];
    [self.stopwatchDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}
-(void)fireStopwatchDisplayLink {
     NSTimeInterval interval = [self.now timeIntervalSinceNow];
    
    
    self.timerLabel.text = [NSString stringWithFormat:@"%f", -interval];
    
}


-(IBAction)startWatch:(id)sender {
    self.now = [NSDate date];
    [self setUpStopwatchLink];
}
-(IBAction)stopWatch:(id)sender {
    self.stopwatchDisplayLink.paused = YES;
    
}





@end
