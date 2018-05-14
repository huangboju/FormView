//
//  UIImage+Rounded.m
//  FormView
//
//  Created by 黄伯驹 on 2018/5/14.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "UIImage+Rounded.h"

@implementation UIImage (Rounded)

- (UIImage *)imageRoundedWithCornerRadius:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);

    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);

    UIBezierPath *clippingPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];

    [clippingPath addClip];

    [self drawInRect:rect];

    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return roundedImage;
}

@end
