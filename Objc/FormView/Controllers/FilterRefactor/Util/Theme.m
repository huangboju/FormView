//
//  Theme.m
//  FormView
//
//  Created by 黄伯驹 on 2019/5/2.
//  Copyright © 2019 黄伯驹. All rights reserved.
//

#import "Theme.h"
#import "UIColor+Hex.h"

@implementation Theme

+ (UIFont *)fontMediumBold {
    return [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
}

+ (UIFont *)fontSmallBold {
    return [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
}

+ (UIFont *)fontSmall {
    return [UIFont systemFontOfSize:13];
}

+ (UIFont *)fontXSmall {
    return [UIFont systemFontOfSize:11];
}

+ (UIFont *)fontLarge {
    return [UIFont systemFontOfSize:16];
}

+ (UIColor *)colorGrayLevel1 {
    return [UIColor colorWithHex:0x333333];
}

+ (UIColor *)colorGrayLevel2 {
    return [UIColor colorWithHex:0x666666];
}

+ (UIColor *)colorGrayLevel3 {
    return [UIColor colorWithHex:0x999999];
}

+ (UIColor *)colorRed {
    return [UIColor colorWithHex:0xFF2741];
}

@end
