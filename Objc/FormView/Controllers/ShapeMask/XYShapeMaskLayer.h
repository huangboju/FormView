//
//  XYShapeMaskLayer.h
//  FormView
//
//  Created by xiAo_Ju on 2019/1/7.
//  Copyright © 2019 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYShapeMaskLayer : CAShapeLayer

- (instancetype)initWithFrame:(CGRect)frame;

/// Default [UIColor whiteColor]
@property (nonatomic, copy) UIColor *maskColor;

- (void)addTransparentRect:(CGRect)rect;

- (void)addTransparentRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;

- (void)addTransparentRoundedRect:(CGRect)rect
                byRoundingCorners:(UIRectCorner)corners
                      cornerRadii:(CGSize)cornerRadii;

- (void)addTransparentOvalRect:(CGRect)rect;

- (void)addCustomBezierPath:(UIBezierPath *)path;

@end

NS_ASSUME_NONNULL_END
