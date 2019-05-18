//
//  XYPHSearchFilterPriceSuggestCell.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/2/22.
//

#import "XYUpdatable.h"
#import "XYNoteCardSizePresenter.h"

@class XYPHSearchGoodsRecommendPriceRange, XYPHSFRecommendPriceView;

NS_ASSUME_NONNULL_BEGIN

@protocol XYPHSFRecommendPriceViewDelegate <NSObject>

- (void)secommendPriceCellItemClicked:(XYPHSFRecommendPriceView *)sender;

@end


@interface XYPHSFRecommendPriceView : UIView<XYUpdatable>

@property (nonatomic, strong, readonly) XYPHSearchGoodsRecommendPriceRange *selectedRange;

@property (nonatomic, weak) id <XYPHSFRecommendPriceViewDelegate> delegate;

- (void)updateSelectedStatusIfNeededWithMin:(NSString *)min max:(NSString *)max;

@end

NS_ASSUME_NONNULL_END
