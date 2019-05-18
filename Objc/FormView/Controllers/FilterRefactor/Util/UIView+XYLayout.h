//
//  UIView+XYLayout.h
//  XYUIKit
//
//  Created by Panghu on 24/01/2018.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XYLayout)

@property (nonatomic) CGFloat xy_top;
@property (nonatomic) CGFloat xy_leading;
@property (nonatomic) CGFloat xy_bottom;
@property (nonatomic) CGFloat xy_trailing;
@property (nonatomic) CGFloat xy_centerX;
@property (nonatomic) CGFloat xy_centerY;
@property (nonatomic) CGSize xy_size;
@property (nonatomic) CGPoint xy_origin;
@property (nonatomic) CGFloat xy_width;
@property (nonatomic) CGFloat xy_height;

- (void)setXy_top:(CGFloat)xy_top animated:(BOOL)animated;
- (void)setXy_leading:(CGFloat)xy_leading animated:(BOOL)animated;
- (void)setXy_bottom:(CGFloat)xy_bottom animated:(BOOL)animated;
- (void)setXy_trailing:(CGFloat)xy_trailing animated:(BOOL)animated;
- (void)setXy_centerX:(CGFloat)xy_centerX animated:(BOOL)animated;
- (void)setXy_centerY:(CGFloat)xy_centerY animated:(BOOL)animated;
- (void)setXy_size:(CGSize)xy_size animated:(BOOL)animated;
- (void)setXy_origin:(CGPoint)xy_origin animated:(BOOL)animated;
- (void)setXy_width:(CGFloat)xy_width animated:(BOOL)animated;
- (void)setXy_height:(CGFloat)xy_height animated:(BOOL)animated;
    
@end

NS_ASSUME_NONNULL_END
