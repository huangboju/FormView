//
//  ImageTextView.h
//  FormView
//
//  Created by 黄伯驹 on 2017/12/7.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ImageTextViewPosition) {
    ImageTextViewPositionTop,                       // imageView在titleLabel上面
    ImageTextViewPositionLeft,                      // imageView在titleLabel左边
    ImageTextViewPositionBottom,                    // imageView在titleLabel下面
    ImageTextViewPositionRight                      // imageView在titleLabel右边
};

@interface ImageTextView : UIView

@property(nonatomic, assign) ImageTextViewPosition imagePosition;

@property(nonatomic, strong) UIImage *image;

@property(nonatomic, strong) NSString *text;

@property(nonatomic, assign) BOOL adjustsFontSizeToFitWidth;

@property(nonatomic, strong) UIColor *textColor;

@property(nonatomic, strong) UIFont *textFont;

@property(nonatomic, assign) CGFloat interval;

@end
