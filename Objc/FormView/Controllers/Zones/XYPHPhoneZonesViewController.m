//
//  XYPHPhoneZonesViewController.m
//  FormView
//
//  Created by 黄伯驹 on 23/02/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYPHPhoneZonesViewController.h"
#import "XYPHPhoneZonesSearchResultsController.h"
#import <Masonry.h>

#import "XYPHPhoneZonesItem.h"
#import "XYPHContryItem.h"

#import "XYPHPhoneZonesCell.h"

@interface XYPHPhoneZonesViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UISearchBarDelegate
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) NSMutableArray <XYPHPhoneZonesItem *>*items;

@property (nonatomic, strong) NSMutableArray <NSString *>*sectionIndexTitles;

@property (nonatomic, strong) XYPHPhoneZonesSearchResultsController *searchResultsController;

@end

@implementation XYPHPhoneZonesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.items = [NSMutableArray array];
    self.sectionIndexTitles = [NSMutableArray array];
    [self readData];

    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)readData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"country"
                                                     ofType:@"plist"];

    NSArray *dicts = [[NSArray array] initWithContentsOfFile:path];

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
    return self.items[section].contries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYPHPhoneZonesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    [cell updateViewWithModel:self.items[indexPath.section].contries[indexPath.row]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.items[section].groupKey;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexTitles;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSMutableArray *result = [NSMutableArray array];

    for (XYPHPhoneZonesItem *zone in self.items) {
        if ([zone.groupKey isEqualToString:@"热门"]) {
            continue;
        }
        for (XYPHContryItem *contry in zone.contries) {
            NSString *contryName = contry.name;
            NSString *pinyin = [self transformToPinyin:contryName];
            if ([contryName containsString:searchText] || [pinyin containsString:searchText]) {
                [result addObject:contry];
            }
        }
    }
    self.searchResultsController.result = result;
}

- (NSString *)transformToPinyin:(NSString *)str {
    NSMutableString *mutableString = [NSMutableString stringWithString:str];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return [mutableString stringByReplacingOccurrencesOfString:@"'" withString:@""];
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsController];
        _searchController.searchBar.delegate = self;
    }
    return _searchController;
}

- (XYPHPhoneZonesSearchResultsController *)searchResultsController {
    if (!_searchResultsController) {
        _searchResultsController = [XYPHPhoneZonesSearchResultsController new];
    }
    return _searchResultsController;
}

@end
