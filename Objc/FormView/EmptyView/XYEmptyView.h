//
//  EmptyView.h
//  FormView
//
//  Created by 黄伯驹 on 27/12/2017.
//  Copyright © 2017 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYEmptyView : UIView

/// Default 100
@property (nonatomic, assign) CGFloat topInterval;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSAttributedString *attributedText;

/// Default [UIColor colorWithRed:153.f / 255.0 green:153.f / 255.0 blue:153.f / 255.0 alpha:1]
@property (nonatomic, strong) UIColor *textColor;

/// Default 13
@property (nonatomic, strong) UIFont *textFont;

/// 默认样式按钮文本
@property (nonatomic, copy) NSString *buttonTitle;

/// 设置自定义按钮
/// 不能和buttonTitle同时设置
/// 设置buttonTitle后，会画出一个默认样式按钮，赋值给这个变量
@property (nonatomic, strong) UIButton *button;

@end
