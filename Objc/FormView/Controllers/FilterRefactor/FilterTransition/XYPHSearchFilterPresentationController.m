//
//  XYPHSearchFilterPresentationController.m
//  Prophets
//
//  Created by 黄伯驹 on 2018/6/20.
//  Copyright © 2018 XingIn. All rights reserved.
//

#import "XYPHSearchFilterPresentationController.h"
#import "XYPHSearchUtil.h"

@interface XYPHSearchFilterPresentationController()

@property (nonatomic, strong) UIView *dimmingView;

@end

@implementation XYPHSearchFilterPresentationController

- (UIModalPresentationStyle)presentationStyle {
    return UIModalPresentationCustom;
}

- (CGRect)frameOfPresentedViewInContainerView {
    CGRect frame = CGRectZero;
    frame.size = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:self.containerView.bounds.size];;
    frame.origin.x = [UIScreen mainScreen].bounds.size.width - frame.size.width;
    return frame;
}

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    return CGSizeMake(XYPHSearchUtil.contentWidth, parentSize.height);
}

- (UIView *)dimmingView {
    if (!_dimmingView) {
        _dimmingView = [UIView new];
        _dimmingView.translatesAutoresizingMaskIntoConstraints = NO;
        _dimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _dimmingView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
        [_dimmingView addGestureRecognizer:tap];
    }
    return _dimmingView;
}

- (void)tapHandle:(UITapGestureRecognizer *)sender {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)presentationTransitionWillBegin {
    [self.containerView insertSubview:self.dimmingView atIndex:0];
    self.dimmingView.frame = self.containerView.bounds;

    
    id <UIViewControllerTransitionCoordinator> coordinator = self.presentedViewController.transitionCoordinator;
    if (!coordinator) {
        self.dimmingView.alpha = 1.0;
        return;
    }

    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 1.0;
    } completion:nil];
}

- (void)dismissalTransitionWillBegin {
    id <UIViewControllerTransitionCoordinator> coordinator = self.presentedViewController.transitionCoordinator;
    if (!coordinator) {
        self.dimmingView.alpha = 0;
        return;
    }
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0;
    } completion:nil];
}

- (void)containerViewWillLayoutSubviews {
    self.presentedView.frame = self.frameOfPresentedViewInContainerView;
}

@end
