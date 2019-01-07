//
//  XYShapeMaskLayer.m
//  FormView
//
//  Created by xiAo_Ju on 2019/1/7.
//  Copyright © 2019 黄伯驹. All rights reserved.
//

#import "XYShapeMaskLayer.h"

@interface XYShapeMaskLayer()

@property (nonatomic) UIBezierPath *overlayPath;

@end


@implementation XYShapeMaskLayer

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [self init]) {
        self.frame = frame;
        [self setUp];
    }
    return self;
}

#pragma mark - Public Methods

- (void)setMaskColor:(UIColor *)maskColor {
    _maskColor = maskColor;
    
    self.fillColor = self.maskColor.CGColor;
}

- (void)addTransparentRect:(CGRect)rect {
    UIBezierPath *transparentPath = [UIBezierPath bezierPathWithRect:rect];
    
    [self addTransparentPath:transparentPath];
}

- (void)addTransparentRoundedRect:(CGRect)rect
                     cornerRadius:(CGFloat)cornerRadius {
    UIBezierPath *transparentPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    
    [self addTransparentPath:transparentPath];
}

- (void)addTransparentRoundedRect:(CGRect)rect
                byRoundingCorners:(UIRectCorner)corners
                      cornerRadii:(CGSize)cornerRadii {
    UIBezierPath *transparentPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
    
    [self addTransparentPath:transparentPath];
}

- (void)addCustomBezierPath:(UIBezierPath *)path {
    [self addTransparentPath:path];
}

- (void)addTransparentPath:(UIBezierPath *)transparentPath {
    [self.overlayPath appendPath:transparentPath];
    
    self.path = self.overlayPath.CGPath;
}

- (void)addTransparentOvalRect:(CGRect)rect {
    UIBezierPath *transparentPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    [self addTransparentPath:transparentPath];
}

- (void)layoutSublayers {
    [super layoutSublayers];
    [self refreshMask];
}

#pragma mark - Private Methods

- (void)setUp {
    self.backgroundColor = [UIColor clearColor].CGColor;
    self.maskColor = [UIColor whiteColor];
    
    self.path = self.overlayPath.CGPath;
    self.fillRule = kCAFillRuleEvenOdd;
}

- (void)refreshMask {
    self.path = self.overlayPath.CGPath;
    self.fillColor = self.maskColor.CGColor;
}

- (UIBezierPath *)overlayPath {
    if (!_overlayPath) {
        _overlayPath = [self generateBezierPath];
    }
    return _overlayPath;
}

- (UIBezierPath *)generateBezierPath {
    UIBezierPath *overlayPath = [UIBezierPath bezierPathWithRect:self.bounds];
    overlayPath.usesEvenOddFillRule = YES;
    return overlayPath;
}


@end
