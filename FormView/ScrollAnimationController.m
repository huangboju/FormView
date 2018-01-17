//
//  ScrollAnimationController.m
//  FormView
//
//  Created by 黄伯驹 on 17/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "ScrollAnimationController.h"
#import "ScrollAnimationImageView.h"

@interface ScrollAnimationController ()

@property (nonatomic, strong) ScrollAnimationImageView *blueView;

@property (nonatomic, strong) ScrollAnimationImageView *redView;

@property (nonatomic, assign) CGFloat redViewLastY;

@property (nonatomic, assign) CGFloat blueViewLastY;

@end

@implementation ScrollAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.blueView];
    
    [self.view addSubview:self.redView];
    
    [self animation];
}

- (void)animation {

    CGRect rect = self.redView.frame;
    [UIView animateWithDuration:5 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear animations:^{
        self.redView.frame = CGRectMake(rect.origin.x, 0, rect.size.width, rect.size.height);
        self.blueView.frame = CGRectMake(rect.origin.x, -rect.size.height, rect.size.width, rect.size.height);
    } completion:nil];
}

- (ScrollAnimationImageView *)blueView {
    if (!_blueView) {
        _blueView = [[ScrollAnimationImageView alloc] initWithImage:[UIImage imageNamed:@"scrollView"]];
        _blueView.contentMode = UIViewContentModeScaleAspectFit;
        CGFloat width = self.view.frame.size.width;
        CGFloat height = width * 3250 / 750;
        _blueView.frame = CGRectMake(0, 0, width, height);
    }
    return _blueView;
}

- (ScrollAnimationImageView *)redView {
    if (!_redView) {
        _redView = [[ScrollAnimationImageView alloc] initWithImage:[UIImage imageNamed:@"scrollView"]];
        _redView.contentMode = UIViewContentModeScaleAspectFit;
        CGFloat width = self.view.frame.size.width;
        CGFloat height = width * 3250 / 750;
        _redView.frame = CGRectMake(0, height, width, height);
    }
    return _redView;
}

@end
