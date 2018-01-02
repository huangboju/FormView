//
//  ViewController.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "GroupTableController.h"

@interface GroupTableController () <UITableViewDataSource>

@end

@implementation GroupTableController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initSubviews];

    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (Row *)rowAtIndexPath:(NSIndexPath *)indexPath {
    return self.form[indexPath.section][indexPath.row];
}

- (void)setForm:(NSArray<NSArray<Row *> *> *)form {
    _form = form;
    [self registerCells];
}

- (void)registerCells {
    for (NSArray <Row *>*rows in self.form) {
        for (Row *row in rows) {
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
    Row *row = [self rowAtIndexPath:indexPath];
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
    }
    return _tableView;
}

@end

@implementation GroupTableController (SubclassingHooks)

- (void)initSubviews {
    // 子类重写
}

@end
