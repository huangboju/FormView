//
//  MTDevSplashVC.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/2/19.
//

#import "MTDevSplashVC.h"

#import "MTDevTitleCell.h"
#import "MTDevSwitchCell.h"
#import "MTDevButtonCell.h"

#import "MTDevStorage.h"

#import "UIViewController+Convenience.h"

@interface MTDevSplashVC () <UITableViewDelegate>

@end

@implementation MTDevSplashVC

- (void)initSubviews {
    
    
    NSArray <NSDictionary *> *sections = @[
        @{
            @"预加载闪屏资源": @"preloadOrders"
        },
        @{
            @"热启动": @"hotLaunch",
            @"冷启动": @"coldLaunch",
        },
        @{
            @"普通闪屏": @"showNormalSplash",
            @"followU 闪屏": @"showFollowUSplash",
            @"OneShot 闪屏": @"showOneshotSplash",
            @"Oneshot Plus": @"showOneshotPlusSplash",
            @"闪屏轻互动": @"showLightinteractionSplash",
            @"闪屏cny": @"showCnySplash"
        }
    ];
    
    NSMutableArray *form = NSMutableArray.array;
    
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
    
    MTDevButtonCellItem *buttonItem = [[MTDevButtonCellItem alloc] init];
    [buttonItem addTitle:@"关 闭"];
    [buttonItem addSelector:@selector(closeButtonClicked)];
    [buttonItem addTitleColor:UIColor.redColor];
    [form addObject:@[[MTDevRow rowWithClass:MTDevButtonCell.class model:buttonItem]]];

    self.form = form.copy;

    self.tableView.delegate = self;
    self.tableView.rowHeight = 66;
}

- (void)preloadOrders {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [NSClassFromString(@"MTSplashSDK") performSelector:NSSelectorFromString(@"asyncPeloadSplashAdIfNeeded")];
#pragma clang diagnostic pop
}

- (void)hotLaunch {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL sel = NSSelectorFromString(@"sharedInstance");
    [[NSClassFromString(@"QLAppEnvMgr") performSelector:sel] performSelector:NSSelectorFromString(@"appWillResignActive:") withObject:nil];
    Class cls = NSClassFromString(@"MTSplashSDK");
    [cls performSelector:NSSelectorFromString(@"start")];
    [[cls performSelector:sel] performSelector:@selector(setValue:forKey:) withObject:@(-1) withObject:@"enterBackgroundTime"];
    [cls performSelector:NSSelectorFromString(@"showHotLaunchSplashIfNeeded:") withObject:nil];
#pragma clang diagnostic pop
}

- (void)coldLaunch {
    Class cls = NSClassFromString(@"MTSplashSDK");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [cls performSelector:NSSelectorFromString(@"start")];
    id<NSObject> (^linkAdBridgeBlock)(void) = ^id<NSObject>() {
        return [NSClassFromString(@"MTSplashLinkADManger") performSelector:NSSelectorFromString(@"shareInstance")];
    };
    dispatch_block_t complection = ^{
        
    };
    [cls performSelector:NSSelectorFromString(@"showColdLaunchSplashIfNeeded:linkAdBridgeBlock:")
              withObject:complection
              withObject:linkAdBridgeBlock];
#pragma clang diagnostic pop
}

- (void)showNormalSplash {
    [self showComingSoonAlert];
}

- (void)showFollowUSplash {
    [self showComingSoonAlert];
}

- (void)showOneshotSplash {
    [self showComingSoonAlert];
}

- (void)showOneshotPlusSplash {
    [self showComingSoonAlert];
}

- (void)showLightinteractionSplash {
    [self showComingSoonAlert];
}

- (void)showCnySplash {
    [self showComingSoonAlert];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MTDevTitleCellItem *item = [self rowAtIndexPath:indexPath].model;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:item.selector];
#pragma clang diagnostic pop
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)closeButtonClicked {
    if (self.presentingViewController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
