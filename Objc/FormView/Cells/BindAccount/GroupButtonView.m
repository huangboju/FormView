//
//  GroupButtonView.m
//  FormView
//
//  Created by 黄伯驹 on 30/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "GroupButtonView.h"

#import "XYPHBindAccountUIGenerator.h"


#import <Masonry.h>

@interface GroupButtonView()

@property (nonatomic, strong) UIButton *changeBindingBtn;

@property (nonatomic, strong) UIButton *unchangeBindingBtn;

@end

@implementation GroupButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        
        UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.changeBindingBtn, self.unchangeBindingBtn]];
        stackView.spacing = 15;
        stackView.distribution = UIStackViewDistributionFillEqually;
        stackView.axis = UILayoutConstraintAxisVertical;
        [self addSubview:stackView];
        [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(25);
            make.width.mas_equalTo(280);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(103);
            if ([UIScreen mainScreen].bounds.size.height == 812) {
                make.bottom.mas_equalTo(-140);
            } else {
                make.bottom.mas_equalTo(-25);
            }
        }];
    }
    return self;
}

#pragma mark - Actions

- (void)changeBindingBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(groupButtonViewChangeBindingButtonClicked:)]) {
        [self.delegate groupButtonViewChangeBindingButtonClicked:self];
    }
}

- (void)unchangeBindingBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(groupButtonViewUnchangeBindingBtnButtonClicked:)]) {
        [self.delegate groupButtonViewUnchangeBindingBtnButtonClicked:self];
    }
}

- (void)setShowsShadow:(BOOL)showsShadow animated:(BOOL)animated {
    void (^animations)(void) = ^{
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.layer.shadowColor = showsShadow ? [UIColor lightGrayColor].CGColor : [UIColor clearColor].CGColor;
        self.layer.shadowOpacity = 0.8f;
        self.layer.shadowOffset = CGSizeMake(0, -2);
    };
    if (animated) {
        [UIView animateWithDuration:0.25 animations:animations];
    } else {
        animations();
    }
}

- (UIButton *)changeBindingBtn {
    if (!_changeBindingBtn) {
        _changeBindingBtn = [XYPHBindAccountUIGenerator darkButtonWithTitle:@"换绑"];
        _changeBindingBtn.backgroundColor = [UIColor redColor];
        [_changeBindingBtn addTarget:self action:@selector(changeBindingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeBindingBtn;
}

- (UIButton *)unchangeBindingBtn {
    if (!_unchangeBindingBtn) {
        _unchangeBindingBtn = [XYPHBindAccountUIGenerator darkButtonWithTitle:@"暂不换绑"];
        _unchangeBindingBtn.backgroundColor = [UIColor lightGrayColor];
        [_unchangeBindingBtn addTarget:self action:@selector(unchangeBindingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _unchangeBindingBtn;
}

@end
