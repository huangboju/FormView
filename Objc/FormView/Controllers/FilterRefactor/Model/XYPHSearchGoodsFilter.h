//
//  XYPHSearchGoodsFilter.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/2/21.
//

#import <YYModel/YYModel.h>
#import "XYPHSearchGoodsFilterGroup.h"
#import "XYPHSearchGoodsRecommendPriceRange.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYPHSearchGoodsFilter : NSObject

@property (nonatomic, strong) NSArray <XYPHSearchGoodsFilterGroup *> *filterGroups;

@property (nonatomic, assign) NSInteger showPriorityFilter;

@property (nonatomic, strong) NSArray <XYPHSearchGoodsRecommendPriceRange *> *recommendPriceRangeList;

@end

NS_ASSUME_NONNULL_END
