//
//  XYPHSearchFilterTag.m
//  Halo
//
//  Created by QiuFeng on 22/03/2017.
//  Copyright © 2017 XingIn. All rights reserved.
//

#import "XYPHSearchGoodsFilterTag.h"

@implementation XYPHSearchGoodsFilterTag

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"selectedImage" : @"selected_image",
             @"selectedColor" : @"selected_color",
             @"tagId": @"id",
             };
}

@end
