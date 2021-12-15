//
//  AppDelegate.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "AppDelegate.h"

#import "NetworkServicer.h"

// https://www.jianshu.com/p/740233c2d638
typedef NS_OPTIONS(NSUInteger, Test) {
    TestA = 1 << 0,
    TestB = 1 << 1,
    TestC = 1 << 2,
    TestD = 1 << 3
};

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NetworkServicer initCronet];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [NetworkServicer stopNetLog];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [NetworkServicer startNetLogToFile];
}


@end
