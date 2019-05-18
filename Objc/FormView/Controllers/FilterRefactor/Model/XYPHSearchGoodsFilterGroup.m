//
//  XYPHSearchFilterGroup.m
//  Halo
//
//  Created by QiuFeng on 22/03/2017.
//  Copyright © 2017 XingIn. All rights reserved.
//

#import "XYPHSearchGoodsFilterGroup.h"

@implementation XYPHSearchGoodsFilterGroup

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"filterTags": @"filter_tags",
             @"innerInvisible": @"inner_invisible",
             @"groupId": @"id"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"filterTags": XYPHSearchGoodsFilterTag.class
             };
}

- (BOOL)isNonSelected {
    return [self.type isEqualToString:@"Non-selected"];
}

- (XYPHSearchGoodsFilterTag *)nonSelectedTag {
    if (!self.isNonSelected) {
        NSAssert(NO, @"不是 Non-selected类型");
    }
    return self.filterTags.firstObject;
}

@end
