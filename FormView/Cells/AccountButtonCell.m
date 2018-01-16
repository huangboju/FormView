//
//  AccountButtonCell.m
//  FormView
//
//  Created by 黄伯驹 on 16/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "AccountButtonCell.h"

#import <Masonry.h>

@interface AccountButtonCell()

@property (nonatomic, strong) UIButton *signInButton;

@property (nonatomic, strong) UIButton *signUpButton;

@end

@implementation AccountButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.backgroundColor = [UIColor cyanColor];
        
        UIVisualEffectView *signInButtonVisualView = [self generateVisualView];
        [self.contentView addSubview:signInButtonVisualView];

        [signInButtonVisualView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(30);
            make.height.mas_equalTo(44);
            make.top.bottom.mas_equalTo(0);
        }];

        [signInButtonVisualView.contentView addSubview:self.signInButton];
        [self.signInButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        
        
        [self.contentView addSubview:self.signUpButton];

        [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(-30);
            make.leading.mas_equalTo(self.signInButton.mas_trailing).offset(10);
            make.height.mas_equalTo(self.contentView.mas_height);
            make.width.mas_equalTo(self.signInButton.mas_width);
        }];
    }
    return self;
}

- (UIVisualEffectView *)generateVisualView {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    visualView.layer.cornerRadius = 8;
    visualView.layer.masksToBounds = YES;
    return visualView;
}

- (UIButton *)generateButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton new];
    button.layer.cornerRadius = 8;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    return button;
}

- (UIButton *)signInButton {
    if (!_signInButton) {
        _signInButton = [self generateButtonWithTitle:@"登录"];
    }
    return _signInButton;
}

- (UIButton *)signUpButton {
    if (!_signUpButton) {
        _signUpButton = [self generateButtonWithTitle:@"注册"];
        [_signUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _signUpButton.backgroundColor = [UIColor whiteColor];
    }
    return _signUpButton;
}

@end
