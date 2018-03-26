//
//  TimerController.m
//  FormView
//
//  Created by 黄伯驹 on 12/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "TimerController.h"
#import "TimerClass.h"

@interface TimerController ()

@property (nonatomic, strong) TimerClass *timer;

@end

@implementation TimerController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.timer = [TimerClass new];
    [self.timer startPolling];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
