//
//  XYPHImageTextControl.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/2.
//

#import "XYPHImageTextControl.h"

@interface XYPHImageTextControl()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *textLabel;


@end

@implementation XYPHImageTextControl


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imagePosition = XYPHImageTextControlPositionLeft;
        [self addSubview:self.imageView];
        [self addSubview:self.textLabel];
    }
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
    
    switch (self.imagePosition) {
        case XYPHImageTextControlPositionTop: {
            self.textLabel.textAlignment = NSTextAlignmentCenter;
            [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
            [self.imageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
            [self.imageView.trailingAnchor constraintLessThanOrEqualToAnchor:self.trailingAnchor].active = YES;
            
            [self.textLabel.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:_interval].active = YES;
            [self.textLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
            [self.textLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
            [self.textLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        }
            break;
        case XYPHImageTextControlPositionLeft: {
            [self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
            [self.imageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
            [self.imageView.bottomAnchor constraintLessThanOrEqualToAnchor:self.bottomAnchor].active = YES;
            
            [self.textLabel.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:_interval].active = YES;
            [self.textLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
            [self.textLabel.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
            [self.textLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
        }
            break;
        case XYPHImageTextControlPositionBottom: {
            self.textLabel.textAlignment = NSTextAlignmentCenter;
            [self.textLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
            [self.textLabel.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
            [self.textLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
            
            [self.imageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
            [self.imageView.topAnchor constraintEqualToAnchor:self.textLabel.bottomAnchor constant:_interval].active = YES;
            [self.imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
            [self.imageView.trailingAnchor constraintLessThanOrEqualToAnchor:self.trailingAnchor].active = YES;
        }
            break;
        case XYPHImageTextControlPositionRight: {
            [self.textLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
            [self.textLabel.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
            [self.textLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
            
            [self.imageView.leadingAnchor constraintEqualToAnchor:self.textLabel.trailingAnchor constant:_interval].active = YES;
            [self.imageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
            [self.imageView.bottomAnchor constraintLessThanOrEqualToAnchor:self.bottomAnchor].active = YES;
            [self.imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
        }
            break;
        default:
            break;
    }
}

- (void)setImagePosition:(XYPHImageTextControlPosition)imagePosition {
    _imagePosition = imagePosition;
    [self setNeedsUpdateConstraints];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textLabel.text = text;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.textLabel.textColor = textColor;
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    self.textLabel.font = textFont;
}

- (void)setInterval:(CGFloat)interval {
    _interval = interval;
    [self setNeedsUpdateConstraints];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = NO;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.userInteractionEnabled = NO;
        _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _textLabel;
}

@end
