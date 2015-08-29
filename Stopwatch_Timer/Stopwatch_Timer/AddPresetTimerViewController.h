//
//  AddPresetTimerViewController.h
//  Stopwatch_Timer
//
//  Created by Varindra Hart on 8/29/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PresetTimerAddedDelegate <NSObject>

- (void) newPresetWithName:(NSString *)name timeString:(NSString *)time;

@end

@interface AddPresetTimerViewController : UIViewController

@property (nonatomic, weak) id<PresetTimerAddedDelegate>delegate;
@end
