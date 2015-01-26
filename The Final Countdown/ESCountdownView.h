//
//  TheFinalCountdown.h
//  The Final Countdown
//
//  Created by Eric Schlanger on 1/21/15.
//  Copyright (c) 2015 Perfect Beta Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ESCountdownViewDelegate <NSObject>
@optional
- (void)timerFinished;
@end

@interface ESCountdownView : UIView

///--------------------------------
/// @name Creating countdown timers
///--------------------------------

/**
 Initializes an `ESCountdownView` object at the specified location with the specified time.
 Uses the default starting and ending colors of black and red, respectively.
 @param origin The origin for the timer's frame.
 @param time The starting time value for the timer.
 @return The newly-initialized timer
 */
+ (instancetype)timerAtOrigin:(CGPoint)origin time:(NSInteger)time;

/**
 Initializes an `ESCountdownView` object at the specified location with the specified time, starting color, and ending color.
 This is the designated initializer.
 @param origin The origin for the timer's frame.
 @param time The starting time value for the timer.
 @param start
 @return The newly-initialized timer
 */
+ (instancetype)timerAtOrigin:(CGPoint)origin time:(NSInteger)time startColor:(UIColor *)startColor endColor:(UIColor *)endColor;

///--------------------------------------
/// @name Starting and Stopping the Timer
///--------------------------------------

- (void)fire;
- (void)invalidate;

@property (nonatomic, weak) id<ESCountdownViewDelegate> delegate;

@end
