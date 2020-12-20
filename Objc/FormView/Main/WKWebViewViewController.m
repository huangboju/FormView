//
//  WKWebViewViewController.m
//  FormView
//
//  Created by jourhuang on 2020/12/17.
//  Copyright © 2020 黄伯驹. All rights reserved.
//

#import <WebKit/WKWebView.h>

#import "WKWebViewViewController.h"

@interface WKWebViewViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WKWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.chromium.org"]];
    [self.webView loadRequest:request];
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *config = WKWebViewConfiguration.new;
        _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
    }
    return _webView;
}

@end
