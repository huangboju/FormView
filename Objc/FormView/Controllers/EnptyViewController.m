//
//  EnptyViewController.m
//  FormView
//
//  Created by 黄伯驹 on 27/12/2017.
//  Copyright © 2017 黄伯驹. All rights reserved.
//

#import "EnptyViewController.h"
//#import "EmptyView.h"
#import <Masonry.h>
#import "UIScrollView+XYEmptyView.h"

@interface EnptyViewController ()<XYEmptyDataSetSource, XYEmptyDataSetDelegate>

@property (nonatomic, strong) NSArray <NSString *>*data;
@end

@implementation EnptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mycell"];
    self.tableView.tableFooterView = [UIView new];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"reload" style:UIBarButtonItemStylePlain target:self action:@selector(reloadAction)];
}

- (void)reloadAction {
    self.data = @[@"1", @"2"];
    [self.tableView reloadData];
}

# pragma mark DZNEmptyDataSetSource
- (NSString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return @"Reveal是iOS开发工具中的神器之一，它能够在";
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"icon_500px"];
}

- (NSString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return @"刷新";
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self reloadAction];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor colorWithWhite:0 alpha:0.7];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
}

@end
