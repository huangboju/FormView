//
//  SignInController.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "SignInController.h"

#import "AccountFieldCell.h"
#import "AccountTitleCell.h"
#import "ButtonCell.h"
#import "PasswordLoginCell.h"
#import "AccountButtonCell.h"

@interface SignInController ()<ButtonCellActionable>

@end

@implementation SignInController

- (void)initSubviews {

    // 去掉顶部sectionHeader
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];

    AccountCellItem *accountItem = [[AccountCellItem alloc] init];
    accountItem.placeholder = @"请输入登录账号";

    AccountTitleCellItem *accountTitleCellItem = [[AccountTitleCellItem alloc] init];
    accountTitleCellItem.text = @"Sign In";

    ButtonCellItem *buttonCellItem = [[ButtonCellItem alloc] init];
    buttonCellItem.title = @"下一步";

    self.form = @[
                  @[
                      [[Row alloc] initWithClass:[AccountFieldCell class] model:accountItem],
                      [[Row alloc] initWithClass:[AccountFieldCell class] model:accountItem],
                      [[Row alloc] initWithClass:[AccountTitleCell class] model:accountTitleCellItem],
                      [[Row alloc] initWithClass:[PasswordLoginCell class]],
                      [[Row alloc] initWithClass:[ButtonCell class] model:buttonCellItem],
                      [[Row alloc] initWithClass:[AccountButtonCell class] model:buttonCellItem],
                      ]
                  ];
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"class = %@   %@", self.classForCoder, sender.currentTitle);
}

@end
