//
//  BindAccountUIGenerator.m
//  FormView
//
//  Created by 黄伯驹 on 28/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "BindAccountUIGenerator.h"

@implementation BindAccountUIGenerator

+ (UILabel *)titleLabelWithTitle:(NSString *)title {
    UILabel *titleLabel = [UILabel new];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    return titleLabel;
}

+ (UserCardView *)userCardViewWithItem:(UserCardCellItem *)item {
    UserCardView *userCardView = [UserCardView new];
    userCardView.backgroundColor = [UIColor whiteColor];
    userCardView.layer.cornerRadius = 4;
    [userCardView updateViewData:item];
    return userCardView;
}

+ (BindStatusView *)bindStatusViewWithItem:(NSArray<BindStatusViewItem *> *)item {
    BindStatusView *bindStatusView = [BindStatusView new];
    bindStatusView.backgroundColor = [UIColor whiteColor];
    bindStatusView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    bindStatusView.layer.cornerRadius = 4;
    bindStatusView.layer.shadowOpacity = 0.8f;
    bindStatusView.layer.shadowOffset = CGSizeMake(0, 2);
    NSArray *icontypes = @[
                           @"qq",
                           @"weixin",
                           @"weibo",
                           @"facebook",
                           @"mobile"
                           ];
    
    NSMutableArray *items = [NSMutableArray array];
    for (NSString *icontype in icontypes) {
        BindStatusViewItem *item = [BindStatusViewItem new];
        item.text = icontype;
        item.socialType = icontype;
        [items addObject:item];
    }
    [bindStatusView updateViewData:items];
    return bindStatusView;
}

@end
