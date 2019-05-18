//
//  XYPHSFGoodsViewModel.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/11.
//

#import "XYPHSFGoodsViewModel.h"

#import "XYPHSearchGoodsFilter.h"
#import "XYSFSelectedFilters.h"

#import "XYPHSearchGoodsFilterGroup.h"
#import "XYPHSFNotesCellModel.h"


@interface XYPHSFGoodsViewModel()

@property (nonatomic, strong) NSMutableArray <XYRow *>*rows;

@property (nonatomic, strong) XYRow *priceRow;

@end

@implementation XYPHSFGoodsViewModel

- (void)updateRowsWithModel:(XYPHSearchGoodsFilter *)model
            selectedFilters:(XYSFSelectedFilters *)selectedFilters {
    [self.rows removeAllObjects];
    if (!model) { return; }
    XYPHSFPriceFieldCellModel *cellModel = _priceRow.model ?: [XYPHSFPriceFieldCellModel modelWithModel:model.recommendPriceRangeList];
    _priceRow = [XYRow rowWithClass:XYPHSFPriceFieldCell.class model:cellModel];
    [self.rows addObject:_priceRow];

    NSInteger row = 0;
    for (XYPHSearchGoodsFilterGroup *obj in model.filterGroups) {
        if (obj.innerInvisible) { continue; }
        XYPHSFNotesCellModel *cellModel = [XYPHSFNotesCellModel modelWithModel:obj selectedFilters:selectedFilters[obj.groupId] row:row];
        [self.rows addObject:[XYRow rowWithClass:XYPHSearchFilterNotesCell.class model:cellModel]];
        row += 1;
    }
}

- (void)removeAllSelected {
    for (XYRow *row in self.rows) {
        id model = row.model;
        if ([model isMemberOfClass:XYPHSFNotesCellModel.class]) {
            for (XYPHSearchFilterTagCellModel *cellModel in [(XYPHSFNotesCellModel*)model items]) {
                cellModel.selected = NO;
            }
        } else if ([model isMemberOfClass:XYPHSFPriceFieldCellModel.class]) {
            [(XYPHSFPriceFieldCellModel*)model setMaxPrice:nil];
            [(XYPHSFPriceFieldCellModel*)model setMinPrice:nil];
        }
    }
}

- (void)registerClassInTableView:(UITableView *)tableView {
    NSArray <Class> *classes = @[
                         XYPHSFPriceFieldCell.class,
                         XYPHSearchFilterNotesCell.class
                         ];
    for (Class cls in classes) {
        [tableView registerClass:cls forCellReuseIdentifier:NSStringFromClass(cls)];
    }
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYRow *row = self.rows[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:row.reuseIdentifier forIndexPath:indexPath];
    [row updateCell:cell];
    return cell;
}

- (NSMutableArray<XYRow *> *)rows {
    if (!_rows) {
        _rows = NSMutableArray.array;
    }
    return _rows;
}

@end
