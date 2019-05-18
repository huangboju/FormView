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

    AccountXYPHBindAccountTitleCellItem *accountXYPHBindAccountTitleCellItem = [[AccountXYPHBindAccountTitleCellItem alloc] init];
    accountXYPHBindAccountTitleCellItem.text = @"Password SignIn";

    ButtonCellItem *buttonCellItem = [[ButtonCellItem alloc] init];
    buttonCellItem.title = @"登录";

    PasswordCellItem *passwordCellItem = [[PasswordCellItem alloc] init];
    passwordCellItem.placeholder = @"Password";

    self.form = @[
                  @[
                      [XYRow rowWithClass:AccountTitleCell.class model:accountXYPHBindAccountTitleCellItem],
                      [XYRow rowWithClass:AccountFieldCell.class model:accountItem],
                      [XYRow rowWithClass:PasswordFieldCell.class model:passwordCellItem],
                      [XYRow rowWithClass:ButtonCell.class model:buttonCellItem],
                      [XYRow rowWithClass:[PasswordLoginCell class]]
                      ]
                  ];
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"class = %@   %@", self.classForCoder, sender.currentTitle);
}

@end
