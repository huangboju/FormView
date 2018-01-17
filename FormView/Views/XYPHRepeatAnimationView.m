//
//  XYPHRepeatAnimationView.m
//  FormView
//
//  Created by 黄伯驹 on 17/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYPHRepeatAnimationView.h"

#import "XYPHResumeAnimationImageView.h"

@interface XYPHRepeatAnimationView()

@property (nonatomic, strong) XYPHResumeAnimationImageView *firstView;

@property (nonatomic, strong) XYPHResumeAnimationImageView *secondView;

@end

@implementation XYPHRepeatAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.firstView];

        [self addSubview:self.secondView];
    }
    return self;
}

- (void)startAnimaiton {
    CGRect rect = self.secondView.frame;
    [UIView animateWithDuration:5 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear animations:^{
        self.secondView.frame = CGRectMake(rect.origin.x, 0, rect.size.width, rect.size.height);
        self.firstView.frame = CGRectMake(rect.origin.x, -rect.size.height, rect.size.width, rect.size.height);
    } completion:nil];
}

- (void)resumeAnimation {
    [self.firstView resumeAnimation];
    [self.secondView resumeAnimation];
}

- (void)pauseAnimation {
    [self.firstView pauseAnimation];
    [self.secondView pauseAnimation];
}

- (XYPHResumeAnimationImageView *)firstView {
    if (!_firstView) {
        _firstView = [[XYPHResumeAnimationImageView alloc] initWithImage:[UIImage imageNamed:@"scrollView"]];
        _firstView.contentMode = UIViewContentModeScaleAspectFit;
        CGFloat width = self.frame.size.width;
        CGFloat height = width * _firstView.frame.size.height / _firstView.frame.size.width;
        _firstView.frame = CGRectMake(0, 0, width, height);
    }
    return _firstView;
}

- (XYPHResumeAnimationImageView *)secondView {
    if (!_secondView) {
        _secondView = [[XYPHResumeAnimationImageView alloc] initWithImage:[UIImage imageNamed:@"scrollView"]];
        _secondView.contentMode = UIViewContentModeScaleAspectFit;
        CGFloat width = self.frame.size.width;
        CGFloat height = width * _secondView.frame.size.height / _secondView.frame.size.width;
        _secondView.frame = CGRectMake(0, height, width, height);
    }
    return _secondView;
}

@end
