//
//  XYPHSFGoodsViewModel.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/11.
//

#import "XYRow.h"

#import "XYPHSearchFilterNotesCell.h"
#import "XYPHSFPriceFieldCell.h"

@class XYPHSearchGoodsFilter, XYSFSelectedFilters;

NS_ASSUME_NONNULL_BEGIN

@interface XYPHSFGoodsViewModel : NSObject <UITableViewDataSource>

- (void)updateRowsWithModel:(XYPHSearchGoodsFilter *)model
            selectedFilters:(XYSFSelectedFilters *)selectedFilters;

- (void)removeAllSelected;

- (void)registerClassInTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
