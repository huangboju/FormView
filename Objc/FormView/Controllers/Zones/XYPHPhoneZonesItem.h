//
//  XYPHPhoneZonesItem.h
//  FormView
//
//  Created by 黄伯驹 on 23/02/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYPHCountryItem;

@interface XYPHPhoneZonesItem : NSObject

@property (nonatomic, strong, readonly) NSString *groupKey;

@property (nonatomic, strong, readonly) NSArray <XYPHCountryItem *>* countries;

+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end
