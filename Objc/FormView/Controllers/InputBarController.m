//
//  InputBarController.m
//  FormView
//
//  Created by 黄伯驹 on 30/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <WebKit/WKWebView.h>

#import "InputBarController.h"

#import "XYInputBarView.h"

@interface InputBarController ()

@property (nonatomic, strong) XYInputBarView *inputBarView;

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) WKWebView *wkwebView;

@end

@implementation InputBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.inputBarView = [XYInputBarView new];
//    UIButton *button1 = [self generateButtonWithImageName:@""];
//    UIButton *button2 = [self generateButtonWithImageName:@""];
//    UIButton *button3 = [self generateButtonWithImageName:@""];
//    self.inputBarView.leftButton = button3;
//    self.inputBarView.rightButtons = @[button1, button2];
//    [self.view addSubview:self.inputBarView];
    
//    [self initUIWebView];
    [self initWKWebView];

//    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction)];
//    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(cancelAction)];
//
//    self.navigationItem.rightBarButtonItems = @[item1, item2];
    
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(editAction)];
    
    self.navigationItem.rightBarButtonItem = item1;
}

- (void)initUIWebView {
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.webView loadRequest:self.request];
    [self.view addSubview:self.webView];
}

- (void)initWKWebView {
    self.wkwebView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.wkwebView loadRequest:self.request];
    [self.view addSubview:self.wkwebView];
}

- (NSURLRequest *)request {
    NSString *url = @"https://www.pg.com.cn/";
    return [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
}

- (void)cancelAction {
    [self.inputBarView resignFirstResponder];
}

- (void)editAction {
    [self.wkwebView reload];
//    [self.webView loadRequest:self.request];
//    [self.inputBarView becomeFirstResponder];
}

- (UIButton *)generateButtonWithImageName:(NSString *)imageName {
    UIButton *button = [UIButton new];
    [button setImage:[UIImage imageNamed:@"icon_emotion"] forState:UIControlStateNormal];
    return button;
}


@end
