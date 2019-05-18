//
//  XYPHSearchGoodsFilter.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/2/21.
//

#import "XYPHSearchGoodsFilter.h"

@implementation XYPHSearchGoodsFilter

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"showPriorityFilter": @"show_priority_filter",
             @"filterGroups": @"filter_groups",
             @"recommendPriceRangeList": @"recommend_price_range_list"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"filterGroups": XYPHSearchGoodsFilterGroup.class,
             @"recommendPriceRangeList": XYPHSearchGoodsRecommendPriceRange.class
             };
}

@end
