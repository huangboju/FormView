//
//  XYPHPhoneZonesViewController.m
//  FormView
//
//  Created by 黄伯驹 on 23/02/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYPHPhoneZonesVC.h"
#import "XYPHPhoneZonesSearchResultsVC.h"
#import "XYPHPhoneZonesHelper.h"

#import "XYPHPhoneZonesItem.h"
#import "XYPHCountryItem.h"

#import "XYPHPhoneZonesCell.h"

@interface XYPHPhoneZonesVC ()
<
UITableViewDataSource,
UITableViewDelegate,
UISearchBarDelegate
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) NSMutableArray <XYPHPhoneZonesItem *>*items;

@property (nonatomic, strong) NSMutableArray <NSString *>*sectionIndexTitles;

@property (nonatomic, strong) XYPHPhoneZonesSearchResultsVC *searchResultsController;

@end

@implementation XYPHPhoneZonesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.items = [NSMutableArray array];
    self.sectionIndexTitles = [NSMutableArray array];
    [self readData];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)readData {
    NSArray *dicts = [XYPHPhoneZonesHelper plistData];
    for (NSDictionary *dict in dicts) {
        XYPHPhoneZonesItem *item = [XYPHPhoneZonesItem itemWithDict: dict];
        [self.items addObject:item];
        [self.sectionIndexTitles addObject:item.groupKey];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[XYPHPhoneZonesCell class] forCellReuseIdentifier:@"cellID"];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items[section].countries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYPHPhoneZonesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    [cell updateViewWithModel:self.items[indexPath.section].countries[indexPath.row]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.items[section].groupKey;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexTitles;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSString *lowercaseString = [searchText lowercaseString];
    NSString *uppercaseString = [searchText uppercaseString];
    NSMutableArray *result = [NSMutableArray array];

    NSArray *groupKeys = @[@"热门", @"Hot"];

    for (XYPHPhoneZonesItem *zone in self.items) {
        if ([groupKeys containsObject:zone.groupKey]) {
            continue;
        }
        for (XYPHCountryItem *country in zone.countries) {
            NSString *countryName = country.name;
            NSString *pinyin = [XYPHPhoneZonesHelper transformToPinyin:countryName];
            if ([countryName containsString:lowercaseString] ||
                [pinyin containsString:lowercaseString] ||
                [countryName containsString:uppercaseString]) {
                [result addObject:country];
            }
        }
    }
    self.searchResultsController.result = result;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsController];
        _searchController.searchBar.delegate = self;
    }
    return _searchController;
}

- (XYPHPhoneZonesSearchResultsVC *)searchResultsController {
    if (!_searchResultsController) {
        _searchResultsController = [XYPHPhoneZonesSearchResultsVC new];
    }
    return _searchResultsController;
}

@end
