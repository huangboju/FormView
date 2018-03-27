//
//  UserCardCell.m
//  FormView
//
//  Created by xiAo_Ju on 23/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "UserCardCell.h"

#import "UserCardView.h"

#import <Masonry.h>

#import "UIView+Extension.h"

#import "UserCardCellItem.h"

@interface UserCardCell() <UserCardViewActionable>

@property (nonatomic, strong) UserCardView *userCardView;

@property (nonatomic, strong) UIView *bindStatusView;

@property (nonatomic, strong) UILabel *titleLabel;

@end


@implementation UserCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.userCardView];
        [self.userCardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(38);
            make.height.mas_equalTo(100);
            make.top.centerX.mas_equalTo(0);
        }];

        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(38);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.userCardView.mas_bottom).offset(40);
            make.bottom.mas_equalTo(-20);
        }];

        self.bindStatusView = [UIView new];
        self.bindStatusView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.bindStatusView];
        [self.bindStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.userCardView.mas_bottom);
            make.leading.mas_equalTo(47);
            make.height.mas_equalTo(0);
            make.bottom.mas_lessThanOrEqualTo(-20);
        }];
    }
    return self;
}

#pragma mark - UserCardViewActionable
- (void)userCardView:(UserCardView *)userCardView didSelect:(BOOL)isSelect {
    BOOL isShowing = isSelect;
    [UIView animateWithDuration:0.25 animations:^{
        self.titleLabel.alpha = isShowing ? 0 : 1;
        [self.bindStatusView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(isShowing ? 80 : 0);
        }];
        [self.contentView layoutIfNeeded];
    }];
}


- (void)updateViewData:(UserCardCellItem *)viewData {
    [self.userCardView updateViewData:viewData];
    self.titleLabel.text = viewData.title;
}

- (UserCardView *)userCardView {
    if (!_userCardView) {
        _userCardView = [UserCardView new];
        _userCardView.delegate = self;
        _userCardView.backgroundColor = [UIColor whiteColor];
        _userCardView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _userCardView.layer.cornerRadius = 4;
        _userCardView.layer.shadowOpacity = 0.8f;
        _userCardView.layer.shadowOffset = CGSizeMake(0, 2);
    }
    return _userCardView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
