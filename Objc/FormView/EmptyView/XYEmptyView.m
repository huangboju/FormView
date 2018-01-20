//
//  EmptyView.m
//  FormView
//
//  Created by 黄伯驹 on 27/12/2017.
//  Copyright © 2017 黄伯驹. All rights reserved.
//

#import "XYEmptyView.h"

@interface XYEmptyView()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) NSLayoutConstraint *imageViewTop;

@end

@implementation XYEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self didInitialized];
    }
    return self;
}

- (void)didInitialized {
    self.topInterval = 100;
    self.textFont = [UIFont systemFontOfSize:13];
    self.textColor = [UIColor colorWithRed:153.f / 255.0 green:153.f / 255.0 blue:153.f / 255.0 alpha:1];
    self.image = [UIImage imageNamed:@"empty_placeholder_default"];
    self.text = NSLocalizedStringFromTable(@"emptyTitleDefault", @"EmptyView", @"这里什么都没有");


    self.backgroundColor = [UIColor colorWithRed:245.f / 255.0 green:248.f / 255.0 blue:250.f / 255.0 alpha:1];

    [self addSubview:self.imageView];
    [self addSubview:self.textLabel];
    self.textLabel.font = self.textFont;
    self.textLabel.textColor = self.textColor;

    self.imageViewTop = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:self.topInterval];
    NSLayoutConstraint *imageViewCenterX = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];

    NSLayoutConstraint *textLabelTop = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeBottom multiplier:1 constant:15];
    NSLayoutConstraint *textLabelLeading = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:30];
    NSLayoutConstraint *textLabelCenterX = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];

    [self addConstraints:@[
                           self.imageViewTop,
                           imageViewCenterX,
                           textLabelTop,
                           textLabelLeading,
                           textLabelCenterX
                           ]];
}

- (void)setTopInterval:(CGFloat)topInterval {
    _topInterval = topInterval;
    self.imageViewTop.constant = topInterval;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textLabel.text = text;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedText = attributedText;
    self.textLabel.attributedText = attributedText;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.textLabel.textColor = textColor;
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    self.textLabel.font = textFont;
}

- (void)setButtonTitle:(NSString *)buttonTitle {
    _buttonTitle = buttonTitle;
    
    if (!(buttonTitle.length > 0)) { return; }
    UIColor *color = [UIColor colorWithRed:255.f / 255.0 green:65.f / 255.0 blue:39.f / 255.0 alpha:1];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.titleLabel.font = [UIFont systemFontOfSize:13];
    [_button setTitle:buttonTitle forState:UIControlStateNormal];
    [_button setTitleColor:color forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor colorWithWhite:0.9 alpha:1] forState:UIControlStateHighlighted];
    _button.layer.cornerRadius = 4;
    _button.layer.borderWidth = 0.5;
    _button.layer.borderColor = color.CGColor;
    [self addSubview:_button];

    [self setConstraintWithButton:_button];
}

- (void)setButton:(UIButton *)button {

    _button = button;

    if (!button) { return; }

    [self addSubview:button];

    [self setConstraintWithButton:button];
}

- (void)setConstraintWithButton:(UIButton *)button {
    button.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *buttonTop = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.textLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    NSLayoutConstraint *buttonCenterX = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];

    NSLayoutConstraint *buttonWidth = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:button.intrinsicContentSize.width + 36];

    [self addConstraints:@[
                           buttonTop,
                           buttonCenterX,
                           buttonWidth
                           ]];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        // 最多只会有三行文字
        _textLabel.numberOfLines = 3;
        _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _textLabel;
}

@end
