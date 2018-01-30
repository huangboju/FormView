//
//  EffectButtonController.m
//  FormView
//
//  Created by 黄伯驹 on 15/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "EffectButtonController.h"

#import "AYVibrantButton.h"

@interface EffectButtonController ()

@end

@implementation EffectButtonController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    backgroundView.frame = self.view.frame;
    [self.view addSubview:backgroundView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    
    visualView.frame = CGRectMake(15, 100, self.view.frame.size.width - 30, 44);
    [self.view addSubview:visualView];
    
    
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 30, 44)];
//    [button setTitle:@"登录" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(signInAction) forControlEvents:UIControlEventTouchUpInside];
//    [visualView.contentView addSubview:button];

    AYVibrantButton *invertButton = [[AYVibrantButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 30, 44) style:AYVibrantButtonStyleInvert];
    invertButton.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    invertButton.text = @"Invert";
    invertButton.font = [UIFont systemFontOfSize:18.0];
    [visualView.contentView addSubview:invertButton];

//    AYVibrantButton *translucentButton = [[AYVibrantButton alloc] initWithFrame:CGRectMake(0, 200, 200, 44) style:AYVibrantButtonStyleTranslucent];
//    translucentButton.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
//    translucentButton.text = @"Translucent";
//    translucentButton.font = [UIFont systemFontOfSize:18.0];
//    [visualView addSubview:translucentButton];
}

- (void)signInAction {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
