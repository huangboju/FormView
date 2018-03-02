//
//  XYPHPhoneZonesItem.m
//  FormView
//
//  Created by 黄伯驹 on 23/02/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYPHPhoneZonesItem.h"
#import "XYPHCountryItem.h"

@class XYPHPhoneZonesVC;

@interface XYPHPhoneZonesItem()

@property (nonatomic, strong, readwrite) NSString *groupKey;

@property (nonatomic, strong, readwrite) NSArray <XYPHCountryItem *>*countries;

@end

@implementation XYPHPhoneZonesItem

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    XYPHPhoneZonesItem *item = [XYPHPhoneZonesItem new];
    item.groupKey = dict[@"group_key"];
    NSArray *zones = dict[@"group_items"];
    NSMutableArray <XYPHCountryItem *>*items = [NSMutableArray arrayWithCapacity:zones.count];
    for (NSDictionary *dict in zones) {
        XYPHCountryItem *item = [XYPHCountryItem new];
        item.name = dict[@"name"];
        item.content = dict[@"content"];
        item.dialCcode = dict[@"dial_code"];
        [items addObject:item];
    }
    item.countries = items;
    return item;
}

@end
