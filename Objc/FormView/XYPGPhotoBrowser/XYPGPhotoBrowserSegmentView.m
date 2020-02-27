//
//  XYPGPhotoBrowserSegmentView.m
//  FormView
//
//  Created by 黄伯驹 on 2020/2/27.
//  Copyright © 2020 黄伯驹. All rights reserved.
//

#import "XYPGPhotoBrowserSegmentView.h"

@interface XYPGPhotoBrowserSegmentView()

@property (nonatomic, strong) UIButton *videoButton;

@property (nonatomic, strong) UIButton *albumButton;

@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation XYPGPhotoBrowserSegmentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.videoButton, self.albumButton]];
        stackView.spacing = 30;
        stackView.axis = UILayoutConstraintAxisHorizontal;
        [self addSubview:stackView];
    }
    return self;
}

- (UIButton *)videoButton {
    if (!_videoButton) {
        _videoButton = [self generateButtonWithTitle:@"视频"];
    }
    return _videoButton;
}

- (UIButton *)albumButton {
    if (!_albumButton) {
        _albumButton = [self generateButtonWithTitle:@"图集"];
    }
    return _albumButton;
}

- (UIButton *)generateButtonWithTitle:(NSString *)title {
    UIButton *button = UIButton.new;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    return button;
}

@end
