//
//  PasswordSignInController.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "PasswordSignInController.h"

#import "AccountFieldCell.h"
#import "AccountTitleCell.h"
#import "ButtonCell.h"
#import "PasswordFieldCell.h"
#import "PasswordLoginCell.h"

@interface PasswordSignInController ()<ButtonCellActionable>

@end

@implementation PasswordSignInController

- (void)initSubviews {
    AccountCellItem *accountItem = [[AccountCellItem alloc] init];
    accountItem.placeholder = @"请输入登录账号";

    AccountTitleCellItem *accountTitleCellItem = [[AccountTitleCellItem alloc] init];
    accountTitleCellItem.text = @"Password SignIn";

    ButtonCellItem *buttonCellItem = [[ButtonCellItem alloc] init];
    buttonCellItem.title = @"登录";

    PasswordCellItem *passwordCellItem = [[PasswordCellItem alloc] init];
    passwordCellItem.placeholder = @"Password";

    self.form = @[
                  @[
                      [[Row alloc] initWithClass:[AccountTitleCell class] model:accountTitleCellItem],
                      [[Row alloc] initWithClass:[AccountFieldCell class] model:accountItem],
                      [[Row alloc] initWithClass:[PasswordFieldCell class] model:passwordCellItem],
                      [[Row alloc] initWithClass:[ButtonCell class] model:buttonCellItem],
                      [[Row alloc] initWithClass:[PasswordLoginCell class]]
                      ]
                  ];
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"class = %@   %@", self.classForCoder, sender.currentTitle);
}

@end
