//
//  UIViewController+Convenience.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/2/20.
//

#import "UIViewController+Convenience.h"

@implementation UIViewController (Convenience)

- (UIViewController *)visibleViewController {
    if (self.presentedViewController == nil) {
        return self;
    }
    if ([self.presentedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)self.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [lastViewController visibleViewController];
    }
    if ([self.presentedViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)self.presentedViewController;
        UIViewController *selectedViewController = tabBarController.selectedViewController;
        
        return [selectedViewController visibleViewController];
    }

    UIViewController *presentedViewController = (UIViewController *)self.presentedViewController;
    
    return [presentedViewController visibleViewController];
}

- (void)showComingSoonAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"拼命开发中，敬请期待。。。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
