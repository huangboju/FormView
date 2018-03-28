//
//  BindStatusView.m
//  FormView
//
//  Created by 黄伯驹 on 27/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "BindStatusView.h"

#import <FDStackView.h>

#import <Masonry.h>

#import "ImageTextView.h"

@implementation BindStatusViewItem

@end

@interface BindStatusView()

@property (nonatomic, strong) FDStackView *stackView;

@end

@implementation BindStatusView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.stackView];
        [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(20);
            make.top.mas_equalTo(25);
            make.bottom.mas_equalTo(-15);
            make.centerY.mas_equalTo(0).priorityLow();
        }];
    }
    return self;
}

- (FDStackView *)stackView {
    if (!_stackView) {
        _stackView = [FDStackView new];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.spacing = 5;
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.alignment = UIStackViewAlignmentLeading;
    }
    return _stackView;
}

- (void)updateViewData:(NSArray <BindStatusViewItem *>*)viewData {
    for (BindStatusViewItem *item in viewData) {
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
