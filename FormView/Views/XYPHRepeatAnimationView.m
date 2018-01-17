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
        
        UIView *maskView = [[UIView alloc] initWithFrame:self.frame];
        maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [self addSubview:maskView];
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
        _firstView = [self generatImageView];
    }
    return _firstView;
}

- (XYPHResumeAnimationImageView *)secondView {
    if (!_secondView) {
        _secondView = [self generatImageView];
        CGRect rect = _secondView.frame;
        _secondView.frame = CGRectMake(0, rect.size.height, rect.size.width, rect.size.height);
    }
    return _secondView;
}

- (XYPHResumeAnimationImageView *)generatImageView {
    XYPHResumeAnimationImageView *imageView = [[XYPHResumeAnimationImageView alloc] initWithImage:[UIImage imageNamed:@"scrollView"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    CGFloat width = self.frame.size.width;
    CGFloat height = width * imageView.frame.size.height / imageView.frame.size.width;
    imageView.frame = CGRectMake(0, 0, width, height);
    return imageView;
}

@end

