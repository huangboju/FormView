//
//  ViewController.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "MTDevGroupTableController.h"

@interface MTDevGroupTableController () <UITableViewDataSource>

@end

@implementation MTDevGroupTableController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initSubviews];

    [self.view addSubview:self.tableView];

    [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;

    [self tableViewDidMoveToSuperView];
}

- (MTDevRow *)rowAtIndexPath:(NSIndexPath *)indexPath {
    return self.form[indexPath.section][indexPath.row];
}

- (void)setForm:(NSArray<NSArray<MTDevRow *> *> *)form {
    _form = form;
    [self registerCells];
}

- (void)registerCells {
    for (NSArray <MTDevRow *>*rows in self.form) {
        for (MTDevRow *row in rows) {
            [self.tableView registerClass:row.cellClass forCellReuseIdentifier:row.reuseIdentifier];
        }
    }
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.form.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.form[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MTDevRow *row = [self rowAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:row.reuseIdentifier forIndexPath:indexPath];
    [row updateCell:cell];
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tableView;
}

@end

@implementation MTDevGroupTableController (SubclassingHooks)

- (void)initSubviews {
    // 子类重写
}

- (void)tableViewDidMoveToSuperView {
    // 子类重写
}

@end
