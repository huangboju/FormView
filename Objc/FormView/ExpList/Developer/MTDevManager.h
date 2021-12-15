//
//  MTDevManager.h
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/4/25.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// MTDevManager
@interface MTDevManager : NSObject

/// sharedInstance
+ (instancetype)sharedInstance;

/// 已经显示Dev模块
@property (nonatomic, assign) BOOL isShowed;

@end

NS_ASSUME_NONNULL_END
