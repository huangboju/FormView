//
//  WechatButtonCell.m
//  FormView
//
//  Created by 黄伯驹 on 16/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "WechatButtonCell.h"

#import "UIView+Extension.h"

#import <Masonry.h>

@interface WechatButtonCell()

@property (nonatomic, strong) UIButton *wechatButton;

@end

@implementation WechatButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.transform = CGAffineTransformMakeScale(1, -1);

        UIVisualEffectView *signInButtonVisualView = [self generateVisualView];
        [self.contentView addSubview:signInButtonVisualView];
        
        [signInButtonVisualView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(30);
            make.height.mas_equalTo(44);
            make.top.mas_equalTo(10);
            make.centerX.bottom.mas_equalTo(0);
        }];

        [signInButtonVisualView.contentView addSubview:self.wechatButton];
        [self.wechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
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

- (UIButton *)wechatButton {
    if (!_wechatButton) {
        _wechatButton = [UIButton new];
        _wechatButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_wechatButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_wechatButton addTarget:nil action:@selector(wechatButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _wechatButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        _wechatButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        [_wechatButton setImage:[UIImage imageNamed:@"auth_wechat"] forState:UIControlStateNormal];
        [_wechatButton setTitle:@"微信登录" forState:UIControlStateNormal];
    }
    return _wechatButton;
}

@end
