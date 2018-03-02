//
//  XYPHPhoneZonesHelper.m
//  FormView
//
//  Created by 黄伯驹 on 02/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYPHPhoneZonesHelper.h"

@implementation XYPHPhoneZonesHelper

+ (NSBundle *)bundle {
    NSString *bundlepath = [[NSBundle bundleForClass:[XYPHPhoneZonesHelper class]] pathForResource:@"XYPHPhoneZonesViewController" ofType:@"bundle"];
    return [NSBundle bundleWithPath:bundlepath];
}

+ (NSString *)localizedWithString:(NSString *)str {
    return NSLocalizedStringFromTableInBundle(str, @"PhoneZones", [self bundle], @"");
}

+ (NSArray *)plistData {
    NSString *pfLanguageCode = [NSLocale preferredLanguages][0];
    NSString *name = @"country";
    if ([pfLanguageCode containsString:@"en"]) {
        name = @"country_en";
    }
    NSString *path = [[self bundle] pathForResource:name
                                                                    ofType:@"plist"];
    
    NSArray *dicts = [[NSArray array] initWithContentsOfFile:path];
    return dicts;
}

@end
