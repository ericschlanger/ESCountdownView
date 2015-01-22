//
//  ViewController.m
//  The Final Countdown
//
//  Created by Eric Schlanger on 1/21/15.
//  Copyright (c) 2015 Perfect Beta Software. All rights reserved.
//

#import "ViewController.h"
#import "TheFinalCountdown.h"

@interface ViewController () <TheFinalCountdownDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TheFinalCountdown *timer = [TheFinalCountdown timerAtOrigin:CGPointMake(200, 200) delegate:self time:10];
    timer.center = self.view.center;
    [self.view addSubview:timer];
    
    [timer fire];
}


#pragma mark - TheFinalCountdownDelegate Methods

- (void)timerFinished {
    NSLog(@"Finished!");
}

@end
