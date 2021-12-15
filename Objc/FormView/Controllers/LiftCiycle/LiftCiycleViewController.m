//
//  LiftCiycleViewController.m
//  FormView
//
//  Created by xiAo-Ju on 2021/5/8.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//


#import "LiftCiycleViewController.h"

@interface LiftCiycleModalViewController: UIViewController

@end

@implementation LiftCiycleModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.blueColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

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

@end




@interface LiftCiycleViewController ()

@property (nonatomic, strong) UISwitch *customModalSwitch;

@end

@implementation LiftCiycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    [self.view addSubview:self.customModalSwitch];
    [self.customModalSwitch.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.customModalSwitch.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
}

- (void)switchValueChanged:(UISwitch *)sender {
    
}

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LiftCiycleModalViewController *modalVC = LiftCiycleModalViewController.new;
    if (self.customModalSwitch.isOn) {
        modalVC.modalPresentationStyle = UIModalPresentationCustom;
    } else {
        modalVC.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self showDetailViewController:modalVC sender:nil];
}

- (UISwitch *)customModalSwitch {
    if (!_customModalSwitch) {
        _customModalSwitch = UISwitch.new;
        _customModalSwitch.translatesAutoresizingMaskIntoConstraints = NO;
        [_customModalSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _customModalSwitch;
}

@end
