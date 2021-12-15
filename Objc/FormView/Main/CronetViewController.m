//
//  CronetViewController.m
//  FormView
//
//  Created by xiAo-Ju on 2020/12/17.
//  Copyright © 2020 黄伯驹. All rights reserved.
//

#import <Cronet/Cronet.h>

#import "CronetViewController.h"

#import "MainCell.h"
#import "NetworkServicer.h"

#import "WKWebViewViewController.h"

@interface CronetViewController ()
<
UITableViewDelegate,
NSURLSessionDelegate
>

@end

@implementation CronetViewController

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
    NSArray <NSDictionary *> *sections = @[
        @{
            @"AFSession": @"fetchImages",
            @"URLSession": @"requestData",
        },
        @{
            @"showWebView": @"showWebView"
        }
    ];
    
    NSMutableArray *form = NSMutableArray.array;
    
    for (NSDictionary *section in sections) {
        NSMutableArray *rows = [NSMutableArray array];
        for (NSString *key in section) {
            MainCellItem *item = [MainCellItem itemWithTitle:key selector:NSSelectorFromString(section[key])];
            [rows addObject:[XYRow rowWithClass:MainCell.class model:item]];
        }
        [form addObject:rows];
    }

    self.form = form.copy;

    self.tableView.delegate = self;
    self.tableView.rowHeight = 66;
}

- (void)fetchImages {
    [NetworkServicer fetchImages];
}

- (void)requestData {
    NSURLSessionConfiguration *config = NSURLSessionConfiguration.defaultSessionConfiguration;
    [Cronet installIntoSessionConfiguration:config];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
//    NSURL *url = [NSURL URLWithString:@"https://www.chromium.org/_/rsrc/1438879449147/config/customLogo.gif?revision=3"];
    NSURL *url = [NSURL URLWithString:@"https://static.xx.fbcdn.net/rsrc.php/y8/r/dF5SId3UHWd.svg"];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    [task resume];
}

- (void)showWebView {
    WKWebViewViewController *webView = WKWebViewViewController.new;
    [self showViewController:webView sender:nil];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics {
    [NetworkServicer logMetrics:metrics];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainCellItem *item = [self rowAtIndexPath:indexPath].model;
    [self performSelector:item.selector];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
