//
//  XYPHSRGoodsFilterTabView.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/24.
//

#import <Masonry/Masonry.h>
#import "UIView+Extension.h"

#import "XYPHImageTextControl.h"

#import "XYPHSRGoodsFilterTabView.h"

#import "XYPHSearchResultGoodsFilterButton.h"

#import "XYPHSearchGoodsFilter.h"
#import "XYPHSearchUtil.h"

#import "XYPHSFViewControllerPresenter.h"

static const NSInteger kFilterButtonTag = 1024;

@interface XYPHSRGoodsFilterTabViewModel()

@property (nonatomic, strong) NSArray <XYPHSearchGoodsFilterGroup *> *filterGroups;

@property (nonatomic, assign) NSInteger selectedFilterGroupIndex;

@end


@implementation XYPHSRGoodsFilterTabViewModel

+ (instancetype)modelWithModel:(XYPHSearchGoodsFilter *)model {
    XYPHSRGoodsFilterTabViewModel *cellModel = XYPHSRGoodsFilterTabViewModel.new;
    NSMutableArray <XYPHSearchGoodsFilterGroup *> *result = [NSMutableArray arrayWithCapacity:4];
    for (XYPHSearchGoodsFilterGroup *group in model.filterGroups) {
        // 最多只显示四个
        if (!group.invisible && result.count < 5) {
            [result addObject:group];
        }
    }
    cellModel.selectedFilterGroupIndex = -1;
    cellModel.filterGroups = result.copy;
    return cellModel;
}

- (CGSize)horizontalCellSize {
    return self.cellSize;
}

- (CGSize)cellSize {
    return CGSizeMake(CGRectGetWidth(UIScreen.mainScreen.bounds), kDefaultToolBarHeight);
}

- (XYPHSearchGoodsFilterGroup *)selectedFilterGroup {
    if (_selectedFilterGroupIndex == -1) { return nil; }
    return _filterGroups[_selectedFilterGroupIndex];
}

- (BOOL)isNonSelectedFilterGroup {
    return self.selectedFilterGroup.isNonSelected;
}

@end



@interface XYPHSRGoodsFilterTabView()

@property (nonatomic, strong) UIStackView *stackView;

@property (nonatomic, strong) UIView *separatorView;

@property (nonatomic, strong) XYPHSRGoodsFilterTabViewModel *viewData;

@end



@implementation XYPHSRGoodsFilterTabView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        
        [self addSubview:self.separatorView];
        [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.mas_equalTo(0);
            make.height.mas_equalTo(XYPHSearchUtil.pixelOne);
        }];
        
        [self addSubview:self.stackView];
        [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(10);
            make.center.mas_equalTo(0);
            make.height.mas_equalTo(26);
        }];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}

- (void)updateViewData:(XYPHSRGoodsFilterTabViewModel *)viewData {
    if ([_viewData isEqual:viewData]) { return; }
    _viewData = viewData;
    NSArray <XYPHSearchResultGoodsFilterButton *> *buttons = self.stackView.arrangedSubviews;
    [buttons makeObjectsPerformSelector:@selector(setUserInteractionEnabled:) withObject:nil];
    NSInteger index = 0;
    for (XYPHSearchGoodsFilterGroup *filter in self.viewData.filterGroups) {
        XYPHSearchResultGoodsFilterButton *button = buttons[index];
        button.userInteractionEnabled = YES;
        [button updateViewData:filter];
        button.selected = [self.selectedFilters containsGroup:filter.groupId];
        index += 1;
    }
}

- (void)refresh {
    NSArray <XYPHSearchResultGoodsFilterButton *> *buttons = self.stackView.arrangedSubviews;
    for (XYPHSearchResultGoodsFilterButton *button in buttons) {
        button.expanding = NO;
        button.selected = [self.selectedFilters containsGroup:button.viewData.groupId];
    }
}

- (void)filterButtonClickded:(XYPHSearchResultGoodsFilterButton *)sender {
    if (self.selectedFilters.isOutOfRange) { return; }
    _viewData.selectedFilterGroupIndex = sender.tag - kFilterButtonTag;
    UIViewController *vc = self.viewController;
    if ([vc conformsToProtocol:@protocol(XYPHSRGoodsFilterTabViewDelegate)]) {
        if (_viewData.isNonSelectedFilterGroup) {
            [self refresh];
            NSString *groupId = sender.viewData.groupId;
            sender.selected = !sender.isSelected;
            if (sender.isSelected) {
                [self.selectedFilters addSingleFilterToGroup:groupId tagId:sender.viewData.nonSelectedTag.tagId];
            } else {
                [self.selectedFilters removeFiltersWithGroupId:groupId];
            }
            [(id <XYPHSRGoodsFilterTabViewDelegate>)vc goodsFilterTabCellNonSelectedItemDidSelecte:self];
        } else {
            if (sender.isExpanding) {
                sender.expanding = NO;
                [(id <XYPHSRGoodsFilterTabViewDelegate>)vc goodsFilterTabCellItemDidDeselecte:self];
            } else {
                // 这里主要还原之前是展开的按钮
                [self refresh];
                sender.expanding = YES;
            }
            [(id <XYPHSRGoodsFilterTabViewDelegate>)vc goodsFilterTabCellItemDidSelecte:self];
        }
    }
}

- (XYSFSelectedFilters *)selectedFilters {
    UIViewController *vc = self.viewController;
    if ([vc conformsToProtocol:@protocol(XYPHSFViewControllerPresenter)]) {
        return [(id <XYPHSFViewControllerPresenter>)vc selectedFilters];
    }
    return nil;
}

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = UIStackView.new;
        for (NSInteger i = 0; i < 4; i++) {
            XYPHSearchResultGoodsFilterButton *button = XYPHSearchResultGoodsFilterButton.new;
            button.tag = kFilterButtonTag + i;
            button.userInteractionEnabled = NO;
            [button addTarget:self action:@selector(filterButtonClickded:) forControlEvents:UIControlEventTouchUpInside];
            [_stackView addArrangedSubview:button];
        }
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.spacing = 10;
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
