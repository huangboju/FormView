//
//  TitleView.m
//  FormView
//
//  Created by xiAo_Ju on 30/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYPHBindAccountTitleView.h"

#import <Masonry.h>

@interface XYPHBindAccountTitleView()

@property (nonatomic, strong, readwrite) UILabel *titleLabel;

@end

@implementation XYPHBindAccountTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(40);
            make.bottom.mas_equalTo(-20);
            make.leading.trailing.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setText:(NSString *)text {
    self.titleLabel.text = text;
}

- (NSString *)text {
    return self.titleLabel.text;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


@end
