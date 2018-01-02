//
//  EmptyView.h
//  FormView
//
//  Created by 黄伯驹 on 27/12/2017.
//  Copyright © 2017 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyView : UIView

/// Default 100
@property (nonatomic, assign) CGFloat topInterval;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSAttributedString *attributedText;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIFont *textFont;

// 默认样式按钮文本
@property (nonatomic, copy) NSString *buttonTitle;

/// 自定义按钮
/// 不能和buttonTitle同时设置
@property (nonatomic, strong) UIButton *button;

@end
