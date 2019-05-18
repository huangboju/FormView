//
//  XYPHSearchFilterScreenEdgePanGestureRecognizer.m
//  Prophets
//
//  Created by 黄伯驹 on 2018/6/20.
//  Copyright © 2018 XingIn. All rights reserved.
//

#import "XYPHSearchFilterScreenEdgePanGestureRecognizer.h"

@interface XYPHSearchFilterScreenEdgePanGestureRecognizer()

@property (nonatomic, copy) void (^beginHandleBlock)(XYPHSearchFilterPresentAnimator *) ;

@property (nonatomic, strong) XYPHSearchFilterPresentAnimator *presentAnimator;

@end

@implementation XYPHSearchFilterScreenEdgePanGestureRecognizer

+ (instancetype)gestureBeginHandleBlock:(void (^)(XYPHSearchFilterPresentAnimator *))beginHandleBlock {
    XYPHSearchFilterScreenEdgePanGestureRecognizer *edgePan = [XYPHSearchFilterScreenEdgePanGestureRecognizer new];
    edgePan.beginHandleBlock = beginHandleBlock;
    return edgePan;
}

- (instancetype)init {
    if (self = [super init]) {
        self.edges = UIRectEdgeRight;
        [self addTarget:self action:@selector(edgePanGesture:)];
    }
    return self;
}

- (void)edgePanGesture:(XYPHSearchFilterScreenEdgePanGestureRecognizer *)sender {
    CGFloat progress = -[sender translationInView:sender.view].x / sender.view.bounds.size.width;
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self.presentAnimator begin];
        if (self.beginHandleBlock) {
            self.beginHandleBlock(self.presentAnimator);
        }
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        [self.presentAnimator updateInteractiveTransition:progress];
    } else if (sender.state == UIGestureRecognizerStateCancelled || sender.state == UIGestureRecognizerStateEnded) {
        if (progress > 0.15) {
            if (self.finishHandleBlock) {
                self.finishHandleBlock();
            }
            [self.presentAnimator finish];
        } else {
            [self.presentAnimator cancel];
        }
        [self.presentAnimator invalidate];
    }
}

- (XYPHSearchFilterPresentAnimator *)presentAnimator {
    if (!_presentAnimator) {
        _presentAnimator = [XYPHSearchFilterPresentAnimator new];
    }
    return _presentAnimator;
}

- (XYPHSearchFilterPresentAnimator *)animator {
    return self.presentAnimator;
}

@end
