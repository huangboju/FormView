//
//  ViewController.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "XYPHGroupTableController.h"

#import <Masonry.h>

@interface XYPHGroupTableController () <UITableViewDataSource>

@end

@implementation XYPHGroupTableController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initSubviews];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];

    [self tableViewDidMoveToSuperView];
}

- (XYRow *)rowAtIndexPath:(NSIndexPath *)indexPath {
    return self.form[indexPath.section][indexPath.row];
}

- (void)setForm:(NSArray<NSArray<XYRow *> *> *)form {
    _form = form;
    [self registerCells];
}

- (void)registerCells {
    for (NSArray <XYRow *>*rows in self.form) {
        for (XYRow *row in rows) {
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
    XYRow *row = [self rowAtIndexPath:indexPath];
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

@implementation XYPHGroupTableController (SubclassingHooks)

- (void)initSubviews {
    // 子类重写
}

- (void)tableViewDidMoveToSuperView {
    // 子类重写
}

@end
