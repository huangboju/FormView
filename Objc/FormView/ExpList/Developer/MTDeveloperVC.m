//
//  MTDeveloperVC.m
//  Pods-MTDeveloperModule_Example
//
//  Created by xiAo-Ju on 2021/2/19.
//

#import "MTDeveloperVC.h"

#import "MTDevTitleCell.h"
#import "MTDevSwitchCell.h"
#import "MTDevButtonCell.h"

#import "MTDevStorage.h"

#import "MTDevSplashVC.h"
#import "MTExpListVC.h"
#import "UIViewController+Convenience.h"

/// 动态激励广告DEBUG文案
static NSString * const gDKRewardAdDebugText = @"动态激励广告DEBUG开关";

@interface MTDeveloperVC ()
<
UITableViewDelegate,
MTDevSwitchCellDelegate
>

@end

@implementation MTDeveloperVC

- (void)initSubviews {
    
    NSMutableArray *form = NSMutableArray.array;
    
    #ifdef DEBUG
    NSArray <NSDictionary *> *sections = @[
        @{
            @"闪屏": @"showSplash"
        },
        @{
            @"Alpha（一个牛逼的开发者工具）": @"showAlpha"
        },
        @{
            @"无极配置列表": @"showExpList"
        }
    ];
    
    for (NSDictionary *section in sections) {
        NSMutableArray *rows = [NSMutableArray array];
        for (NSString *key in section) {
            MTDevTitleCellItem *item = [[MTDevTitleCellItem alloc] init];
            [item addTitle:key];
            [item addSelector:NSSelectorFromString(section[key])];
            [rows addObject:[MTDevRow rowWithClass:MTDevTitleCell.class model:item]];
        }
        [form addObject:rows];
    }

    MTDevSwitchCellItem *item = [self switchItemWithTitle:@"摇一摇进入开发者模式"];
    [form addObject:@[[MTDevRow rowWithClass:MTDevSwitchCell.class model:item]]];

    MTDevSwitchCellItem *preStickyitem = [self switchItemWithTitle:@"关闭前贴广告"];

    MTDevSwitchCellItem *splashitem = [self switchItemWithTitle:@"关闭闪屏广告"];
    [splashitem addIsOn:[MTDevStorage boolForKey:kSplashSwitchKey]];

    [form addObject:@[
        [MTDevRow rowWithClass:MTDevSwitchCell.class model:preStickyitem],
        [MTDevRow rowWithClass:MTDevSwitchCell.class model:splashitem]
    ]];
    
    #endif
    
    MTDevSwitchCellItem *debugItem = [self switchItemWithTitle:@"闪屏轻互动彩蛋DEBUG开关"];
    [form addObject:@[[MTDevRow rowWithClass:MTDevSwitchCell.class model:debugItem]]];
    
    MTDevSwitchCellItem *dkRewardItem = [self switchItemWithTitle:gDKRewardAdDebugText];
    [form addObject:@[[MTDevRow rowWithClass:MTDevSwitchCell.class model:dkRewardItem]]];

    MTDevButtonCellItem *buttonItem = [[MTDevButtonCellItem alloc] init];
    [buttonItem addTitle:@"关 闭"];
    [buttonItem addSelector:@selector(closeButtonClicked)];
    [buttonItem addTitleColor:UIColor.redColor];
    [form addObject:@[[MTDevRow rowWithClass:MTDevButtonCell.class model:buttonItem]]];

    self.form = form.copy;

    self.tableView.delegate = self;
    self.tableView.rowHeight = 66;
}

- (void)closeButtonClicked {
    if (self.presentingViewController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)showSplash {
    [self showViewController:MTDevSplashVC.new sender:nil];
}

- (void)showAlpha {
    
}

- (void)showExpList {
    [self showViewController:MTExpListVC.new sender:nil];
}

#pragma mark <MTDevSwitchCellDelegate>
- (void)switchCellSwitchViewValueChanged:(MTDevSwitchCell *)cell {
    [MTDevStorage setBool:cell.switchView.isOn forKey:self.switchKeyMap[cell.viewData.title]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MTDevTitleCellItem *item = [self rowAtIndexPath:indexPath].model;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:item.selector];
#pragma clang diagnostic pop
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (MTDevSwitchCellItem *)switchItemWithTitle:(NSString *)title {
    MTDevSwitchCellItem *item = [[MTDevSwitchCellItem alloc] init];
    [item addTitle:title];
    [item addIsOn:[MTDevStorage boolForKey:self.switchKeyMap[title]]];
    return item;
}

- (NSDictionary *)switchKeyMap {
    return @{
        @"摇一摇进入开发者模式": kShakeSwitchKey,
        @"关闭前贴广告": kPreStickySwitchKey,
        @"关闭闪屏广告": kSplashSwitchKey,
        @"闪屏轻互动彩蛋DEBUG开关": kSplashDebugKey,
        gDKRewardAdDebugText: gDKRewardAdDebugKey,
    };
}

@end
