//
//  TimerController.m
//  FormView
//
//  Created by 黄伯驹 on 12/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "TimerController.h"
#import "TimerClass.h"
#import "NSTimer+Weak.h"

@interface TimerController ()

//@property (nonatomic, strong) TimerClass *timer;

@property (nonatomic, strong) NSTimer *pollTimer;

@end

@implementation TimerController

- (void)dealloc {
    NSLog(@"🍀🍀🍀🍀");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakself = self;
    self.pollTimer = [NSTimer eoc_scheduledTimerWithTimeInterval:1 block:^{
        [weakself p_doPoll];
    } repeats:YES];
}

- (void)p_doPoll {
    NSLog(@"%s", __FUNCTION__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
