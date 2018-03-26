//
//  UserCardCell.m
//  FormView
//
//  Created by xiAo_Ju on 23/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "UserCardCell.h"

#import "ImageTextView.h"

#import <FDStackView.h>
#import <Masonry.h>

@implementation UserCardCellItem

@end

@interface UserCardCell()

@property (nonatomic, strong) UIView *wrapperView;

@property (nonatomic, strong) UIImageView *avatarView;

@property (nonatomic, strong) UILabel *bindStatusLabel;

@property (nonatomic, strong) ImageTextView *nickNameTextView;

@property (nonatomic, strong) UILabel *joinTimeLabel;

@property (nonatomic, strong) UIButton *bindStatusButton;

@end


@implementation UserCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.wrapperView];
        [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(38);
            make.height.mas_equalTo(100);
            make.top.bottom.centerX.mas_equalTo(0);
        }];
        
        [self.wrapperView addSubview:self.avatarView];
        [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(64);
            make.centerY.mas_equalTo(0);
            make.leading.mas_equalTo(25);
        }];
        
        [self.wrapperView addSubview:self.bindStatusLabel];
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
        [self.wrapperView addSubview:stackView];
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

- (UIView *)wrapperView {
    if (!_wrapperView) {
        _wrapperView = [UIView new];
        _wrapperView.backgroundColor = [UIColor whiteColor];
        _wrapperView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _wrapperView.layer.cornerRadius = 4;
        _wrapperView.layer.shadowOpacity = 0.8f;
        _wrapperView.layer.shadowOffset = CGSizeMake(0, 2);
    }
    return _wrapperView;
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
        [_bindStatusButton setTitle:@"账号已绑定状态" forState:UIControlStateNormal];
        [_bindStatusButton setTitleColor:[UIColor colorWithWhite:0.7 alpha:1] forState:UIControlStateNormal];
        _bindStatusButton.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    
    return _bindStatusButton;
}

@end
