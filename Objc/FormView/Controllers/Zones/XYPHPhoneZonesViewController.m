//
//  XYPHPhoneZonesViewController.m
//  FormView
//
//  Created by 黄伯驹 on 23/02/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYPHPhoneZonesViewController.h"
#import <Masonry.h>

#import "XYPHPhoneZonesItem.h"
#import "XYPHContryItem.h"

@interface XYPHPhoneZonesCell: UITableViewCell

@end

@implementation XYPHPhoneZonesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)updateViewWithModel:(XYPHContryItem *)model {
    self.textLabel.text = model.name;
    self.detailTextLabel.text = model.dialCcode;
}

@end

@interface XYPHPhoneZonesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) NSMutableArray <XYPHPhoneZonesItem *>*items;

@property (nonatomic, strong) NSMutableArray <NSString *>*sectionIndexTitles;

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
    return self.items[section].zones.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYPHPhoneZonesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    [cell updateViewWithModel:self.items[indexPath.section].zones[indexPath.row]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.items[section].groupKey;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexTitles;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    }
    return _searchController;
}

@end
