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

//Initializers
+ (instancetype)timerAtOrigin:(CGPoint)origin delegate:(id<ESCountdownViewDelegate>)delegate time:(NSInteger)time;

//Starting and stopping
- (void)fire;
- (void)invalidate;

@property (nonatomic, weak) id<ESCountdownViewDelegate> delegate;

@end
