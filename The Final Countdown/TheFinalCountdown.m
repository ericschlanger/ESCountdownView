//
//  TheFinalCountdown.m
//  The Final Countdown
//
//  Created by Eric Schlanger on 1/21/15.
//  Copyright (c) 2015 Perfect Beta Software. All rights reserved.
//

#import "TheFinalCountdown.h"

//Starting with a fixed size, will later change this
CGFloat const kTimerWidth = 200;
CGFloat const kTimerHeight = 200;

@implementation TheFinalCountdown

+ (instancetype)timerAtOrigin:(CGPoint)origin {
    TheFinalCountdown *timer = [[TheFinalCountdown alloc] initWithFrame:CGRectMake(origin.x, origin.y, kTimerWidth, kTimerHeight)];
    return timer;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
}

@end
