//
//  TimerClass.m
//  FormView
//
//  Created by 黄伯驹 on 12/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "TimerClass.h"

@interface NSTimer(EOCBlocksSupport)

+ (NSTimer *)eoc_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                          block:(void(^)(void))block
                                        repeats:(BOOL)repeats;

@end

@implementation NSTimer(EOCBlocksSupport)

+ (NSTimer *)eoc_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                          block:(void (^)(void))block
                                        repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(eoc_blockInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)eoc_blockInvoke:(NSTimer *)timer {
    void (^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}

@end

@interface TimerClass()

@property (nonatomic, strong) NSTimer *pollTimer;

@end

@implementation TimerClass

- (void)dealloc {
    [self.pollTimer invalidate];
}

- (void)startPolling {
    __weak typeof(self) weakself = self;
    self.pollTimer = [NSTimer eoc_scheduledTimerWithTimeInterval:1 block:^{
        [weakself p_doPoll];
    } repeats:YES];
}

- (void)p_doPoll {
    NSLog(@"%s", __FUNCTION__);
}

- (void)stopPolling {
    
}

@end
