//
//  XYPHSearchFilterDismissAnimator.m
//  Prophets
//
//  Created by 黄伯驹 on 2018/6/20.
//  Copyright © 2018 XingIn. All rights reserved.
//

#import "XYPHSearchFilterDismissAnimator.h"

#import "XYPHSearchFilterDismissTransition.h"

@interface XYPHSearchFilterDismissAnimator()

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation XYPHSearchFilterDismissAnimator

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

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[XYPHSearchFilterDismissTransition alloc] initWithDuration:0.5];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.percentDrivenTransition;
}

@end
