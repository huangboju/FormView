//
//  XYPHSearchGoodsRecommendPriceRange.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/2/25.
//

#import "XYPHSearchGoodsRecommendPriceRange.h"

@implementation XYPHSearchGoodsRecommendPriceRange

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"minPrice": @"min_price",
             @"maxPrice": @"max_price"
             };
}

@end
