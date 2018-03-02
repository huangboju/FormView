//
//  XYPHPhoneZonesHelper.h
//  FormView
//
//  Created by 黄伯驹 on 02/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYPHPhoneZonesHelper : NSObject

+ (NSArray <NSDictionary *>*)plistData;

+ (NSString *)localizedWithString:(NSString *)str;

+ (NSString *)transformToPinyin:(NSString *)str;

@end
