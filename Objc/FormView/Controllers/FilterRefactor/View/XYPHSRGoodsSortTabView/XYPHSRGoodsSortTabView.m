//
//  XYPHSRGoodsSortTabView.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/23.
//

#import <Masonry/Masonry.h>
#import "UIView+Extension.h"

#import "XYPHSRGoodsSortTabView.h"

#import "XYPHSRGoodsSortButton.h"

#import "XYPHSearchUtil.h"

#import "XYPHSFViewControllerPresenter.h"

@interface XYPHSRGoodsSortTabView()

@property (nonatomic, strong) XYPHSRGoodsSortButton *filterButton;

@property (nonatomic, strong) UIStackView *stackView;

@property (nonatomic, strong) UIView *verticalLine;

@property (nonatomic, strong) UIView *separatorView;

@property (nonatomic, strong) XYPHSRGoodsSortButton *defaultSortButton;

@property (nonatomic, strong) XYPHSRGoodsSortButton *salesSortButton;

@property (nonatomic, strong) XYPHSRGoodsSortButton *newsSortButton;

@property (nonatomic, strong) XYPHSRGoodsSortButton *priceSortButton;

@end


@implementation XYPHSRGoodsSortTabView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColor.whiteColor;
        
        [self addSubview:self.stackView];
        [self addSubview:self.verticalLine];
        [self addSubview:self.filterButton];
        
        [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.bottom.mas_equalTo(0);
        }];
        
        [self.verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.stackView.mas_trailing);
            make.size.mas_equalTo(CGSizeMake(XYPHSearchUtil.pixelOne, 20));
            make.centerY.mas_equalTo(0);
        }];
        
        
        [self.filterButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.verticalLine.mas_trailing);
            make.top.bottom.trailing.mas_equalTo(0);
            make.width.mas_equalTo(75);
        }];
        
        [self addSubview:self.separatorView];
        [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.mas_equalTo(0);
            make.height.mas_equalTo(XYPHSearchUtil.pixelOne);
        }];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}


- (void)refresh {
    self.filterButton.selected = self.selectedFilters.filterCount > 0;
}

#pragma mark Actions

- (void)filterButtonEvent:(XYPHSRGoodsSortButton *)sender {
    UIViewController *vc = self.viewController;
    if ([vc conformsToProtocol:@protocol(XYPHSRSortTabViewDelegate)]) {
        [(id <XYPHSRSortTabViewDelegate>)vc sortTabCellFilterButtonClicked:self];
    }
}

- (void)defaultSortButtonEvent:(XYPHSRGoodsSortButton *)sender {
    if (sender.isSelected) { return; }
    [self updateButtonSelected:sender];
    [self sortButtonClicked];
}

- (void)salesSortButtonEvent:(XYPHSRGoodsSortButton *)sender {
    if (sender.isSelected) { return; }
    [self updateButtonSelected:sender];
    [self sortButtonClicked];
}

- (void)newsSortButtonEvent:(XYPHSRGoodsSortButton *)sender {
    if (sender.isSelected) { return; }
    [self updateButtonSelected:sender];
    [self sortButtonClicked];
}

- (void)priveSortButtonEvent:(XYPHSRGoodsSortButton *)sender {
    if (sender.isSelected) { return; }
    [self updateButtonSelected:sender];
    [self sortButtonClicked];
}


#pragma mark private
- (void)sortButtonClicked {
    UIViewController *vc = self.viewController;
    if ([vc conformsToProtocol:@protocol(XYPHSRSortTabViewDelegate)]) {
        [(id <XYPHSRSortTabViewDelegate>)vc sortTabCellSortButtonClicked:self];
    }
}

- (XYSFSelectedFilters *)selectedFilters {
    UIViewController *vc = self.viewController;
    if ([vc conformsToProtocol:@protocol(XYPHSFViewControllerPresenter)]) {
        return [(id <XYPHSFViewControllerPresenter>)vc selectedFilters];
    }
    return nil;
}

- (void)updateButtonSelected:(UIButton *)sender {
    [self resetButtons];
    sender.selected = YES;
}

- (void)resetButtons {
    for (XYPHSRGoodsSortButton *view in self.stackView.arrangedSubviews) {
        [view setSelected:NO];
    }
}

- (UIView *)verticalLine {
    if (!_verticalLine) {
        _verticalLine = XYPHSearchUtil.separatorLine;
    }
    return _verticalLine;
}

- (XYPHSRGoodsSortButton *)filterButton {
    if (!_filterButton) {
        _filterButton = XYPHSRGoodsSortButton.new;
        [_filterButton setTitle:@"筛选" forState:UIControlStateNormal];
        [_filterButton setImage:[UIImage imageNamed:@"filter_button_normal"] forState:UIControlStateNormal];
        [_filterButton setImage:[UIImage imageNamed:@"filter_button_selected"] forState:UIControlStateSelected];
        _filterButton.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        _filterButton.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        _filterButton.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        _filterButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
        [_filterButton addTarget:self action:@selector(filterButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _filterButton;
}

- (XYPHSRGoodsSortButton *)defaultSortButton {
    if (!_defaultSortButton) {
        _defaultSortButton = XYPHSRGoodsSortButton.new;
        [_defaultSortButton setTitle:@"综合" forState:UIControlStateNormal];
        [_defaultSortButton addTarget:self action:@selector(defaultSortButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _defaultSortButton;
}

- (XYPHSRGoodsSortButton *)salesSortButton {
    if (!_salesSortButton) {
        _salesSortButton = XYPHSRGoodsSortButton.new;
        [_salesSortButton setTitle:@"销量" forState:UIControlStateNormal];
        [_salesSortButton addTarget:self action:@selector(salesSortButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _salesSortButton;
}

- (XYPHSRGoodsSortButton *)newsSortButton {
    if (!_newsSortButton) {
        _newsSortButton = XYPHSRGoodsSortButton.new;
        [_newsSortButton setTitle:@"最新" forState:UIControlStateNormal];
        [_newsSortButton addTarget:self action:@selector(newsSortButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _newsSortButton;
}

- (XYPHSRGoodsSortButton *)priceSortButton {
    if (!_priceSortButton) {
        _priceSortButton = XYPHSRGoodsSortButton.new;
        [_priceSortButton setTitle:@"价格" forState:UIControlStateNormal];
        [_priceSortButton addTarget:self action:@selector(newsSortButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _priceSortButton;
}

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] initWithArrangedSubviews:@[
                                                                     self.defaultSortButton,
                                                                         self.salesSortButton,
                                                                         self.newsSortButton,
                                                                         self.priceSortButton
                                                                         ]];
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.axis = UILayoutConstraintAxisHorizontal;
    }
    return _stackView;
}

- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = XYPHSearchUtil.separatorLine;
    }
    return _separatorView;
}


@end
