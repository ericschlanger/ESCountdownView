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
@property (nonatomic) NSInteger currentTime;
@property (nonatomic) NSInteger startingTime;
@property (nonatomic, strong) UIColor *startColor;
@property (nonatomic, strong) UIColor *endColor;
@end

//Starting with a fixed size, will later change this
CGFloat const kTimerWidth = 50;
CGFloat const kTimerHeight = 50;

CGFloat const kColorChangeAnimationDuration = 0.3f;
CGFloat const kPulseAnimationDuration = 0.2f;
CGFloat const kPulseScaleEnlarged = 1.1f;
CGFloat const kPulseScaleOriginal = 1;

//Defaults
#define kDefaultStartColor [UIColor blackColor]
#define kDefaultEndColor [UIColor redColor]

@implementation ESCountdownView

#pragma mark - Initializers

+ (instancetype)timerAtOrigin:(CGPoint)origin time:(NSInteger)time {
    return [ESCountdownView timerAtOrigin:origin time:time startColor:kDefaultStartColor endColor:kDefaultEndColor];
}

+ (instancetype)timerAtOrigin:(CGPoint)origin time:(NSInteger)time startColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    ESCountdownView *timer = [[ESCountdownView alloc] initWithFrame:CGRectMake(origin.x, origin.y, kTimerWidth, kTimerHeight) time:time];
    timer.currentTime = time;
    timer.startingTime = time;
    timer.startColor = startColor;
    timer.endColor = endColor;
    return timer;
}

- (id)initWithFrame:(CGRect)frame time:(NSInteger)time {
    self = [super initWithFrame:frame];
    if (self) {
        self.time = ({
            ColorChangingLabel *label = [[ColorChangingLabel alloc] initWithFrame:self.bounds];
            label.text = [NSString stringWithFormat:@"%lu",time];
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
        [self changeColor];
    }
}

#pragma mark - Delegate

- (void)timerFinished {
    [self.timer invalidate];
    [self.delegate timerFinished];
}

#pragma mark - Animations

- (void)changeColor {
    CGFloat percentage = (self.startingTime - self.currentTime) / (float)self.startingTime;
    UIColor *color = [self calcColorFromStartColor:self.startColor targetColor:self.endColor percentage:percentage];
    [self animateColorTo:color];
}

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