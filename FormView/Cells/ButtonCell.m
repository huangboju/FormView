//
//  ButtonCell.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "ButtonCell.h"
#import "UIView+Extension.h"
#import "UIColor+Hex.h"

@implementation ButtonCellItem

@end

@interface ButtonCell()

@property(nonatomic, strong) UIButton *button;

@end

@implementation ButtonCell

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor colorWithHex:0xFF2238];
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        _button.layer.cornerRadius = 5.f;
        [_button addTarget:self.viewController action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.button];
        [self.button.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:50].active = YES;
        [self.button.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
        [self.button.heightAnchor constraintEqualToConstant:45].active = YES;
        [self.button.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [self.button.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    }
    return self;
}

- (void)updateViewData:(ButtonCellItem *)viewData {
    [self.button setTitle:viewData.title forState:UIControlStateNormal];
}

@end
