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


- (instancetype) initWithTimer:(Timer *)timer{
    
    if (self = [super init]) {
        
        self.secondsForTimer = timer.secondsForTimer;
        
        return self;
    }
    return nil;
}



- (NSString *)timeStringFromTimer{
    
    double time = self.secondsForTimer;
    int HH =  time/ 3600;
    
    time = time - (3600 * HH);
    int MM = time / 60;
    time = time - 60 * MM;
    int SS = floor(time);
    
    return [NSString stringWithFormat:@"%.2d:%.2d:%.2d", HH, MM, SS];
    

}

@end
