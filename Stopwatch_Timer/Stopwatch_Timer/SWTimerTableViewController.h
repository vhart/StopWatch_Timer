//
//  SWTimerTableViewController.h
//  Stopwatch_Timer
//
//  Created by Varindra Hart on 8/22/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Timer.h"

@protocol SWTimerTableViewDelegate <NSObject>

@optional
- (void) timerSelected:(Timer *)timer;

@end

@interface SWTimerTableViewController : UITableViewController

@property (nonatomic) NSMutableArray *presetArrayOfDictionaries;
@property (nonatomic,weak) id<SWTimerTableViewDelegate>delegate;
@end


