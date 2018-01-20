//
//  ScrollAnimationController.m
//  FormView
//
//  Created by 黄伯驹 on 17/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "ScrollAnimationController.h"

#import "XYPHRepeatAnimationView.h"

#import "SegmentController.h"

@interface ScrollAnimationController ()

@property (nonatomic, strong) XYPHRepeatAnimationView *repeatAnimationView;

@end

@implementation ScrollAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.repeatAnimationView];
    [self.repeatAnimationView startAnimaiton];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(pushAction)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.repeatAnimationView resumeAnimation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.repeatAnimationView pauseAnimation];
}

- (void)pushAction {
    SegmentController *vc = [SegmentController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (XYPHRepeatAnimationView *)repeatAnimationView {
    if (!_repeatAnimationView) {
        _repeatAnimationView = [[XYPHRepeatAnimationView alloc] initWithFrame:self.view.frame];
    }
    return _repeatAnimationView;
}

@end
