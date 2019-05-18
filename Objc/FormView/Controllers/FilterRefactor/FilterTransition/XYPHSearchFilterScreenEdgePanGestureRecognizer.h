//
//  XYPHSearchFilterScreenEdgePanGestureRecognizer.h
//  Prophets
//
//  Created by 黄伯驹 on 2018/6/20.
//  Copyright © 2018 XingIn. All rights reserved.
//

#import "XYPHSearchFilterPresentAnimator.h"

@interface XYPHSearchFilterScreenEdgePanGestureRecognizer : UIScreenEdgePanGestureRecognizer

@property (nonatomic, strong, readonly) XYPHSearchFilterPresentAnimator *animator;

@property (nonatomic, copy) void (^finishHandleBlock)(void) ;

+ (instancetype)gestureBeginHandleBlock:(void(^)(XYPHSearchFilterPresentAnimator *))beginHandleBlock;

@end
