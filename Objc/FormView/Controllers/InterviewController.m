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

#import <Masonry/Masonry.h>

@interface InterviewController ()

@property (nonatomic, copy) dispatch_block_t block;

@end

@implementation InterviewController

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAlertView];
    
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

- (void)initAlertView {
    UIView *alertView = UIView.new;
    alertView.backgroundColor = UIColor.redColor;
    [self.view addSubview:alertView];
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(30);
        make.centerY.centerX.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    
    UILabel *textLabel = UILabel.new;
    textLabel.font = [UIFont monospacedDigitSystemFontOfSize:16 weight:UIFontWeightRegular];
    textLabel.backgroundColor = UIColor.yellowColor;
    textLabel.text = @"投票成功，获得一次摇一摇的机会，要马上使用吗？";
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    [alertView addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(20);
        make.centerX.centerY.mas_equalTo(0);
    }];
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
