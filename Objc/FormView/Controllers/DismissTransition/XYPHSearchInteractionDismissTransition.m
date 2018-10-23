//
//  XYPHSearchFilterDismissTransition.m
//  Prophets
//
//  Created by 黄伯驹 on 2018/6/20.
//  Copyright © 2018 XingIn. All rights reserved.
//

#import "XYPHSearchInteractionDismissTransition.h"

@interface XYPHSearchInteractionDismissTransition()

@property (nonatomic, assign) NSTimeInterval duration;

@end

@implementation XYPHSearchInteractionDismissTransition

- (instancetype)initWithDuration:(NSTimeInterval)duration {
    if (self = [super init]) {
        self.duration = duration;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    if (!fromView) { return; }
    
    UIView *containerView = transitionContext.containerView;
    [containerView addSubview:toView];
    [containerView addSubview:fromView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect rect = fromView.frame;
        rect.origin.x = containerView.frame.size.width;
        fromView.frame = rect;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
