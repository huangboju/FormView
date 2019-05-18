//
//  XYPHSearchFilterCollectionHeaderShowMoreControl.m
//  Halo
//
//  Created by TomatoPeter on 2017/10/26.
//  Copyright © 2017年 XingIn. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "XYPHSearchFilterShowMoreControl.h"
#import "Theme.h"

@interface XYPHSearchFilterShowMoreControl()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation XYPHSearchFilterShowMoreControl

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@5);
            make.bottom.equalTo(@-5);
        }];
        
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(4);
            make.centerY.equalTo(self.titleLabel);
            make.right.equalTo(@-5);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.imageView.transform = selected ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformMakeRotation(0);
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (NSString *)title {
    return self.titleLabel.text;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = Theme.colorGrayLevel3;
        _titleLabel.font = Theme.fontSmall;
        _titleLabel.text = @"更多";
    }
    return _titleLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"search_filter_show_more_indicator"];
    }
    return _imageView;
}

@end
