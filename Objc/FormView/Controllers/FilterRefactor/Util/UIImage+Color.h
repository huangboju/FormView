//
//  UIImage+Color.h
//  FormView
//
//  Created by 黄伯驹 on 2019/5/2.
//  Copyright © 2019 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Color)

- (UIImage *)imageMaskedWithColor:(UIColor *)maskColor;

@end

NS_ASSUME_NONNULL_END
