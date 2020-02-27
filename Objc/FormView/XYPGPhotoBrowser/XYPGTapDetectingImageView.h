//
//  UIImageViewTap.h
//  Momento
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYPGTapDetectingImageViewDelegate;

@interface XYPGTapDetectingImageView : UIImageView {}

@property (nonatomic, weak) id <XYPGTapDetectingImageViewDelegate> tapDelegate;

@end

@protocol XYPGTapDetectingImageViewDelegate <NSObject>

@optional

- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView tripleTapDetected:(UITouch *)touch;

@end
