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
@property (nonatomic) NSInteger currentTime;
@property (nonatomic) NSInteger startingTime;
@property (nonatomic) NSTimer *timer;
@end

//Starting with a fixed size, will later change this
CGFloat const kTimerWidth = 50;
CGFloat const kTimerHeight = 50;

CGFloat const kColorChangeAnimationDuration = 0.3f;
CGFloat const kPulseAnimationDuration = 0.2f;

CGFloat const kPulseScaleEnlarged = 1.1f;
CGFloat const kPulseScaleOriginal = 1;

@implementation ESCountdownView

#pragma mark - Initializers

+ (instancetype)timerAtOrigin:(CGPoint)origin delegate:(id<ESCountdownViewDelegate>)delegate time:(NSInteger)time {
    ESCountdownView *timer = [[ESCountdownView alloc] initWithFrame:CGRectMake(origin.x, origin.y, kTimerWidth, kTimerHeight) time:time];
    timer.currentTime = time;
    timer.startingTime = time;
    timer.delegate = delegate;
    return timer;
}

- (id)initWithFrame:(CGRect)frame time:(NSInteger)time {
    self = [super initWithFrame:frame];
    if (self) {
        self.time = ({
            ColorChangingLabel *label = [[ColorChangingLabel alloc] initWithFrame:self.bounds];
            label.text = [NSString stringWithFormat:@"%lu",time];
            label.backgroundColor = [UIColor greenColor];
            label.textAlignment = NSTextAlignmentCenter;
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

- (void)invalidate {
    [self.timer invalidate];
}

- (void)decrementTime {
    if (self.currentTime == 0) {
        [self timerFinished];
    }
    else {
        self.currentTime -= 1;
        self.time.text = [NSString stringWithFormat:@"%lu",self.currentTime];
        [self pulse];
        CGFloat percentage = (self.startingTime - self.currentTime) / (float)self.startingTime;
        UIColor *color = [self calcColorFromStartColor:[UIColor blackColor] targetColor:[UIColor redColor] percentage:percentage];
        [self animateColorTo:color];
    }
}

#pragma mark - Delegate

- (void)timerFinished {
    [self.timer invalidate];
    [self.delegate timerFinished];
}

#pragma mark - Animations

- (void)animateColorTo:(UIColor *)color {
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:kColorChangeAnimationDuration] forKey:kCATransactionAnimationDuration];
    self.time.textColor = color;
    [CATransaction commit];
}

- (void)pulse {
    [self pulseToScale:kPulseScaleEnlarged completion:^(BOOL finished) {
        [self pulseToScale:kPulseScaleOriginal completion:nil];
    }];
}

- (void)pulseToScale:(CGFloat)scale completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:kPulseAnimationDuration animations:^{
        self.time.transform = CGAffineTransformMakeScale(scale, scale);
    } completion:completion];
}

#pragma mark - Private Helpers

- (UIColor *)calcColorFromStartColor:(UIColor *)startColor targetColor:(UIColor *)targetColor percentage:(CGFloat)percentage {
    
    CGFloat rStart = 0.0, gStart = 0.0, bStart = 0.0, aStart = 0.0;
    [startColor getRed:&rStart green:&gStart blue:&bStart alpha:&aStart];
    
    CGFloat rEnd = 0.0, gEnd = 0.0, bEnd = 0.0, aEnd = 0.0;
    [targetColor getRed:&rEnd green:&gEnd blue:&bEnd alpha:&aEnd];
    
    CGFloat rResult = (rEnd-rStart)*percentage + rStart;
    CGFloat gResult = (gEnd-gStart)*percentage + gStart;
    CGFloat bResult = (bEnd-bStart)*percentage + bStart;
    CGFloat aResult = (aEnd-aStart)*percentage + aStart;
    
    return [UIColor colorWithRed:rResult green:gResult blue:bResult alpha:aResult];
}


@end