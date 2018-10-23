//
//  XYPHSearchInteractionDismissAnimator.h
//  Prophets
//
//  Created by 黄伯驹 on 2018/6/20.
//  Copyright © 2018 XingIn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYPHSearchInteractionDismissAnimator : NSObject <UIViewControllerTransitioningDelegate>

- (void)begin;

- (void)updateInteractiveTransition:(CGFloat)percentComplete;

- (void)finish;

- (void)cancel;

- (void)invalidate;

@end
