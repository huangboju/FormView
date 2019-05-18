//
//  XYPHSearchFilterDismissPanGestureRecognizer.m
//  AFNetworking
//
//  Created by 黄伯驹 on 2018/7/9.
//

#import "XYPHSearchFilterDismissPanGestureRecognizer.h"

@interface XYPHSearchFilterDismissPanGestureRecognizer()

@property (nonatomic, strong) XYPHSearchFilterDismissAnimator *dismissAnimator;

@property (nonatomic, copy) void (^beginHandleBlock)(XYPHSearchFilterDismissAnimator *) ;

@end

@implementation XYPHSearchFilterDismissPanGestureRecognizer

+ (instancetype)gestureBeginHandleBlock:(void (^)(XYPHSearchFilterDismissAnimator *))beginHandleBlock {
    XYPHSearchFilterDismissPanGestureRecognizer *pan = [XYPHSearchFilterDismissPanGestureRecognizer new];
    pan.beginHandleBlock = beginHandleBlock;
    return pan;
}

- (instancetype)init {
    if (self = [super init]) {
        [self addTarget:self action:@selector(panGestureCallback:)];
    }
    return self;
}

- (void)panGestureCallback:(UIPanGestureRecognizer *)panGesture {
    CGFloat progress = [panGesture translationInView:panGesture.view].x / panGesture.view.bounds.size.width;
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        [self.dismissAnimator begin];
        if (self.beginHandleBlock) {
            self.beginHandleBlock(self.dismissAnimator);
        }
    } else if (panGesture.state == UIGestureRecognizerStateChanged) {
        [self.dismissAnimator updateInteractiveTransition:progress];
    } else if (panGesture.state == UIGestureRecognizerStateCancelled || panGesture.state == UIGestureRecognizerStateEnded) {
        if (progress > 0.2) {
            if (self.finishHandleBlock) {
                self.finishHandleBlock();
            }
            [self.dismissAnimator finish];
        } else {
            [self.dismissAnimator cancel];
        }
        [self.dismissAnimator invalidate];
    }
}

- (XYPHSearchFilterDismissAnimator *)dismissAnimator {
    if (!_dismissAnimator) {
        _dismissAnimator = [XYPHSearchFilterDismissAnimator new];
    }
    return _dismissAnimator;
}

@end
