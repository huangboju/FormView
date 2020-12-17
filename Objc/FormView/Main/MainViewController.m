//
//  MainViewController.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "MainViewController.h"
#import "MainCell.h"

#import "SignInController.h"
#import "PasswordSignInController.h"
#import "SignUpController.h"
#import "MessageCenterController.h"
#import "EmptyViewController.h"
#import "SegmentController.h"
#import "EffectButtonController.h"
#import "ScrollAnimationController.h"
#import "InputBarController.h"
#import "StateMachineController.h"
#import "TimerController.h"
#import "XYPHBindAccountFailureController.h"

#import "IntroController.h"
#import "XYPHPhoneZonesVC.h"

#import "NewCardController.h"

#import "CustomSearchBarController.h"

#import "CustomDismissTransitionVC.h"
#import "ShapeMaskController.h"
#import "FilterRefactorVC.h"

#import "PhotoBrowser.h"
#import "PhotoBrowserTransitionVC.h"

#import "ALPHAManager.h"

#import "NetworkServicer.h"

@interface MainViewController ()<UITableViewDelegate>

@end

@implementation MainViewController

- (void)initSubviews {
    
    UIBarButtonItem *alpha = [[UIBarButtonItem alloc] initWithTitle:@"Alpha" style:UIBarButtonItemStylePlain target:self action:@selector(alphaButtonTapped:)];
    
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(refreshButtonTapped:)];
    
    self.navigationItem.rightBarButtonItems = @[
        alpha,
        refresh
    ];
    
    NSArray <NSArray <Class>*>*classes = @[
        @[
            [SignInController class],
            [PasswordSignInController class],
            [SignUpController class]
        ],
        @[
            [MessageCenterController class]
        ],
        @[
            [EmptyViewController class]
        ],
        @[
            [SegmentController class]
        ],
        @[
            [EffectButtonController class]
        ],
        @[
            [IntroController class]
        ],
        @[
            [ScrollAnimationController class]
        ],
        @[
            [InputBarController class]
        ],
        @[
            [XYPHPhoneZonesVC class]
        ],
        @[
            [StateMachineController class]
        ],
        @[
            [TimerController class]
        ],
        @[
            [CustomSearchBarController class]
        ],
        @[
            [XYPHBindAccountFailureController class]
        ],
        @[
            [NewCardController class]
        ],
        @[
            [CustomDismissTransitionVC class]
        ],
        @[
            [ShapeMaskController class]
        ],
        @[
            FilterRefactorVC.class
        ],
        @[
            PhotoBrowser.class,
            PhotoBrowserTransitionVC.class
        ]
    ];
    
    NSMutableArray *sections = [NSMutableArray array];
    
    for (NSArray <Class>*section in classes) {
        NSMutableArray *rows = [NSMutableArray array];
        for (Class cls in section) {
            [rows addObject:[XYRow rowWithClass:MainCell.class model:[NSString stringWithFormat:@"%@", cls]]];
        }
        [sections addObject:rows];
    }
    
    self.form = sections;
    
    self.tableView.delegate = self;
    
    //    [self requestData];
}

- (void)requestData {
    NSURLSession *session = NSURLSession.sharedSession;
    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/bit-photos/large/7481529.jpeg"];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            [self.view addSubview:imageView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (ino64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [imageView removeFromSuperview];
            });
        }];
    }];
    [task resume];
}

- (void)afRequestData {
    [NetworkServicer fetchImages];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XYRow *row = [self rowAtIndexPath:indexPath];
    NSString *clsName = row.model;
    UIViewController *vc = [[NSClassFromString(clsName) alloc] init];
    vc.title = clsName;
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)alphaButtonTapped:(id)sender {
    [ALPHAManager defaultManager].interfaceHidden = NO;
}

- (void)refreshButtonTapped:(id)sender {
    [self afRequestData];
}

@end
