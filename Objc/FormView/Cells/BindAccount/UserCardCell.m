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


@interface UserCardCell()

@property (nonatomic, strong) UserCardView *userCardView;


@end


@implementation UserCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.userCardView];
        [self.userCardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(38);
            make.height.mas_equalTo(100);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

#pragma mark - UserCardViewActionable


- (void)updateViewData:(UserCardCellItem *)viewData {
    [self.userCardView updateViewData:viewData];
}

- (UserCardView *)userCardView {
    if (!_userCardView) {
        _userCardView = [UserCardView new];
        _userCardView.backgroundColor = [UIColor whiteColor];
        _userCardView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _userCardView.layer.cornerRadius = 4;
        _userCardView.layer.shadowOpacity = 0.8f;
        _userCardView.layer.shadowOffset = CGSizeMake(0, 2);
    }
    return _userCardView;
}

@end
