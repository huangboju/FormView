//
//  XYPHSearchFilterPresentTransition.m
//  Prophets
//
//  Created by 黄伯驹 on 2018/6/20.
//  Copyright © 2018 XingIn. All rights reserved.
//

#import "XYPHSearchFilterPresentTransition.h"

@implementation XYPHSearchFilterPresentTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIViewController *toVC = [transitionContext viewControllerForKey: UITransitionContextToViewControllerKey];
    if (!toView || !toVC) { return; }
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];

    UIView *containerView = transitionContext.containerView;
    [containerView addSubview:toView];
    
    CGFloat x = containerView.frame.size.width - toView.bounds.origin.x;
    CGRect toViewRect = toView.frame;
    toViewRect.origin.x = x;
    toView.frame = toViewRect;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toView.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
