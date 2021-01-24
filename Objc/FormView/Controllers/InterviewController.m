//
//  InterViewController.m
//  FormView
//
//  Created by jourhuang on 2021/1/24.
//  Copyright © 2021 黄伯驹. All rights reserved.
//

#import "InterviewController.h"

#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")

#endif
#endif

@interface InterviewController ()

@property (nonatomic, copy) dispatch_block_t block;

@end

@implementation InterviewController

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;

    @weakify(self);
    self.block = ^{
        @strongify(self);
        [self excuteSome:^{
            NSLog(@"%@", self);
        }];
    };

    self.block();
    
    [self threadTest];
}

- (void)excuteSome:(dispatch_block_t)block {
    NSLog(@"%s", __FUNCTION__);
    block();
}

- (void)threadTest {
    dispatch_queue_t other_thread = dispatch_queue_create("mythread", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t other_thread = dispatch_queue_create("mythread", NULL);
    NSLog(@"1");
    dispatch_async(other_thread, ^{
        NSLog(@"2====%@", NSThread.currentThread);
    });
    dispatch_sync(other_thread, ^{
        NSLog(@"3");
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"4");
    });
    NSLog(@"5");
}

@end
