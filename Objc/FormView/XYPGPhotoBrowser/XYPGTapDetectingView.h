//
//  UIViewTap.h
//  Momento
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYPGTapDetectingViewDelegate;

@interface XYPGTapDetectingView : UIView {}

@property (nonatomic, weak) id <XYPGTapDetectingViewDelegate> tapDelegate;

@end

@protocol XYPGTapDetectingViewDelegate <NSObject>

@optional

- (void)view:(UIView *)view singleTapDetected:(UITouch *)touch;
- (void)view:(UIView *)view doubleTapDetected:(UITouch *)touch;
- (void)view:(UIView *)view tripleTapDetected:(UITouch *)touch;

@end
