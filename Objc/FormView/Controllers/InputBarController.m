//
//  InputBarController.m
//  FormView
//
//  Created by 黄伯驹 on 30/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "InputBarController.h"

#import "XYInputBarView.h"

@interface InputBarController ()

@property (nonatomic, strong) XYInputBarView *inputBarView;

@end

@implementation InputBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.inputBarView = [XYInputBarView new];
    UIButton *button1 = [self generateButtonWithImageName:@""];
    UIButton *button2 = [self generateButtonWithImageName:@""];
    UIButton *button3 = [self generateButtonWithImageName:@""];
    self.inputBarView.leftButton = button3;
    self.inputBarView.rightButtons = @[button1, button2];
    [self.view addSubview:self.inputBarView];

    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(cancelAction)];
    
    self.navigationItem.rightBarButtonItems = @[item1, item2];
}

- (void)cancelAction {
    [self.inputBarView resignFirstResponder];
}

- (void)editAction {
    [self.inputBarView becomeFirstResponder];
}

- (UIButton *)generateButtonWithImageName:(NSString *)imageName {
    UIButton *button = [UIButton new];
    [button setImage:[UIImage imageNamed:@"icon_emotion"] forState:UIControlStateNormal];
    return button;
}


@end
