//
//  PasswordLoginCell.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "PasswordLoginCell.h"
#import "PasswordSignInController.h"

#import "UIView+Extension.h"
#import "UIColor+Hex.h"

@interface PasswordLoginCell()

@property(nonatomic, strong) UIButton *button;

@end

@implementation PasswordLoginCell

- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] init];
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitle:@"Password SignIn" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor colorWithR:80 g:135 b:221 a:1] forState:UIControlStateNormal];
    }
    return _button;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self.contentView addSubview:self.button];
        [self.button.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
        [self.button.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
        [self.button.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor].active = YES;
    }
    return self;
}

- (void)buttonAction:(UIButton *)sender {
    PasswordSignInController *vc = [[PasswordSignInController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

@end
