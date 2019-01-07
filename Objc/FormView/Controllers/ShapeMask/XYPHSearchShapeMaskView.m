//
//  XYPHSearchShapeMaskView.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2018/12/3.
//

#import "XYPHSearchShapeMaskView.h"

@interface XYPHSearchShapeMaskView()

@property (nonatomic, strong) UIBezierPath *overlayPath;

@property (nonatomic, strong) NSMutableArray *transparentPaths;

@end

@implementation XYPHSearchShapeMaskView

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (CAShapeLayer *)fillLayer {
    return (CAShapeLayer *)self.layer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self refreshMask];
}

#pragma mark - Public Methods

- (void)setMaskColor:(UIColor *)maskColor {
    _maskColor = maskColor;
    
    [self refreshMask];
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

- (void)reset {
    [self.transparentPaths removeAllObjects];
    
    [self refreshMask];
}

- (void)addTransparentPath:(UIBezierPath *)transparentPath {
    [self.overlayPath appendPath:transparentPath];
    
    [self.transparentPaths addObject:transparentPath];
    
    self.fillLayer.path = self.overlayPath.CGPath;
}

- (void)addTransparentOvalRect:(CGRect)rect {
    UIBezierPath *transparentPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    [self addTransparentPath:transparentPath];
}

#pragma mark - Private Methods

- (void)setUp {
    self.backgroundColor = [UIColor clearColor];
    self.maskColor = [UIColor colorWithWhite:0 alpha:0.5]; // 50% transparent black

    self.fillLayer.path = self.overlayPath.CGPath;
    self.fillLayer.fillRule = kCAFillRuleEvenOdd;
    self.fillLayer.fillColor = self.maskColor.CGColor;
}

- (UIBezierPath *)generateOverlayPath {
    UIBezierPath *overlayPath = [UIBezierPath bezierPathWithRect:self.bounds];
    overlayPath.usesEvenOddFillRule = YES;
    return overlayPath;
}

- (UIBezierPath *)currentOverlayPath {
    UIBezierPath *overlayPath = [self generateOverlayPath];
    
    for (UIBezierPath *transparentPath in self.transparentPaths) {
        [overlayPath appendPath:transparentPath];
    }
    
    return overlayPath;
}

- (void)refreshMask {
    self.overlayPath = [self currentOverlayPath];

    self.fillLayer.path = self.overlayPath.CGPath;
    self.fillLayer.fillColor = self.maskColor.CGColor;
}

#pragma mark - Setter and Getter Methods

- (UIBezierPath *)overlayPath {
    if (!_overlayPath) {
        _overlayPath = [self generateOverlayPath];
    }
    
    return _overlayPath;
}

- (NSMutableArray *)transparentPaths {
    if (!_transparentPaths) {
        _transparentPaths = [NSMutableArray array];
    }
    return _transparentPaths;
}

@end
