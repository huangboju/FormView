//
//  TagLayer.h
//  FormView
//
//  Created by xiAo_Ju on 2018/5/14.
//  Copyright © 2018 黄伯驹. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TagLayer : CALayer

/**
 Default 14 * 14
 */
@property (nonatomic) CGSize imageSize;


@property (nonatomic, assign) CGFloat maxWidth;

/**
 Default [UIFont systemFontOfSize:12]
 */
@property (nonatomic, strong, nonnull) UIFont *font;

@property (nonatomic, strong, nullable) UIImage *image;

@property (nonatomic, copy, nullable) NSString *text;

@end
