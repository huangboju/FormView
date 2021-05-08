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
#import "LiftCiycleViewController.h"

#import "InterviewController.h"

#import "ALPHAManager.h"

#import "NetworkServicer.h"

@interface MainViewController ()<UITableViewDelegate>

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%s", __FUNCTION__);
}

- (void)initSubviews {
    
    UIBarButtonItem *alpha = [[UIBarButtonItem alloc] initWithTitle:@"Alpha" style:UIBarButtonItemStylePlain target:self action:@selector(alphaButtonTapped:)];
    
    self.navigationItem.rightBarButtonItems = @[
        alpha
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
        ],
        @[
            InterviewController.class
        ],
        @[
            LiftCiycleViewController.class
        ]
    ];
    
    NSMutableArray *sections = [NSMutableArray array];
    
    for (NSArray <Class>*section in classes) {
        NSMutableArray *rows = [NSMutableArray array];
        for (Class cls in section) {
            MainCellItem *item = [MainCellItem itemWithTitle:[NSString stringWithFormat:@"%@", cls] selector:nil];
            [rows addObject:[XYRow rowWithClass:MainCell.class model:item]];
        }
        [sections addObject:rows];
    }
    
    self.form = sections;
    
    self.tableView.delegate = self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XYRow *row = [self rowAtIndexPath:indexPath];
    MainCellItem *item = row.model;
    NSString *clsName = item.title;
    UIViewController *vc = [[NSClassFromString(clsName) alloc] init];
    vc.title = clsName;
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)alphaButtonTapped:(id)sender {
    [ALPHAManager defaultManager].interfaceHidden = NO;
}

@end
