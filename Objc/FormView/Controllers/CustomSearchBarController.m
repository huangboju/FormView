//
//  CustomSearchBarController.m
//  FormView
//
//  Created by xiAo_Ju on 20/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "CustomSearchBarController.h"
#import "MySearchBar.h"
#import <Masonry.h>

#import "AudioToolbox/AudioToolbox.h"

#import <UIKit/UIFeedbackGenerator.h>

@interface CustomSearchBarController ()<UISearchBarDelegate>

@property (nonatomic, strong) MySearchBar *searchBar;

@end

@implementation CustomSearchBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.searchBar = [MySearchBar new];
//    self.searchBar.scopeBarBackgroundImage = nil;
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
    [self.searchBar setShowsCancelButton:YES animated:YES];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.centerX.centerY.mas_equalTo(0);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.searchBar resignFirstResponder];
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
    [feedBackGenertor impactOccurred];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
