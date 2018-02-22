//
//  XYInputBar.h
//  FormView
//
//  Created by 黄伯驹 on 30/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYInputBar : UIView

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *secondButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) NSArray <UIButton *> *rightButtons;

/**
 Default 5
 超过5行会滚动，参考微信
 */
@property (nonatomic, assign) NSInteger maxShowLines;

+ (instancetype)bar;

@end
