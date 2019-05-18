//
//  XYPHSRGoodsFilterTabView.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/24.
//

#import "XYUpdatable.h"

#import "XYNoteCardSizePresenter.h"

@class XYPHSearchGoodsFilter, XYPHSRGoodsFilterTabView, XYPHSearchGoodsFilterGroup;

NS_ASSUME_NONNULL_BEGIN

@interface XYPHSRGoodsFilterTabViewModel : NSObject <XYNoteCardSizePresenter>

+ (instancetype)modelWithModel:(XYPHSearchGoodsFilter *)model;

@property (nonatomic, readonly) CGSize cellSize;

@property (nonatomic, readonly) CGSize horizontalCellSize;

@property (nonatomic, strong, readonly) XYPHSearchGoodsFilterGroup *selectedFilterGroup;

@property (nonatomic, assign, readonly) NSInteger selectedFilterGroupIndex;

@property (nonatomic, copy, readonly) NSString *viewId;

@property (nonatomic, strong, readonly) NSArray <XYPHSearchGoodsFilterGroup *> *filterGroups;

@end


@protocol XYPHSRGoodsFilterTabViewDelegate <NSObject>

- (void)goodsFilterTabCellNonSelectedItemDidSelecte:(XYPHSRGoodsFilterTabView *)cell;

- (void)goodsFilterTabCellItemDidSelecte:(XYPHSRGoodsFilterTabView *)cell;

- (void)goodsFilterTabCellItemDidDeselecte:(XYPHSRGoodsFilterTabView *)cell;

@end


@interface XYPHSRGoodsFilterTabView : UIView <XYUpdatable>

@property (nonatomic, strong, readonly) XYPHSRGoodsFilterTabViewModel *viewData;

- (void)refresh;

@end

NS_ASSUME_NONNULL_END
