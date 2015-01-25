//
//  ColorChangingLabel.m
//  The Final Countdown
//
//  Created by Eric Schlanger on 1/22/15.
//  Copyright (c) 2015 Perfect Beta Software. All rights reserved.
//

#import "ColorChangingLabel.h"
#import <QuartzCore/QuartzCore.h>

@interface ColorChangingLabel ()
@property (nonatomic) CATextLayer *textLayer;
@end

@implementation ColorChangingLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCATextLayer];
    }
    return self;
}

- (void)setupCATextLayer {
    self.textLayer = [[CATextLayer alloc] init];
    self.textLayer.frame = self.bounds;
    self.textLayer.contentsScale = [[UIScreen mainScreen] scale];
    self.textLayer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    // Initialize the defaults.
    self.textColor = [super textColor];
    self.font = [super font];
    self.backgroundColor = [super backgroundColor];
    self.text = [super text];
    self.textAlignment = [super textAlignment];
    
    [super setText:nil];
    
    [self.layer addSublayer:self.textLayer];
}

#pragma mark - Override UILabel

- (UIColor *)textColor {
    return [UIColor colorWithCGColor:self.textLayer.foregroundColor];
}

- (void)setTextColor:(UIColor *)textColor {
   self.textLayer.foregroundColor = textColor.CGColor;
    [self setNeedsDisplay];
}

- (NSString *)text {
    return self.textLayer.string;
}

- (void)setText:(NSString *)text {
    self.textLayer.string = text;
    [self setNeedsDisplay];
}

@end
