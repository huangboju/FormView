//
//  ScrollAnimationController.m
//  FormView
//
//  Created by 黄伯驹 on 17/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "ScrollAnimationController.h"
#import "ScrollAnimationImageView.h"

#import "SegmentController.h"

@interface ScrollAnimationController ()

@property (nonatomic, strong) ScrollAnimationImageView *firstView;

@property (nonatomic, strong) ScrollAnimationImageView *secondView;

@property (nonatomic, assign) CGFloat redViewLastY;

@property (nonatomic, assign) CGFloat blueViewLastY;

@end

@implementation ScrollAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.firstView];
    
    [self.view addSubview:self.secondView];
    
    [self animation];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(pushAction)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.firstView resumeAnimation];
    [self.secondView resumeAnimation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.firstView pauseAnimation];
    [self.secondView pauseAnimation];
}

- (void)pushAction {
    SegmentController *vc = [SegmentController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)animation {
    CGRect rect = self.secondView.frame;
    [UIView animateWithDuration:5 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear animations:^{
        self.secondView.frame = CGRectMake(rect.origin.x, 0, rect.size.width, rect.size.height);
        self.firstView.frame = CGRectMake(rect.origin.x, -rect.size.height, rect.size.width, rect.size.height);
    } completion:nil];
}

- (ScrollAnimationImageView *)firstView {
    if (!_firstView) {
        _firstView = [[ScrollAnimationImageView alloc] initWithImage:[UIImage imageNamed:@"scrollView"]];
        _firstView.contentMode = UIViewContentModeScaleAspectFit;
        CGFloat width = self.view.frame.size.width;
        CGFloat height = width * 3250 / 750;
        _firstView.frame = CGRectMake(0, 0, width, height);
    }
    return _firstView;
}

- (ScrollAnimationImageView *)secondView {
    if (!_secondView) {
        _secondView = [[ScrollAnimationImageView alloc] initWithImage:[UIImage imageNamed:@"scrollView"]];
        _secondView.contentMode = UIViewContentModeScaleAspectFit;
        CGFloat width = self.view.frame.size.width;
        CGFloat height = width * 3250 / 750;
        _secondView.frame = CGRectMake(0, height, width, height);
    }
    return _secondView;
}

@end
