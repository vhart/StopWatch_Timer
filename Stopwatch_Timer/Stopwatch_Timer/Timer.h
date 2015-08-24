//
//  Timer.h
//  Stopwatch_Timer
//
//  Created by Varindra Hart on 8/22/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timer : NSObject

@property (nonatomic) double secondsForTimer;

- (instancetype) initWithHours:(int)hours minutes:(int)minutes;
- (instancetype) initWithTimer:(Timer *)timer;
- (NSString *)timeStringFromTimer;
@end
