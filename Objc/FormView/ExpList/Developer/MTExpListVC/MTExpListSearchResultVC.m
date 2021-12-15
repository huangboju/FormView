//
//  MTExpListSearchResultVC.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/3/23.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//


#import "MTExpListSearchResultVC.h"

#import "MTExpListCell.h"
#import "MTTableDataSource.h"
#import "MTExpStorage.h"

@interface MTExpListSearchResultVC ()
<
UITableViewDelegate,
MTExpVCPresenter
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MTTableDataSource *dataSource;

@end

// MTExpListSearchResultVC
@implementation MTExpListSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self initSubviews];
}

#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [MTExpStorage modifyExpValueAtIndexPath:indexPath WithVC:self];
}

- (void)initSubviews {
    [self.view addSubview:self.tableView];

    [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (void)setSearchResult:(NSArray<MTDevRow *> *)searchResult {
    _searchResult = searchResult;
    [self.dataSource.form removeAllObjects];
    MTDevSection *section = [[MTDevSection alloc] init];
    [section addRows:searchResult];
    [self.dataSource.form addObject:section];
    [self.tableView reloadData];
}

- (MTTableDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = MTTableDataSource.new;
    }
    return _dataSource;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        Class cellClass = MTExpListCell.class;
        [_tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
        _tableView.dataSource = self.dataSource;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tableView;
}

@end
