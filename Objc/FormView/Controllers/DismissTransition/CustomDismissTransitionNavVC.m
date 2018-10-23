//
//  CustomDismissTransitionNavVC.m
//  FormView
//
//  Created by xiAo_Ju on 2018/9/4.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "CustomDismissTransitionNavVC.h"

#import "XYPHSearchDismissPanGestureRecognizer.h"

#import "CustomDismissTransitionVC.h"

@interface CustomDismissTransitionNavVC ()

@end

@implementation CustomDismissTransitionNavVC

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) weakself = self;
    XYPHSearchDismissPanGestureRecognizer *screenPan = [XYPHSearchDismissPanGestureRecognizer gestureBeginHandleBlock:^(XYPHSearchInteractionDismissAnimator *animator) {
        weakself.transitioningDelegate = animator;
        [weakself dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.view addGestureRecognizer:screenPan];
}

@end
