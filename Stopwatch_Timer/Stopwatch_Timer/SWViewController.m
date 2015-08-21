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

@end

@implementation SWViewController

-(void)setUpStopwatchLink {
    self.stopwatchDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(fireStopwatchDisplayLink)];
    [self.stopwatchDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}
-(void)fireStopwatchDisplayLink {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(IBAction)startWatch:(id)sender {
    [self setUpStopwatchLink];
}
-(IBAction)stopWatch:(id)sender {
    self.stopwatchDisplayLink.paused = YES;
    
}





@end
