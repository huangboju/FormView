//
//  XYPHSearchFilterDismissPanGestureRecognizer.h
//  AFNetworking
//
//  Created by 黄伯驹 on 2018/7/9.
//

#import "XYPHSearchFilterDismissAnimator.h"

@interface XYPHSearchFilterDismissPanGestureRecognizer : UIPanGestureRecognizer

@property (nonatomic, strong, readonly) XYPHSearchFilterDismissAnimator *animator;

@property (nonatomic, copy) void (^finishHandleBlock)(void) ;

+ (instancetype)gestureBeginHandleBlock:(void(^)(XYPHSearchFilterDismissAnimator *))beginHandleBlock;

@end
