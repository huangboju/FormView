//
//  MTDevStorage.h
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kShakeSwitchKey;

extern NSString * const kMTDevIsShow;

/// 前贴广告开关
extern NSString * const kPreStickySwitchKey;

/// 闪屏开关
extern NSString * const kSplashSwitchKey;

/// 闪屏DEBUG开关
extern NSString * const kSplashDebugKey;

/// 动态激励广告Debug开关
extern NSString * const gDKRewardAdDebugKey;

@interface MTDevStorage : NSObject

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName;

+ (BOOL)boolForKey:(NSString *)defaultName;

+ (void)removeObjectForKey:(NSString *)defaultName;

@end

NS_ASSUME_NONNULL_END
