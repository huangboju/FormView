//
//  MainViewController.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "MainViewController.h"
#import "MainCell.h"

#import "SignInController.h"
#import "PasswordSignInController.h"
#import "SignUpController.h"
#import "MessageCenterController.h"
#import "EnptyViewController.h"
#import "SegmentController.h"
#import "EffectButtonController.h"
#import "ScrollAnimationController.h"

#import "IntroController.h"

@interface MainViewController ()<UITableViewDelegate>

@end

@implementation MainViewController

- (void)initSubviews {
    
    
    NSArray <NSArray <Class>*>*classes = @[
                         @[
                             [SignInController class],
                             [PasswordSignInController class],
                             [SignUpController class]
                             ],
                         @[
                             [MessageCenterController class]
                             ],
                         @[
                             [EnptyViewController class]
                             ],
                         @[
                             [SegmentController class]
                             ],
                         @[
                             [EffectButtonController class]
                             ],
                         @[
                             [IntroController class]
                             ],
                         @[
                             [ScrollAnimationController class]
                             ],
                         ];

    NSMutableArray *sections = [NSMutableArray array];

    for (NSArray <Class>*section in classes) {
        NSMutableArray *rows = [NSMutableArray array];
        for (Class cls in section) {
            [rows addObject:[[Row alloc] initWithClass:[MainCell class] model:[NSString stringWithFormat:@"%@", cls]]];
        }
        [sections addObject:rows];
    }

    self.form = sections;

    self.tableView.delegate = self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Row *row = [self rowAtIndexPath:indexPath];
    NSString *clsName = row.model;
    UIViewController *vc = [[NSClassFromString(clsName) alloc] init];
    vc.title = clsName;
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
