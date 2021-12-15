//
//  MTExpListCell.h
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/3/18.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//


#import "MTDevTitleCell.h"

NS_ASSUME_NONNULL_BEGIN

// MTExpListCellItem
@interface MTExpListCellItem : MTDevTitleCellItem

/// 实验状态
/// 1 本地添加
/// 2 修改过的
@property (nonatomic, assign, readonly) NSInteger expState;

/// groupTitle
@property (nonatomic, copy, readonly) NSString *groupTitle;

- (void)addExpState:(NSInteger)expState;

- (void)addGroupTitle:(NSString *)groupTitle;

@end


// MTExpListCell
@interface MTExpListCell : UITableViewCell

@end

NS_ASSUME_NONNULL_END
