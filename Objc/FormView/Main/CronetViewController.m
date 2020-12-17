//
//  CronetViewController.m
//  FormView
//
//  Created by jourhuang on 2020/12/17.
//  Copyright © 2020 黄伯驹. All rights reserved.
//

#import "CronetViewController.h"

#import "MainCell.h"
#import "NetworkServicer.h"

@interface CronetViewController ()
<
UITableViewDelegate,
NSURLSessionDelegate
>

@end

@implementation CronetViewController

- (void)initSubviews {
    NSArray <NSDictionary *> *sections = @[
        @{
            @"AFSession": @"fetchImages",
            @"URLSession": @"requestData",
        },
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
    NSURLSession *session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8oeUYYsI1bna0kPb_B0bVyQH1ZKdusZyfTRoNwKcMOB8ffgAyBg"];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    [task resume];
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
