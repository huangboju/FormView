//
//  XYPHSearchFilterDismissPanGestureRecognizer.m
//  AFNetworking
//
//  Created by 黄伯驹 on 2018/7/9.
//

#import "XYPHSearchDismissPanGestureRecognizer.h"

@interface XYPHSearchDismissPanGestureRecognizer()

@property (nonatomic, strong) XYPHSearchInteractionDismissAnimator *dismissAnimator;

@property (nonatomic, copy) void (^beginHandleBlock)(XYPHSearchInteractionDismissAnimator *) ;

@end

@implementation XYPHSearchDismissPanGestureRecognizer

+ (instancetype)gestureBeginHandleBlock:(void (^)(XYPHSearchInteractionDismissAnimator *))beginHandleBlock {
    XYPHSearchDismissPanGestureRecognizer *pan = [XYPHSearchDismissPanGestureRecognizer new];
    pan.beginHandleBlock = beginHandleBlock;
    return pan;
}

- (instancetype)init {
    if (self = [super init]) {
        self.edges = UIRectEdgeLeft;
        [self addTarget:self action:@selector(panGestureCallback:)];
    }
    return self;
}

- (void)panGestureCallback:(XYPHSearchDismissPanGestureRecognizer *)panGesture {
    CGFloat progress = [panGesture translationInView:panGesture.view].x / panGesture.view.bounds.size.width;
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        [self.dismissAnimator begin];
        if (self.beginHandleBlock) {
            self.beginHandleBlock(self.dismissAnimator);
        }
    } else if (panGesture.state == UIGestureRecognizerStateChanged) {
        [self.dismissAnimator updateInteractiveTransition:progress];
    } else if (panGesture.state == UIGestureRecognizerStateCancelled || panGesture.state == UIGestureRecognizerStateEnded) {
        if (progress >= 0.5) {
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

- (XYPHSearchInteractionDismissAnimator *)dismissAnimator {
    if (!_dismissAnimator) {
        _dismissAnimator = [XYPHSearchInteractionDismissAnimator new];
    }
    return _dismissAnimator;
}

@end
