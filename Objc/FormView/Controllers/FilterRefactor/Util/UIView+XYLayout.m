//
//  UIView+XYLayout.m
//  XYUIKit
//
//  Created by Panghu on 24/01/2018.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "UIView+XYLayout.h"

@implementation UIView (XYLayout)

#pragma mark Getter

- (CGFloat)xy_top {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)xy_leading {
    return CGRectGetMinX(self.frame);
}

- (CGFloat)xy_bottom {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)xy_trailing {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)xy_centerX {
    return self.center.x;
}

- (CGFloat)xy_centerY {
    return self.center.y;
}

- (CGSize)xy_size {
    return self.frame.size;
}

- (CGPoint)xy_origin {
    return self.frame.origin;
}

- (CGFloat)xy_width {
    return CGRectGetWidth(self.frame);
}

- (CGFloat)xy_height {
    return CGRectGetHeight(self.frame);
}

#pragma mark Setter

- (void)setXy_top:(CGFloat)xy_top {
    CGRect frame = self.frame;
    frame.origin.y = xy_top;
    self.frame = frame;
}

- (void)setXy_leading:(CGFloat)xy_leading {
    CGRect frame = self.frame;
    frame.origin.x = xy_leading;
    self.frame = frame;
}

- (void)setXy_bottom:(CGFloat)xy_bottom {
    CGRect frame = self.frame;
    frame.origin.y = xy_bottom - self.xy_height;
    self.frame = frame;
}

- (void)setXy_trailing:(CGFloat)xy_trailing {
    CGRect frame = self.frame;
    frame.origin.x = xy_trailing - self.xy_width;
    self.frame = frame;
}

- (void)setXy_centerX:(CGFloat)xy_centerX {
    CGPoint center = self.center;
    center.x = xy_centerX;
    self.center = center;
}

- (void)setXy_centerY:(CGFloat)xy_centerY {
    CGPoint center = self.center;
    center.y = xy_centerY;
    self.center = center;
}

- (void)setXy_size:(CGSize)xy_size {
    CGRect frame = self.frame;
    frame.size = xy_size;
    self.frame = frame;
}

- (void)setXy_origin:(CGPoint)xy_origin {
    CGRect frame = self.frame;
    frame.origin = xy_origin;
    self.frame = frame;
}

- (void)setXy_width:(CGFloat)xy_width {
    CGRect frame = self.frame;
    frame.size.width = xy_width;
    self.frame = frame;
}

- (void)setXy_height:(CGFloat)xy_height {
    CGRect frame = self.frame;
    frame.size.height = xy_height;
    self.frame = frame;
}

- (void)setXy_top:(CGFloat)xy_top animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setXy_top:xy_top];
        }];
    } else {
        [self setXy_top:xy_top];
    }
}

- (void)setXy_leading:(CGFloat)xy_leading animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setXy_leading:xy_leading];
        }];
    } else {
        [self setXy_leading:xy_leading];
    }
}

- (void)setXy_bottom:(CGFloat)xy_bottom animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setXy_bottom:xy_bottom];
        }];
    } else {
        [self setXy_bottom:xy_bottom];
    }
}

- (void)setXy_trailing:(CGFloat)xy_trailing animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setXy_trailing:xy_trailing];
        }];
    } else {
        [self setXy_trailing:xy_trailing];
    }
}

- (void)setXy_centerX:(CGFloat)xy_centerX animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setXy_centerX:xy_centerX];
        }];
    } else {
        [self setXy_centerX:xy_centerX];
    }
}

- (void)setXy_centerY:(CGFloat)xy_centerY animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setXy_centerY:xy_centerY];
        }];
    } else {
        [self setXy_centerY:xy_centerY];
    }
}

- (void)setXy_size:(CGSize)xy_size animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setXy_size:xy_size];
        }];
    } else {
        [self setXy_size:xy_size];
    }
}

- (void)setXy_origin:(CGPoint)xy_origin animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setXy_origin:xy_origin];
        }];
    } else {
        [self setXy_origin:xy_origin];
    }
}

- (void)setXy_width:(CGFloat)xy_width animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setXy_width:xy_width];
        }];
    } else {
        [self setXy_width:xy_width];
    }
}

- (void)setXy_height:(CGFloat)xy_height animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setXy_height:xy_height];
        }];
    } else {
        [self setXy_height:xy_height];
    }
}

@end
