//
//  PhotoBrowserInteractionDismisAnimator.h
//  FormView
//
//  Created by 黄伯驹 on 2020/3/5.
//  Copyright © 2020 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoBrowserInteractionDismissTransition : NSObject <UIViewControllerTransitioningDelegate>

- (void)begin;

- (void)updateInteractiveTransition:(CGFloat)percentComplete;

- (void)finish;

- (void)cancel;

- (void)invalidate;

@end

NS_ASSUME_NONNULL_END
