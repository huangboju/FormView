//
//  TagLayer.m
//  FormView
//
//  Created by xiAo_Ju on 2018/5/14.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "TagLayer.h"
#import "UIColor+Hex.h"

@interface TagLayer()

@property (nonatomic, strong) CALayer *imageLayer;

@property (nonatomic, strong) CATextLayer *textLayer;

@end

@implementation TagLayer

- (instancetype)init {
    if (self = [super init]) {
        
        self.borderWidth = 0.5f;
        self.opacity = 0.4;
        self.cornerRadius = 12;
        self.backgroundColor = [UIColor colorWithHex:0x666666].CGColor;
        self.borderColor = [UIColor colorWithHex:0xFFFFFF].CGColor;
        
        self.maxWidth = 100;
        
        _imageSize = CGSizeMake(14, 14);
        self.font = [UIFont systemFontOfSize:12];

        [self addSublayer:self.textLayer];
        
        [self addSublayer:self.imageLayer];
    }
    return self;
}

- (void)layoutSublayers {
    [super layoutSublayers];

    CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
    CGFloat y = (self.bounds.size.height - size.height) / 2 - 1;
    size.width = MIN(size.width, self.maxWidth);
    CGRect rect = CGRectMake(CGRectGetMaxX(self.imageLayer.frame) + 6, y, size.width, size.height);
    self.textLayer.frame = rect;

    CGRect oldFrame = self.frame;
    oldFrame.size.width = CGRectGetMaxX(rect) + 10;
    self.frame = oldFrame;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textLayer.string = text;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageLayer.contents = (__bridge id _Nullable)(image.CGImage);
}

- (void)setImageSize:(CGSize)imageSize {
    _imageSize = imageSize;
    CGRect rect = self.imageLayer.frame;
    rect.size = imageSize;
    self.imageLayer.frame = rect;
}

- (CATextLayer *)textLayer {
    if (!_textLayer) {
        _textLayer = [CATextLayer layer];
        _textLayer.truncationMode = kCATruncationEnd;
        _textLayer.contentsScale = [UIScreen mainScreen].scale;
        _textLayer.alignmentMode = kCAAlignmentCenter;
        CFStringRef fontName = (__bridge CFStringRef)self.font.fontName;
        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
        _textLayer.font = fontRef;
        _textLayer.fontSize = self.font.pointSize;
        CGFontRelease(fontRef);
    }
    return _textLayer;
}

- (CALayer *)imageLayer {
    if (!_imageLayer) {
        _imageLayer = [CALayer layer];
        _imageLayer.frame = CGRectMake(4, 5, 14, 14);
    }
    return _imageLayer;
}

@end
