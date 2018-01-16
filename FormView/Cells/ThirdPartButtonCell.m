//
//  ThirdPartButtonCell.m
//  FormView
//
//  Created by 黄伯驹 on 16/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "ThirdPartButtonCell.h"

#import "UIView+Extension.h"

#import <Masonry.h>

@interface ThirdPartButtonCell()

@property (nonatomic, strong) UIButton *weiboButton;
@property (nonatomic, strong) UIButton *QQButton;
@property (nonatomic, strong) UIButton *facebookButton;

@end

@implementation ThirdPartButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.transform = CGAffineTransformMakeScale(1, -1);

        NSArray *buttons = @[
                             self.weiboButton,
                             self.QQButton,
                             self.facebookButton
                             ];
        
            UIView *tmpView;
            UIButton *tmpButton;
            NSInteger index = 0;
            for (UIButton *button in buttons) {
                UIView *dummyView = [UIView new];
                [self addSubview:dummyView];
                [self addSubview:button];
                if (index == 0) { // 第一个
                    [dummyView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.leading.mas_equalTo(0);
                        make.trailing.mas_equalTo(button.mas_leading);
                    }];
                } else {
                    [dummyView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.leading.mas_equalTo(tmpButton.mas_trailing);
                        make.trailing.mas_equalTo(button.mas_leading);
                        make.width.mas_equalTo(tmpView.mas_width);
                    }];
                    // 最后一个
                    if (index == buttons.count - 1) {
                        UIView *lastDummyView = [UIView new];
                        [self addSubview:lastDummyView];
        
                        [lastDummyView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.mas_equalTo(tmpView.mas_width);
                            make.trailing.mas_equalTo(0);
                            make.leading.mas_equalTo(button.mas_trailing);
                        }];
                    }
                }
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(20);
                    make.centerY.mas_equalTo(0);
                }];
                tmpButton = button;
                tmpView = dummyView;
                index += 1;
            }
    }
    return self;
}

- (UIButton *)weiboButton {
    if (!_weiboButton) {
        _weiboButton = [self generateButtonWithTitle:@"微博"];
        [_weiboButton setImage:[UIImage imageNamed:@"auth_weibo"] forState:UIControlStateNormal];
        [_weiboButton addTarget:nil action:@selector(weiboButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weiboButton;
}

- (UIButton *)QQButton {
    if (!_QQButton) {
        _QQButton = [self generateButtonWithTitle:@"QQ"];
        [_QQButton setImage:[UIImage imageNamed:@"auth_QQ"] forState:UIControlStateNormal];
        [_QQButton addTarget:nil action:@selector(qqButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _QQButton;
}

- (UIButton *)facebookButton {
    if (!_facebookButton) {
        _facebookButton = [self generateButtonWithTitle:@"Facebook"];
        [_facebookButton setImage:[UIImage imageNamed:@"auth_facebook"] forState:UIControlStateNormal];
        [_facebookButton addTarget:nil action:@selector(facebookButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _facebookButton;
}

- (UIButton *)generateButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    return button;
}

@end
