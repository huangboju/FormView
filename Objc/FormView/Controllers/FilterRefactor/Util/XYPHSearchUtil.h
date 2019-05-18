//
//  XYPHSearchUtil.h
//  FormView
//
//  Created by 黄伯驹 on 2019/5/2.
//  Copyright © 2019 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static CGFloat kDefaultToolBarHeight = 40.0;

@interface XYPHSearchUtil : NSObject

@property (class, nonatomic, assign, readonly) CGFloat contentWidth;

@property (class, nonatomic, assign, readonly) CGFloat pixelOne;

@property (class, nonatomic, strong, readonly) UIView *separatorLine;

@end

NS_ASSUME_NONNULL_END
