//
//  Timer.m
//  Stopwatch_Timer
//
//  Created by Varindra Hart on 8/22/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "Timer.h"

@implementation Timer

- (instancetype) initWithHours:(int)hours minutes:(int)minutes{
    
    if (self = [super init]) {
        double hour_sec = 3600*hours;
        double minutes_sec = 60*minutes;
        self.secondsForTimer = hour_sec + minutes_sec;
        
        return self;
    }
    return nil;
}

@end
