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

@interface BindStatusView()

@property (nonatomic, strong) FDStackView *stackView;

@end

@implementation BindStatusView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.stackView];
        [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(20);
            make.top.mas_equalTo(15);
            make.centerX.centerY.mas_equalTo(0);
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

- (void)updateViewData:(NSArray <NSString *>*)viewData {
    for (NSString *text in viewData) {
        ImageTextView *imageTextView = [ImageTextView new];
        imageTextView.textFont = [UIFont systemFontOfSize:11];
        imageTextView.text = text;
        
    }
}


@end
