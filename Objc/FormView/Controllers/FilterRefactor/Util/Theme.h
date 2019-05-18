//
//  Theme.h
//  FormView
//
//  Created by 黄伯驹 on 2019/5/2.
//  Copyright © 2019 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Theme : NSObject

@property (class, nonatomic, readonly) UIFont *fontMediumBold;

@property (class, nonatomic, readonly) UIFont *fontSmallBold;

@property (class, nonatomic, readonly) UIFont *fontSmall;

@property (class, nonatomic, readonly) UIFont *fontXSmall;

@property (class, nonatomic, readonly) UIFont *fontLarge;

@property (class, nonatomic, readonly) UIColor *colorGrayLevel1;

@property (class, nonatomic, readonly) UIColor *colorGrayLevel2;

@property (class, nonatomic, readonly) UIColor *colorGrayLevel3;

@property (class, nonatomic, readonly) UIColor *colorRed;

@end

NS_ASSUME_NONNULL_END
