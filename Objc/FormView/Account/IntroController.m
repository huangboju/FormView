//
//  IntroController.m
//  FormView
//
//  Created by 黄伯驹 on 16/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "IntroController.h"

#import "AccountButtonCell.h"
#import "WechatButtonCell.h"
#import "ThirdPartButtonCell.h"

#import <Masonry.h>

@interface IntroController ()
<
AccountButtonCellActionable,
WechatButtonCellActionable,
ThirdPartButtonCellActionable
>

@end

@implementation IntroController

- (void)initSubviews {

    // 去掉顶部sectionHeader
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;

    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    self.tableView.transform = CGAffineTransformMakeScale(1, -1);
    

    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    backgroundView.frame = self.view.frame;
    backgroundView.transform = CGAffineTransformMakeScale(1, -1);
    self.tableView.backgroundView = backgroundView;

    // 注意这里反转了UITableView
    
    self.form = @[
                  @[
                      [XYRow rowWithClass:ThirdPartButtonCell.class],
                      [XYRow rowWithClass:WechatButtonCell.class],
                      [XYRow rowWithClass:AccountButtonCell.class]
                      ]
                  ];
}

- (void)tableViewDidMoveToSuperView {
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tour_logo"]];
    [self.view addSubview:logoView];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(88);
        make.centerX.mas_equalTo(0);
    }];
}


#pragma mark - AccountButtonCellActionable

- (void)signInButtonAction:(UIButton *)sender {
    
}

- (void)signUpButtonAction:(UIButton *)sender {
    
}


#pragma mark - WechatButtonCellActionable

- (void)wechatButtonAction:(UIButton *)sender {
    
}


#pragma mark - ThirdPartButtonCellActionable
- (void)weiboButtonAction:(UIButton *)sender {
    
}

- (void)qqButtonAction:(UIButton *)sender {
    
}

- (void)facebookButtonAction:(UIButton *)sender {
    
}

@end
