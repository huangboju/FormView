//
//  AppDelegate.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "AppDelegate.h"

#import "NetworkServicer.h"
#import "NSString+LineSpacingFix.h"

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
//    [NetworkServicer initCronet];
    int asciiCode = 32;
    for (int i = 0; i < 95; i++) {
        NSString *string = [NSString stringWithFormat:@"%c", asciiCode + i];
        CGSize size = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) font:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium] lineSpacing:5];
        [self ouputDictWithStr:string size:size];
    }

    return YES;
}


- (void)ouputConditionWithStr:(NSString *)str size:(CGSize)size {
    NSLog(@"if ([string isEqualToString:@\"%@\"]) {", str);
    NSLog(@"return %f;", size.width);
    NSLog(@"}");
}

- (void)ouputDictWithStr:(NSString *)str size:(CGSize)size {
    NSLog(@"@\"%@\": @(%f),", str, size.width);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [NetworkServicer stopNetLog];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [NetworkServicer startNetLogToFile];
}


@end
