//
//  MTDevStorage.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/2/20.
//

#import "MTDevStorage.h"

NSString * const kShakeSwitchKey = @"kShakeSwitchKey";

NSString * const kMTDevIsShow = @"kMTDevIsShow";

/// 前贴广告开关
NSString * const kPreStickySwitchKey = @"kPreStickySwitchKey";

/// 闪屏开关
NSString * const kSplashSwitchKey = @"kSplashSwitchKey";

/// 闪屏DEBUG开关
NSString * const kSplashDebugKey = @"kSplashDebugKey";

/// 动态激励广告Debug开关
NSString * const gDKRewardAdDebugKey = @"gDKRewardAdDebugKey";

@implementation MTDevStorage

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName {
    [NSUserDefaults.standardUserDefaults setBool:value forKey:defaultName];
}

+ (BOOL)boolForKey:(NSString *)defaultName {
    return [NSUserDefaults.standardUserDefaults boolForKey:defaultName];
}

+ (void)removeObjectForKey:(NSString *)defaultName {
    [NSUserDefaults.standardUserDefaults removeObjectForKey:defaultName];
}

@end
