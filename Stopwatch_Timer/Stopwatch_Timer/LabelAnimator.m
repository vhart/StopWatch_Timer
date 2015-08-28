//
//  LabelAnimator.m
//  Stopwatch_Timer
//
//  Created by Varindra Hart on 8/25/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "LabelAnimator.h"
#import <UIKit/UIKit.h>


@implementation LabelAnimator

-(instancetype)initWithLabels:(KAProgressLabel *)small medium:(KAProgressLabel *)medium large:(KAProgressLabel *)large{
    if(self = [super init]){
        self.smallLabel = small;
        self.mediumLabel = medium;
        self.largeLabel = large;
        
        return self;
    }
    
    return nil;
}

- (void) setUpLabelWithCustomDefaults:(KAProgressLabel *)label{
    
        //modify
}

- (void)setUpLabel:(KAProgressLabel *)label withColorsProgressColor:(UIColor *)progress trackColor:(UIColor *)track fillColor:(UIColor *)fill{
    
    
    [label setProgressColor:progress]; // black progress bar
    [label setTrackColor:track]; // gray track bar
    [label setFillColor:fill]; //
    
//    label.labelVCBlock = ^(KAProgressLabel *label_) {
//        label.text = [NSString stringWithFormat:@"%.0f%%", (label.progress * 100)];
//    };
    
//    [label setProgress:0.0
//                     timing:TPPropertyAnimationTimingEaseOut
//                   duration:0.0
//                      delay:0.0];

}

- (void)setUpDimensionsForLabel:(KAProgressLabel *)label trackWidth:(CGFloat)track progressWidth:(CGFloat)progress roundedCornersWidth:(CGFloat)corners{
    
    label.trackWidth = track;         // Defaults to 5.0
    label.progressWidth = progress;        // Defaults to 5.0
    label.roundedCornersWidth = corners; // Defaults to 0
    [label setUserInteractionEnabled:NO];

}

-(void)setUpAllPropertyLabels{
    
    [self setUpDimensionsForLabel:self.smallLabel trackWidth:6.0f progressWidth:8.0f roundedCornersWidth:8.0f];
    [self setUpDimensionsForLabel:self.mediumLabel trackWidth:6.0f progressWidth:8.0f roundedCornersWidth:8.0f];
    [self setUpDimensionsForLabel:self.largeLabel trackWidth:6.0f progressWidth:8.0f roundedCornersWidth:8.0f];
    
    [self setUpLabel:self.smallLabel withColorsProgressColor:UIColorFromRGB(0x53CFF5) trackColor:UIColorFromRGBWithAlpha(0x5882DB, 1) fillColor:[UIColor clearColor]];
    
    [self setUpLabel:self.mediumLabel withColorsProgressColor:UIColorFromRGB(0x25EF00) trackColor:UIColorFromRGBWithAlpha(0x82FA86, .7) fillColor:[UIColor clearColor]];
   
    [self setUpLabel:self.largeLabel withColorsProgressColor:UIColorFromRGB(0xFF0000) trackColor:UIColorFromRGBWithAlpha(0xFF9494, 1) fillColor:[UIColor clearColor]];
   // 0xFF9494
}

- (void)reset{
    [self.smallLabel setProgress:0.0];
    [self.mediumLabel setProgress:0.0];
    [self.largeLabel setProgress:0.0];
}


- (void)update{
    
    CGFloat progress = self.smallLabel.progress + (2.0f / 1500.0f);
    CGFloat progressTwo;
    [self.smallLabel setProgress:progress];
    if (progress>=1.0) {
        progress-=1.0;
        [self.smallLabel setProgress:progress];
        progressTwo = self.mediumLabel.progress + (1.0f/60.0f);
        [self.mediumLabel setProgress:progressTwo];
    }
    if (progressTwo>=1.0) {
        [self.mediumLabel setProgress:(progressTwo-1.0f)];
        [self.largeLabel setProgress:self.largeLabel.progress+ 1.0/24.0f];
    }

    
}

@end
