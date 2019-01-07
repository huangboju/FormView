//
//  XYPHSearchShapeImageView.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2018/12/3.
//

#import "XYPHSearchShapeImageView.h"

#import "XYShapeMaskLayer.h"

@interface XYPHSearchShapeImageView ()

@property (nonatomic, strong) XYShapeMaskLayer *shapeMaskLayer;

@end


@implementation XYPHSearchShapeImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.layer addSublayer:self.shapeMaskLayer];
    }
    return self;
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    [self addRoundedPathIfNeeded];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self addRoundedPathIfNeeded];
}

- (void)addRoundedPathIfNeeded {
    CGRect rect = self.bounds;
    if (!CGRectEqualToRect(CGRectZero, rect)) {
        if (self.cornerRadius > 0) {
            [self.shapeMaskLayer addTransparentRoundedRect:rect cornerRadius:self.cornerRadius];
        }
        self.shapeMaskLayer.frame = rect;
    }
}

- (void)addTransparentRoundedRect:(CGRect)rect
                byRoundingCorners:(UIRectCorner)corners
                      cornerRadii:(CGSize)cornerRadii {
    [self.shapeMaskLayer addTransparentRoundedRect:rect
                                byRoundingCorners:corners
                                      cornerRadii:cornerRadii];
}


- (void)setMaskColor:(UIColor *)maskColor {
    self.shapeMaskLayer.maskColor = maskColor;
}

- (UIColor *)maskColor {
    return self.shapeMaskLayer.maskColor;
}

- (XYShapeMaskLayer *)shapeMaskLayer {
    if (!_shapeMaskLayer) {
        _shapeMaskLayer = [[XYShapeMaskLayer alloc] initWithFrame:self.bounds];
    }
    return _shapeMaskLayer;
}

@end
