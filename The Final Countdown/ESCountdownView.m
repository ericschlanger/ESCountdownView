//
//  TheFinalCountdown.m
//  The Final Countdown
//
//  Created by Eric Schlanger on 1/21/15.
//  Copyright (c) 2015 Perfect Beta Software. All rights reserved.
//

#import "ESCountdownView.h"
#import "ColorChangingLabel.h"

@interface ESCountdownView ()
@property (nonatomic) ColorChangingLabel *time;
@property (nonatomic) NSTimer *timer;
@end

//Starting with a fixed size, will later change this
CGFloat const kTimerWidth = 200;
CGFloat const kTimerHeight = 200;

@implementation ESCountdownView

#pragma mark - Initializers

+ (instancetype)timerAtOrigin:(CGPoint)origin delegate:(id<ESCountdownViewDelegate>)delegate time:(NSInteger)time {
    ESCountdownView *timer = [[ESCountdownView alloc] initWithFrame:CGRectMake(origin.x, origin.y, kTimerWidth, kTimerHeight) time:time];
    timer.delegate = delegate;
    return timer;
}

- (id)initWithFrame:(CGRect)frame time:(NSInteger)time {
    self = [super initWithFrame:frame];
    if (self) {
        self.time = ({
            ColorChangingLabel *label = [[ColorChangingLabel alloc] initWithFrame:self.bounds];
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
        if (currentTime == 8) {
            [self animateColorTo:[UIColor purpleColor]];
        }
        if (currentTime == 4) {
            [self animateColorTo:[UIColor greenColor]];
        }
    }
}

- (void)timerFinished {
    [self.timer invalidate];
    [self.delegate timerFinished];
}

#pragma mark - Color Change Animations

- (void)animateColorTo:(UIColor *)color {
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:1] forKey:kCATransactionAnimationDuration];
    self.time.textColor = color;
    [CATransaction commit];
}

#pragma mark - Private Helpers

- (UIColor *)calcColorFromStartColor:(UIColor *)startColor targetColor:(UIColor *)targetColor percentage:(CGFloat)percentage {
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [startColor getRed:&red green:&green blue:&blue alpha:&alpha];
    return nil;
}

@end