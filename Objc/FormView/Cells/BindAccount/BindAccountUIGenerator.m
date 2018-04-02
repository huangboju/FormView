//
//  BindAccountUIGenerator.m
//  FormView
//
//  Created by 黄伯驹 on 28/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "BindAccountUIGenerator.h"

@implementation BindAccountUIGenerator

+ (UIButton *)darkButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.cornerRadius = 8;
    return button;
}

+ (UserCardView *)userCardViewWithItem:(UserCardCellItem *)item {
    UserCardView *userCardView = [UserCardView new];
    userCardView.backgroundColor = [UIColor whiteColor];
    userCardView.layer.cornerRadius = 4;
    [userCardView updateViewData:item];
    return userCardView;
}

@end
