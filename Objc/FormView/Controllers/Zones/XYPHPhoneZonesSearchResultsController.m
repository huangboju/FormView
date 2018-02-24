//
//  XYPHPhoneZonesDisplayViewController.m
//  FormView
//
//  Created by 黄伯驹 on 24/02/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYPHPhoneZonesSearchResultsController.h"

#import "XYPHPhoneZonesCell.h"

@interface XYPHPhoneZonesSearchResultsController ()

@property (nonatomic, strong) UILabel *emptyView;

@end

@implementation XYPHPhoneZonesSearchResultsController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[XYPHPhoneZonesCell class] forCellReuseIdentifier:@"cellID"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.result.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYPHPhoneZonesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    [cell updateViewWithModel:self.result[indexPath.row]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.result.count > 0 ? NSLocalizedStringFromTable(@"bestMatch", @"PhoneZones", @"最佳匹配") : @"";
}

- (void)setResult:(NSArray<XYPHContryItem *> *)result {
    _result = result;
    self.tableView.backgroundView = result.count > 0 ? nil : self.emptyView;
    [self.tableView reloadData];
}

- (UILabel *)emptyView {
    if (!_emptyView) {
        _emptyView = [UILabel new];
        _emptyView.backgroundColor = [UIColor whiteColor];
        _emptyView.text = NSLocalizedStringFromTable(@"noResult", @"PhoneZones", @"无结果");
        _emptyView.font = [UIFont systemFontOfSize:30];
        _emptyView.textColor = [UIColor colorWithWhite:0.7 alpha:1];
        _emptyView.textAlignment = NSTextAlignmentCenter;
    }
    return _emptyView;
}

@end
