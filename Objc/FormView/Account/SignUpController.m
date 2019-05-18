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

    AccountXYPHBindAccountTitleCellItem *accountXYPHBindAccountTitleCellItem = [[AccountXYPHBindAccountTitleCellItem alloc] init];
    accountXYPHBindAccountTitleCellItem.text = @"Moible Number";

    ButtonCellItem *buttonCellItem = [[ButtonCellItem alloc] init];
    buttonCellItem.title = @"下一步";

    self.form = @[
                  @[
                      [XYRow rowWithClass:AccountTitleCell.class model:accountXYPHBindAccountTitleCellItem],
                      [XYRow rowWithClass:AccountFieldCell.class model:accountItem],
                      [XYRow rowWithClass:ButtonCell.class model:buttonCellItem],
                      [XYRow rowWithClass:LicenseCell.class]
                      ]
                  ];
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"class = %@   %@", self.classForCoder, sender.currentTitle);
}
@end
