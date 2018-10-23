//
//  CustomDismissTransitionVC.m
//  FormView
//
//  Created by xiAo_Ju on 2018/9/4.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "CustomDismissTransitionVC.h"

#import "CustomDismissTransitionNavVC.h"

#import "UIColor+Hex.h"

@interface CustomDismissTransitionVC ()

@end

@implementation CustomDismissTransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor randomColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"show" style:UIBarButtonItemStylePlain target:self action:@selector(showNewVC)];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController pushViewController:CustomDismissTransitionVC.new animated:YES];
}

- (void)showNewVC {
    CustomDismissTransitionNavVC *newVC = [[CustomDismissTransitionNavVC alloc] initWithRootViewController:CustomDismissTransitionVC.new];
    [self presentViewController:newVC animated:YES completion:nil];
}


@end
