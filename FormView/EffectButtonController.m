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
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    
    visualView.frame = CGRectMake(0, 100,375, 300);
    [self.view addSubview:visualView];

    AYVibrantButton *invertButton = [[AYVibrantButton alloc] initWithFrame:CGRectMake(0, 100, 200, 44) style:AYVibrantButtonStyleInvert];
    invertButton.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    invertButton.text = @"Invert";
    invertButton.font = [UIFont systemFontOfSize:18.0];
    [visualView addSubview:invertButton];
    
    AYVibrantButton *translucentButton = [[AYVibrantButton alloc] initWithFrame:CGRectMake(0, 200, 200, 44) style:AYVibrantButtonStyleTranslucent];
    translucentButton.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    translucentButton.text = @"Translucent";
    translucentButton.font = [UIFont systemFontOfSize:18.0];
    [visualView addSubview:translucentButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
