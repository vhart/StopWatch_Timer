//
//  SWAudioTableViewController.h
//  Stopwatch_Timer
//
//  Created by Jackie Meggesto on 8/29/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SWAudioSelectorDelegate <NSObject>

@optional

- (NSString*)didSelectAudioFile;

@end

@interface SWAudioTableViewController : UITableViewController

@end
