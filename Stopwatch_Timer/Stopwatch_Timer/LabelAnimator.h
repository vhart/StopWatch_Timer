//
//  LabelAnimator.h
//  Stopwatch_Timer
//
//  Created by Varindra Hart on 8/25/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KAProgressLabel.h"
#import <UIKit/UIKit.h>

//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface LabelAnimator : NSObject

@property (nonatomic) KAProgressLabel * smallLabel;
@property (nonatomic) KAProgressLabel * mediumLabel;
@property (nonatomic) KAProgressLabel * largeLabel;


//Only use this init method for concentric circles. Defaulted to 3 circles. Use regular init method if you only need a manager class object to manage your circles.
- (instancetype)initWithLabels:(KAProgressLabel *)small medium:(KAProgressLabel *)medium large:(KAProgressLabel *)large;

//fill color is color everywhere in the label EXCEPT for the track and progress, essentially anything but the circle itself. Track is literally a track for the progress bar to load onto. Progress is the progress bar that gets updated.
- (void)setUpLabel:(KAProgressLabel *)label withColorsProgressColor:(UIColor *)progress trackColor:(UIColor *)track fillColor:(UIColor *)fill;

//For nice smooth curves make corner width = to progress width;
-(void)setUpDimensionsForLabel:(KAProgressLabel *)label trackWidth:(CGFloat)track progressWidth:(CGFloat)progress roundedCornersWidth:(CGFloat)corners;

//Modify this method to set default settings for your label, then pass in a label and it will be customized to your default.
- (void)setUpLabelWithCustomDefaults:(KAProgressLabel *)label;


//Method to set up property labels as you see fit. 
- (void)setUpAllPropertyLabels;

//customize this method to load up your progress bars. Will ONLY work for circles that are set to the label properties above. 
- (void)update;
- (void)updateWithOriginal:(double)old new:(double)newValue;
- (void)reset;
@end
