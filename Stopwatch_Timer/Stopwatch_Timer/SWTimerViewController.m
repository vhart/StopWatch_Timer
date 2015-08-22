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

@end

@implementation SWTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.viewTimer == nil) {
        
    } else {
        self.datePicker.hidden = YES;
    }
}
- (IBAction)buttonTapped:(id)sender {
    NSTimer *viewTimer = [[NSTimer alloc]initWithFireDate:self.datePicker.date interval:1.0 target:self selector:@selector(fireAlarmTimer) userInfo:nil repeats:NO];
    
    [[NSRunLoop mainRunLoop] addTimer:viewTimer forMode:NSRunLoopCommonModes];
}





@end
