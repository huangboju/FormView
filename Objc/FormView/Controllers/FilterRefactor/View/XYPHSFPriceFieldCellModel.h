//
//  XYPHSFPriceFieldCellModel.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/12.
//

#import "XYNoteCardSizePresenter.h"

@class XYPHSearchGoodsRecommendPriceRange;

NS_ASSUME_NONNULL_BEGIN

@interface XYPHSFPriceFieldCellModel : NSObject <XYNoteCardSizePresenter>

+ (instancetype)modelWithModel:(NSArray <XYPHSearchGoodsRecommendPriceRange *> *)model;

// 临时添加
@property (nonatomic, copy, nullable) NSString *minPrice;

@property (nonatomic, copy, nullable) NSString *maxPrice;

@property (nonatomic, readonly) CGSize cellSize;

@property (nonatomic, readonly) BOOL needShowRecommendPrice;

@property (nonatomic, strong, readonly) NSArray<XYPHSearchGoodsRecommendPriceRange *> *model;

@end

@protocol XYPHSFPriceFieldCellDelegate <NSObject>

// 键盘收起就会回调
- (void)searchFilterPriceFieldCellCompleteInput:(UIView *)cell;

@end

NS_ASSUME_NONNULL_END
