//
//  XYPHPhoneZonesItem.h
//  FormView
//
//  Created by 黄伯驹 on 23/02/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYPHContryItem;

@interface XYPHPhoneZonesItem : NSObject

@property (nonatomic, strong, readonly) NSString *groupKey;

@property (nonatomic, strong, readonly) NSArray <XYPHContryItem *>*contries;

+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end
