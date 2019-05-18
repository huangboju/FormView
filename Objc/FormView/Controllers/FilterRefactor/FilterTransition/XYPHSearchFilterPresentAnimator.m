//
//  XYPHSearchFilterPresentAnimator.m
//  Prophets
//
//  Created by 黄伯驹 on 2018/6/20.
//  Copyright © 2018 XingIn. All rights reserved.
//

#import "XYPHSearchFilterPresentAnimator.h"

#import "XYPHSearchFilterDismissTransition.h"
#import "XYPHSearchFilterPresentTransition.h"

#import "XYPHSearchFilterPresentationController.h"

@interface XYPHSearchFilterPresentAnimator()

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation XYPHSearchFilterPresentAnimator

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

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [XYPHSearchFilterPresentTransition new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[XYPHSearchFilterDismissTransition alloc] initWithDuration:0.25];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.percentDrivenTransition;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[XYPHSearchFilterPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
