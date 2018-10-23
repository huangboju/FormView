//
//  XYPHSearchFilterDismissPanGestureRecognizer.h
//  AFNetworking
//
//  Created by 黄伯驹 on 2018/7/9.
//

#import <UIKit/UIKit.h>

#import "XYPHSearchInteractionDismissAnimator.h"

@interface XYPHSearchDismissPanGestureRecognizer : UIScreenEdgePanGestureRecognizer

@property (nonatomic, strong, readonly) XYPHSearchInteractionDismissAnimator *animator;

@property (nonatomic, copy) void (^finishHandleBlock)(void) ;

+ (instancetype)gestureBeginHandleBlock:(void(^)(XYPHSearchInteractionDismissAnimator *))beginHandleBlock;

@end
