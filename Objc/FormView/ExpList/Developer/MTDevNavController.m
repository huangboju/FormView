//
//  MTDevNavController.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/4/22.
//

#import "MTDevNavController.h"

#import "UIViewController+Convenience.h"

#import "MTDevStorage.h"
#import "MTDeveloperVC.h"

#import "MTDevStorage.h"
#import "MTDevManager.h"

@interface MTDevNavController ()

@end

@implementation MTDevNavController

- (void)dealloc {
    MTDevManager.sharedInstance.isShowed = NO;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        MTDevManager.sharedInstance.isShowed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (void)showIfNeeded {
//    BOOL isShakeShow = [MTDevStorage boolForKey:kShakeSwitchKey];
    BOOL isShakeShow = YES;
    if (isShakeShow) {
        BOOL isShowed = MTDevManager.sharedInstance.isShowed;
        if (isShowed) { return; }

        MTDevNavController *nav = [[MTDevNavController alloc] initWithRootViewController:MTDeveloperVC.new];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;

        UIViewController *rootVC = UIApplication.sharedApplication.keyWindow.rootViewController;
        [rootVC.visibleViewController showDetailViewController:nav sender:nil];
    }
}

@end
