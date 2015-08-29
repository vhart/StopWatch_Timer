//
//  SWAudioTableViewController.h
//  Stopwatch_Timer
//
//  Created by Jackie Meggesto on 8/29/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWAudioTableViewController;
@protocol SWAudioSelectorDelegate <NSObject>

@optional

-(void)didSelectAudioFilename:(NSString*)string;

@end

@interface SWAudioTableViewController : UITableViewController

@property (nonatomic,weak) id<SWAudioSelectorDelegate>delegate;

@end
