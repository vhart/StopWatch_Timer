//
//  SWTimerViewController.h
//  Stopwatch_Timer
//
//  Created by Varindra Hart on 8/22/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "Timer.h"
#import <UIKit/UIKit.h>
#import "SWTimerTableViewController.h"

@interface SWTimerViewController : UIViewController <SWTimerTableViewDelegate>

@property (nonatomic) Timer* viewTimer;

@end
