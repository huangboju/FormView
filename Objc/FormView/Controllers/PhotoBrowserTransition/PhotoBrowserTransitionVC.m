//
//  PhotoBrowserTransitionVC.m
//  FormView
//
//  Created by 黄伯驹 on 2020/3/5.
//  Copyright © 2020 黄伯驹. All rights reserved.
//

#import "PhotoBrowserTransitionVC.h"

#import "PhotoBrowserInteractionDismissTransition.h"

@interface PhotoBrowserTransitionDetailVC: UIViewController

@property (nonatomic, strong) PhotoBrowserInteractionDismissTransition *transition;

@end

@implementation PhotoBrowserTransitionDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:pan];
    
    _transition = PhotoBrowserInteractionDismissTransition.new;
    self.transitioningDelegate = self.transition;
}

- (void)panGesture:(UIPanGestureRecognizer *)sender {
    CGFloat progress = [sender translationInView:sender.view].y / sender.view.bounds.size.height;
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self.transition begin];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        [self.transition updateInteractiveTransition:progress];
    } else if (sender.state == UIGestureRecognizerStateCancelled || sender.state == UIGestureRecognizerStateEnded) {
        if (progress >= 0.3) {
            [self.transition finish];
        } else {
            [self.transition cancel];
        }
        [self.transition invalidate];
    }
}

@end


@interface PhotoBrowserTransitionVC ()

@end

@implementation PhotoBrowserTransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    PhotoBrowserTransitionDetailVC *detailVC = PhotoBrowserTransitionDetailVC.new;
    detailVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:detailVC animated:YES completion:nil];
}

@end
