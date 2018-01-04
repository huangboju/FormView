//
//  SignUpController.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "SignUpController.h"

#import "AccountFieldCell.h"
#import "AccountTitleCell.h"
#import "ButtonCell.h"
#import "LicenseCell.h"

@interface SignUpController ()<ButtonCellActionable>

@end

@implementation SignUpController

- (void)initSubviews {
    AccountCellItem *accountItem = [[AccountCellItem alloc] init];
    accountItem.placeholder = @"请输入登录账号";

    AccountTitleCellItem *accountTitleCellItem = [[AccountTitleCellItem alloc] init];
    accountTitleCellItem.text = @"Moible Number";

    ButtonCellItem *buttonCellItem = [[ButtonCellItem alloc] init];
    buttonCellItem.title = @"下一步";

    self.form = @[
                  @[
                      [[Row alloc] initWithClass:[AccountTitleCell class] model:accountTitleCellItem],
                      [[Row alloc] initWithClass:[AccountFieldCell class] model:accountItem],
                      [[Row alloc] initWithClass:[ButtonCell class] model:buttonCellItem],
                      [[Row alloc] initWithClass:[LicenseCell class]]
                      ]
                  ];
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"class = %@   %@", self.classForCoder, sender.currentTitle);
}
@end
