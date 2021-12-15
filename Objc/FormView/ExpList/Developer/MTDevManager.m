//
//  MTDevManager.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/4/25.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//


#import "MTDevManager.h"

// MTDevManager
@implementation MTDevManager

+ (instancetype)sharedInstance {
    static MTDevManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
