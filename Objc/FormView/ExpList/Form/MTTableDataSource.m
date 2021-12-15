//
//  MTTableDataSource.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/3/17.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//

#import "MTTableDataSource.h"

@interface MTTableDataSource()

/// dict
@property (nonatomic, strong) NSDictionary *dict;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray <MTDevSection *>*form;

@end

// MTTableDataSource
@implementation MTTableDataSource

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.form.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.form[section].rowCount;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.form[section].title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MTDevRow *row = [self rowAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:row.reuseIdentifier forIndexPath:indexPath];
    [row updateCell:cell];
    return cell;
}

- (MTDevRow *)rowAtIndexPath:(NSIndexPath *)indexPath {
    return self.form[indexPath.section][indexPath.row];
}

- (id)modelAtIndexPath:(NSIndexPath *)indexPath {
    return [self rowAtIndexPath:indexPath].model;
}

- (NSMutableArray<MTDevSection *> *)form {
    if (!_form) {
        _form = NSMutableArray.array;
    }
    return _form;
}

@end
