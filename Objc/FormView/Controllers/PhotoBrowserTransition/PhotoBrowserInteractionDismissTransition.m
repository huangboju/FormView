//
//  PhotoBrowserInteractionDismisAnimator.m
//  FormView
//
//  Created by 黄伯驹 on 2020/3/5.
//  Copyright © 2020 黄伯驹. All rights reserved.
//

#import "PhotoBrowserInteractionDismissTransition.h"

@interface PhotoBrowserInteractionDismissTransition() <UIViewControllerAnimatedTransitioning>

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation PhotoBrowserInteractionDismissTransition

- (void)begin {
    self.percentDrivenTransition = [UIPercentDrivenInteractiveTransition new];
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    [self.percentDrivenTransition updateInteractiveTransition:percentComplete];
}

- (void)finish {
    [self.percentDrivenTransition finishInteractiveTransition];
}

- (void)cancel {
    [self.percentDrivenTransition cancelInteractiveTransition];
}

- (void)invalidate {
    self.percentDrivenTransition = nil;
}

#pragma mark <UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.percentDrivenTransition;
}

#pragma mark <UIViewControllerAnimatedTransitioning>
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    if (!fromView) { return; }
    
    UIView *containerView = transitionContext.containerView;
    [containerView addSubview:toView];
    [containerView addSubview:fromView];

    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 animations:^{
            CGRect rect = fromView.frame;
            rect.origin.y = containerView.frame.size.height;
            fromView.frame = rect;
        }];
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.3 animations:^{
            fromView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.9 animations:^{
            fromView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
