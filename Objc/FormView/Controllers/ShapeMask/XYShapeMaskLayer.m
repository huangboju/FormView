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

@property (nonatomic) NSMutableOrderedSet <UIBezierPath *> *subPathes;

@end


@implementation XYShapeMaskLayer

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [self init]) {
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor].CGColor;
        self.maskColor = [UIColor whiteColor];

        self.fillRule = kCAFillRuleEvenOdd;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    CGRect oldValue = self.frame;
    [super setFrame:frame];
    if (!CGRectIsEmpty(frame) && !CGRectEqualToRect(oldValue, frame)) {
        [self refreshPath];
    }
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


- (void)addTransparentOvalRect:(CGRect)rect {
    UIBezierPath *transparentPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    [self addTransparentPath:transparentPath];
}

- (void)addTransparentPath:(UIBezierPath *)transparentPath {
    [self.overlayPath appendPath:transparentPath];
    [self.subPathes addObject:transparentPath];
    self.path = self.overlayPath.CGPath;
}

#pragma mark - Private Methods

- (void)refreshPath {
    _overlayPath = [self generateBezierPath];
    for (UIBezierPath *subPath in self.subPathes) {
        [_overlayPath appendPath:subPath];
    }
    [self.subPathes removeAllObjects];
    self.path = self.overlayPath.CGPath;
}

- (UIBezierPath *)generateBezierPath {
    UIBezierPath *overlayPath = [UIBezierPath bezierPathWithRect:self.bounds];
    overlayPath.usesEvenOddFillRule = YES;
    return overlayPath;
}

- (NSMutableOrderedSet<UIBezierPath *> *)subPathes {
    if (!_subPathes) {
        _subPathes = [NSMutableOrderedSet new];
    }
    return _subPathes;
}

@end
