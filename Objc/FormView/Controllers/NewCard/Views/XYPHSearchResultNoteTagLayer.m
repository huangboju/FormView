//
//  TagLayer.m
//  FormView
//
//  Created by xiAo_Ju on 2018/5/14.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYPHSearchResultNoteTagLayer.h"
#import "UIColor+Hex.h"

@interface XYPHSearchResultNoteTagLayer()

@property (nonatomic, strong) CALayer *imageLayer;

@property (nonatomic, strong) CATextLayer *textLayer;

@end

@implementation XYPHSearchResultNoteTagLayer

- (instancetype)init {
    if (self = [super init]) {
        
        self.borderWidth = 0.5f;
        self.cornerRadius = 12;
        self.backgroundColor = [UIColor colorWithHex:0x666666 alpha:0.4].CGColor;
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
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
    CGFloat y = (self.bounds.size.height - size.height) / 2 - 1;
    CGFloat x = CGRectGetMaxX(self.imageLayer.frame) + 5;
    size.width = MIN(size.width, self.maxWidth - x - 10);
    CGRect rect = CGRectMake(x, y, size.width, size.height);
    self.textLayer.frame = rect;
    [CATransaction commit];
    
    CGRect oldFrame = self.frame;
    oldFrame.size.width = CGRectGetMaxX(rect) + 10;
    self.frame = oldFrame;
}

- (void)setText:(NSString *)text {
    _text = text;
    NSAssert(_text, @"字符串不能为nil");
    if (!_text) {
        _text = @"";
    }
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName: [UIColor whiteColor],
                                 NSFontAttributeName: self.font
                                 };
    NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    self.textLayer.string = attributedStr;
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

- (void)setFont:(UIFont *)font {
    _font = font;
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    self.textLayer.font = fontRef;
    self.textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
}

- (CATextLayer *)textLayer {
    if (!_textLayer) {
        _textLayer = [CATextLayer layer];
        _textLayer.truncationMode = kCATruncationEnd;
        _textLayer.contentsScale = [UIScreen mainScreen].scale;
        _textLayer.alignmentMode = kCAAlignmentLeft;
    }
    return _textLayer;
}

- (CALayer *)imageLayer {
    if (!_imageLayer) {
        _imageLayer = [CALayer layer];
        _imageLayer.contentsScale = [UIScreen mainScreen].scale;
        _imageLayer.frame = CGRectMake(5, 5, 14, 14);
    }
    return _imageLayer;
}

@end
