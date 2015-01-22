//
//  TheFinalCountdown.m
//  The Final Countdown
//
//  Created by Eric Schlanger on 1/21/15.
//  Copyright (c) 2015 Perfect Beta Software. All rights reserved.
//

#import "TheFinalCountdown.h"

@interface TheFinalCountdown ()
@property (nonatomic) UILabel *time;
@property (nonatomic) NSTimer *timer;
@end

//Starting with a fixed size, will later change this
CGFloat const kTimerWidth = 200;
CGFloat const kTimerHeight = 200;

@implementation TheFinalCountdown

#pragma mark - Initializers

+ (instancetype)timerAtOrigin:(CGPoint)origin delegate:(id<TheFinalCountdownDelegate>)delegate time:(NSInteger)time {
    TheFinalCountdown *timer = [[TheFinalCountdown alloc] initWithFrame:CGRectMake(origin.x, origin.y, kTimerWidth, kTimerHeight) time:time];
    timer.delegate = delegate;
    return timer;
}

- (id)initWithFrame:(CGRect)frame time:(NSInteger)time {
    self = [super initWithFrame:frame];
    if (self) {
        self.time = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kTimerWidth, kTimerHeight)];
            label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:48];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [NSString stringWithFormat:@"%lu",time];
            label;
        });
        [self addSubview:self.time];
    }
    return self;
}

#pragma mark - starting and stopping

- (void)fire {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(decrementTime) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)decrementTime {
    //not sure if this is safe
    NSInteger currentTime = [self.time.text integerValue];
    
    if (currentTime == 0) {
        [self timerFinished];
    }
    else {
        self.time.text = [NSString stringWithFormat:@"%lu",(currentTime-1)];
    }
}

- (void)timerFinished {
    [self.timer invalidate];
    [self.delegate timerFinished];
}

@end