//
//  ImageTextView.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/7.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "ImageTextView.h"
#import <Masonry.h>

@interface ImageTextView()

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) UILabel *textLabel;


@end

@implementation ImageTextView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.textLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    switch (self.imagePosition) {
        case ImageTextViewPositionTop: {
            self.textLabel.textAlignment = NSTextAlignmentCenter;
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.centerX.mas_equalTo(0);
                make.trailing.mas_lessThanOrEqualTo(0);
            }];
            
            [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.imageView.mas_bottom).offset(self.interval);
                make.bottom.leading.trailing.mas_equalTo(0);
            }];
        }
            break;
        case ImageTextViewPositionLeft: {
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.centerY.mas_equalTo(0);
                make.bottom.mas_lessThanOrEqualTo(0);
            }];
            
            [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self.imageView.mas_trailing).offset(self.interval);
                make.top.bottom.trailing.mas_equalTo(0);
            }];
        }
            break;
        case ImageTextViewPositionBottom: {
            self.textLabel.textAlignment = NSTextAlignmentCenter;
            [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.leading.trailing.mas_equalTo(0);
            }];
            
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.textLabel.mas_bottom).offset(self.interval);
                make.centerX.bottom.mas_equalTo(0);
                make.trailing.mas_lessThanOrEqualTo(0);
            }];
        }
            break;
        case ImageTextViewPositionRight: {
            [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.top.bottom.mas_equalTo(0);
                make.centerY.mas_equalTo(self.imageView);
            }];
            
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self.textLabel.mas_trailing).offset(self.interval);
                make.bottom.mas_lessThanOrEqualTo(0);
                make.trailing.mas_equalTo(0);
            }];
        }
            break;
        default:
            break;
    }
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textLabel.text = text;
    [self setNeedsLayout];
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
    [self setNeedsLayout];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
    }
    return _textLabel;
}

@end
