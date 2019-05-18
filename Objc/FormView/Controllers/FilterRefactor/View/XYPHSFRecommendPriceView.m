//
//  XYPHSearchFilterPriceSuggestCell.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/2/22.
//

#import <Masonry/Masonry.h>

#import "XYPHSFRecommendPriceView.h"
#import "XYPHSFRecommendPriceControl.h"
#import "XYPHSearchGoodsRecommendPriceRange.h"


@interface XYPHSFRecommendPriceView()

@property (nonatomic, strong) UIStackView *stackView;

@property (nonatomic, strong) NSArray <XYPHSearchGoodsRecommendPriceRange *> *viewData;

@property (nonatomic, strong) XYPHSearchGoodsRecommendPriceRange *selectedRange;

@property (nonatomic, assign) NSInteger selectedRangeIndex;

@end


@implementation XYPHSFRecommendPriceView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.stackView];
        self.selectedRangeIndex = -1;
        
        for (NSInteger i = 0; i < 3; i++) {
            XYPHSFRecommendPriceControl *recommendPriceControl = XYPHSFRecommendPriceControl.new;
            recommendPriceControl.tag = 1233 + i;
            [recommendPriceControl addTarget:self action:@selector(recommendPriceControlClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.stackView addArrangedSubview:recommendPriceControl];
        }
        
        [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)updateViewData:(NSArray <XYPHSearchGoodsRecommendPriceRange *> *)viewData {
    self.viewData = viewData;
    NSArray <XYPHSFRecommendPriceControl *> *arrangedSubviews = self.stackView.arrangedSubviews;
    NSInteger idx = 0;
    for (XYPHSFRecommendPriceControl *subView in arrangedSubviews) {
        XYPHSearchGoodsRecommendPriceRange *range = viewData[idx];
        subView.title = [NSString stringWithFormat:@"%@-%@", range.minPrice, range.maxPrice];
        subView.desc = range.desc;
        idx += 1;
    }
}

- (void)recommendPriceControlClicked:(XYPHSFRecommendPriceControl *)sender {
    if (sender.isSelected) {
        sender.selected = NO;
        self.selectedRange = nil;
        self.selectedRangeIndex = -1;
    } else {
        [self reset];
        sender.selected = YES;
        self.selectedRangeIndex = sender.tag - 1233;
        self.selectedRange = self.viewData[self.selectedRangeIndex];
    }
    if ([self.delegate respondsToSelector:@selector(secommendPriceCellItemClicked:)]) {
        [self.delegate secommendPriceCellItemClicked:self];
    }
}

- (void)updateSelectedStatusIfNeededWithMin:(NSString *)min
                                        max:(NSString *)max {
    [self reset];
    NSInteger idx = 0;
    for (XYPHSearchGoodsRecommendPriceRange *range in self.viewData) {
        if ([range.minPrice isEqualToString:min] && [range.maxPrice isEqualToString:max]) {
            XYPHSFRecommendPriceControl *subView = self.stackView.arrangedSubviews[idx];
            subView.selected = YES;
        }
        idx += 1;
    }
}

- (void)reset {
    NSArray <XYPHSFRecommendPriceControl *> *arrangedSubviews = self.stackView.arrangedSubviews;
    [arrangedSubviews makeObjectsPerformSelector:@selector(setSelected:) withObject:nil];
}


- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = UIStackView.new;
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.spacing = 10;
        _stackView.distribution = UIStackViewDistributionFillEqually;
    }
    return _stackView;
}

@end
