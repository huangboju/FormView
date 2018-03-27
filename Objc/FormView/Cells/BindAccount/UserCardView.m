//
//  UserCardView.m
//  FormView
//
//  Created by xiAo_Ju on 27/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "UserCardView.h"

#import "ImageTextView.h"

#import <FDStackView.h>
#import <Masonry.h>

#import "UserCardCellItem.h"

@interface UserCardView()

@property (nonatomic, strong) UIImageView *avatarView;

@property (nonatomic, strong) UILabel *bindStatusLabel;

@property (nonatomic, strong) ImageTextView *nickNameTextView;

@property (nonatomic, strong) UILabel *joinTimeLabel;

@property (nonatomic, strong) UIButton *bindStatusButton;

@end

@implementation UserCardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self addSubview:self.avatarView];
        [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(64);
            make.centerY.mas_equalTo(0);
            make.leading.mas_equalTo(25);
        }];
        
        [self addSubview:self.bindStatusLabel];
        [self.bindStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(-10);
            make.top.mas_equalTo(18);
            make.width.mas_equalTo(56);
            make.height.mas_equalTo(18);
        }];
        
        NSArray *subviews = @[
                              self.nickNameTextView,
                              self.joinTimeLabel,
                              self.bindStatusButton
                              ];
        
        FDStackView *stackView = [[FDStackView alloc] initWithArrangedSubviews:subviews];
        stackView.spacing = 10;
        stackView.distribution = UIStackViewDistributionFillEqually;
        stackView.axis = UILayoutConstraintAxisVertical;
        stackView.alignment = UIStackViewAlignmentLeading;
        [self addSubview:stackView];
        [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.avatarView);
            make.centerY.mas_equalTo(0);
            make.leading.mas_equalTo(self.avatarView.mas_trailing).offset(20);
        }];
    }
    return self;
}

- (void)updateViewData:(UserCardCellItem *)viewData {
    
    UIColor *bindStatusLabelColor;
    
    if (viewData.isBinding) {
        self.bindStatusLabel.text = @"当前绑定";
        bindStatusLabelColor = [UIColor redColor];
    } else {
        self.bindStatusLabel.text = @"当前登录";
        bindStatusLabelColor = [UIColor lightGrayColor];
    }
    
    self.bindStatusLabel.layer.borderColor = bindStatusLabelColor.CGColor;
    self.bindStatusLabel.textColor = bindStatusLabelColor;
    
    self.nickNameTextView.text = @"小姐姐";
    self.joinTimeLabel.text = @"2017.12.31 加入小红书";
}

#pragma mark - Action
- (void)showAccountBindStatus:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    [self.delegate userCardView:self didSelect:sender.selected];
}

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [UIImageView new];
        _avatarView.contentMode = UIViewContentModeScaleAspectFit;
        _avatarView.layer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
        _avatarView.layer.cornerRadius = 32;
    }
    return _avatarView;
}

- (UILabel *)bindStatusLabel {
    if (!_bindStatusLabel) {
        _bindStatusLabel = [UILabel new];
        _bindStatusLabel.font = [UIFont systemFontOfSize:11];
        _bindStatusLabel.textAlignment = NSTextAlignmentCenter;
        _bindStatusLabel.layer.borderWidth = 0.5;
        _bindStatusLabel.layer.cornerRadius = 2;
    }
    return _bindStatusLabel;
}

- (ImageTextView *)nickNameTextView {
    if (!_nickNameTextView) {
        _nickNameTextView = [ImageTextView new];
        _nickNameTextView.imagePosition = ImageTextViewPositionRight;
        _nickNameTextView.textFont = [UIFont boldSystemFontOfSize:15];
    }
    return _nickNameTextView;
}

- (UILabel *)joinTimeLabel {
    if (!_joinTimeLabel) {
        _joinTimeLabel = [UILabel new];
        _joinTimeLabel.font = [UIFont systemFontOfSize:11];
    }
    return _joinTimeLabel;
}

- (UIButton *)bindStatusButton {
    if (!_bindStatusButton) {
        _bindStatusButton = [UIButton new];
        _bindStatusButton.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        _bindStatusButton.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        _bindStatusButton.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        _bindStatusButton.adjustsImageWhenHighlighted = NO;
        //        button.semanticContentAttribute = .forceRightToLeft iOS 9
        //        CGFloat spacing = 5;
        //        _bindStatusButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
        //        _bindStatusButton.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
        [_bindStatusButton setImage:[UIImage imageNamed:@"icon_downarrow_grey_17"] forState:UIControlStateNormal];
        [_bindStatusButton setImage:[UIImage imageNamed:@"icon_uparrow_grey_17"] forState:UIControlStateSelected];
        [_bindStatusButton setTitle:@"账号已绑定状态  " forState:UIControlStateNormal];
        [_bindStatusButton setTitleColor:[UIColor colorWithWhite:0.7 alpha:1] forState:UIControlStateNormal];
        _bindStatusButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [_bindStatusButton addTarget:self action:@selector(showAccountBindStatus:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _bindStatusButton;
}

@end
