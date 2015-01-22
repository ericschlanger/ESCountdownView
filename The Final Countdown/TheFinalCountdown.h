//
//  TheFinalCountdown.h
//  The Final Countdown
//
//  Created by Eric Schlanger on 1/21/15.
//  Copyright (c) 2015 Perfect Beta Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TheFinalCountdownDelegate <NSObject>
@required
- (void)timerFinished;
@end

@interface TheFinalCountdown : UIView

+ (instancetype)timerAtOrigin:(CGPoint)origin delegate:(id<TheFinalCountdownDelegate>)delegate time:(NSInteger)time;

- (void)fire;

@property (nonatomic, weak) id<TheFinalCountdownDelegate> delegate;

@end
