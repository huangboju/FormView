//
//  XYPHBindAccountBindStatusView.m
//  FormView
//
//  Created by 黄伯驹 on 27/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYPHBindAccountBindStatusView.h"

#import <Masonry.h>

#import "ImageTextView.h"

@implementation XYPHBindAccountBindStatusViewItem

@end

@interface XYPHBindAccountBindStatusView()

@property (nonatomic, strong) UIStackView *stackView;

@end

@implementation XYPHBindAccountBindStatusView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.stackView];
        [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(20);
            make.top.mas_equalTo(25);
            make.bottom.mas_equalTo(-15).priorityHigh();
            make.centerY.mas_equalTo(0).priorityLow();
        }];
    }
    return self;
}

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [UIStackView new];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.spacing = 5;
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.alignment = UIStackViewAlignmentLeading;
    }
    return _stackView;
}

- (void)updateViewData:(NSArray <XYPHBindAccountBindStatusViewItem *>*)viewData {
    for (XYPHBindAccountBindStatusViewItem *item in viewData) {
        ImageTextView *imageTextView = [ImageTextView new];
        imageTextView.textFont = [UIFont systemFontOfSize:11];
        imageTextView.text = item.text;
        imageTextView.imagePosition = ImageTextViewPositionLeft;
        imageTextView.image = [UIImage imageNamed:item.socialType];
        imageTextView.interval = 12;
        [self.stackView addArrangedSubview:imageTextView];
    }
}


@end
