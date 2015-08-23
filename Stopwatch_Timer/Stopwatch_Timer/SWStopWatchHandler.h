//
//  SWStopWatchHandler.h
//  Stopwatch_Timer
//
//  Created by Varindra Hart on 8/22/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWStopWatchHandler : NSObject

@property (nonatomic) int startButtonState;
@property (nonatomic) int stopButtonState;
@property (nonatomic) CFTimeInterval startTime;
@property (nonatomic) CFTimeInterval pausedTimeRef;


@end
