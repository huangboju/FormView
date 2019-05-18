//
//  FilterRefactorVC.m
//  FormView
//
//  Created by 黄伯驹 on 2019/5/2.
//  Copyright © 2019 黄伯驹. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "FilterRefactorVC.h"

#import "XYPHSRGoodsSortTabView.h"
#import "XYPHSRGoodsFilterTabView.h"
#import "XYPHSearchUtil.h"
#import "XYPHSFGoodsViewController.h"
#import "XYPHSGPriorityFilterViewController.h"

#import "FilterRefactorDataSource.h"

#import "UIColor+Hex.h"

#import "XYPHSearchFilterScreenEdgePanGestureRecognizer.h"

@interface FilterRefactorVC ()
<
XYPHSFViewControllerPresenter,
XYPHSFViewControllerDelegate,
XYPHSRSortTabViewDelegate,
XYPHSRGoodsFilterTabViewDelegate
>

@property (nonatomic, strong) XYPHSRGoodsSortTabView *sortTabCellView;

@property (nonatomic, strong) XYPHSRGoodsFilterTabView *filterTabView;

@property (nonatomic, strong) XYPHSFGoodsViewController *filterVC;
@property (nonatomic, strong) XYPHSGPriorityFilterViewController *priorityFilterVC;

@property (nonatomic, strong) FilterRefactorDataSource *dataSource;

@property (nonatomic, strong) XYPHSearchFilterScreenEdgePanGestureRecognizer *edgePan;

@property (nonatomic, strong) UITextView *textView;

@end

@implementation FilterRefactorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHex:0x1E90FF];
    
    [self requestFilters];
    [self initSubviews];
    [self initScreenEdgePanGesture];
}

#pragma mark <XYPHSRSortTabViewDelegate>
- (void)sortTabCellFilterButtonClicked:(XYPHSRGoodsSortTabView *)cell {
    [self showFilterViewController];
}

- (void)sortTabCellSortButtonClicked:(XYPHSRGoodsSortTabView *)cell {
    
}

#pragma mark <XYPHSRGoodsFilterTabViewDelegate>
- (void)goodsFilterTabCellNonSelectedItemDidSelecte:(XYPHSRGoodsFilterTabView *)cell {
    [self printFiltersIfNeeded];
    [self.priorityFilterVC dismissIfNeeded];
    [self.sortTabCellView refresh];
}

- (void)goodsFilterTabCellItemDidSelecte:(XYPHSRGoodsFilterTabView *)cell {
    XYPHSRGoodsFilterTabViewModel *viewData = cell.viewData;
    self.priorityFilterVC.viewData = viewData.selectedFilterGroup;
    [self.priorityFilterVC showInViewController:self];
}

- (void)goodsFilterTabCellItemDidDeselecte:(XYPHSRGoodsFilterTabView *)cell {
    [self.priorityFilterVC dismissIfNeeded];
}

#pragma mark <XYPHSFViewControllerDelegate>

- (void)searchFilterViewControllerDoneButtonClicked:(UIViewController <XYPHSFViewControllerPresenter> *)viewController {
    [self printFiltersIfNeeded];
    [self.filterTabView refresh];
    [self.sortTabCellView refresh];
}

- (void)searchFilterViewControllerDidChangedSelectedTag:(UIViewController <XYPHSFViewControllerPresenter> *)viewController {
    [self printFiltersIfNeeded];
}

- (void)requestFilters {
    __weak typeof(self) weakself = self;
    [self.filterVC requsetFilters:^(XYPHSearchGoodsFilter * _Nonnull model) {
        if (model) {
            weakself.edgePan.enabled = model.filterGroups.count > 0;
            XYPHSRGoodsFilterTabViewModel *cellModel = [XYPHSRGoodsFilterTabViewModel modelWithModel:model];
            [weakself.filterTabView updateViewData:cellModel];
        }
    }];
}

- (void)initSubviews {
    CGFloat top = 44 + UIApplication.sharedApplication.statusBarFrame.size.height;
    _sortTabCellView = [[XYPHSRGoodsSortTabView alloc] initWithFrame:CGRectMake(0, top, CGRectGetWidth(self.view.frame), kDefaultToolBarHeight)];
    [self.view addSubview:_sortTabCellView];
    
    _filterTabView = [[XYPHSRGoodsFilterTabView alloc] initWithFrame:CGRectMake(0, top + kDefaultToolBarHeight, CGRectGetWidth(self.view.frame), kDefaultToolBarHeight)];
    [self.view addSubview:_filterTabView];
    
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.center.mas_equalTo(0);
        make.height.mas_equalTo(300);
    }];
}

- (void)initScreenEdgePanGesture {
    __weak typeof(self) weakself = self;
    self.edgePan = [XYPHSearchFilterScreenEdgePanGestureRecognizer gestureBeginHandleBlock:^(XYPHSearchFilterPresentAnimator *animator) {
        [weakself showFilterViewController];
    }];
    self.edgePan.finishHandleBlock = ^{
        
    };
    [self.view addGestureRecognizer:self.edgePan];
}

- (void)showFilterViewController {
    if (!self.filterVC.needShow) { return; }
    self.filterVC.modalPresentationStyle = UIModalPresentationCustom;
    self.filterVC.transitioningDelegate = self.edgePan.animator;
    [self presentViewController:self.filterVC animated:YES completion:nil];
}

- (void)printFiltersIfNeeded {
    if (self.dataSource.filtersChanged) {
        self.textView.text = self.selectedFilters.description;
    }
}

- (XYPHSFGoodsViewController *)filterVC {
    if (!_filterVC) {
        _filterVC = XYPHSFGoodsViewController.new;
        _filterVC.delegate = self;
        _filterVC.keyword = @"口红";
        [_filterVC referenceSelectedFilters:self.selectedFilters];
    }
    return _filterVC;
}

- (XYPHSGPriorityFilterViewController *)priorityFilterVC {
    if (!_priorityFilterVC) {
        _priorityFilterVC = XYPHSGPriorityFilterViewController.new;
        _priorityFilterVC.keyword = @"口红";
        _priorityFilterVC.delegate = self;
        [_priorityFilterVC referenceSelectedFilters:self.selectedFilters];
    }
    return _priorityFilterVC;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = UITextView.new;
        _textView.font = [UIFont boldSystemFontOfSize:15];
        _textView.editable = NO;
        _textView.backgroundColor = UIColor.whiteColor;
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:1].CGColor;
    }
    return _textView;
}

#pragma mark <XYPHSFViewControllerPresenter>
- (XYSFSelectedFilters *)selectedFilters {
    return self.dataSource.selectedFilters;
}

- (FilterRefactorDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = FilterRefactorDataSource.new;
    }
    return _dataSource;
}

@end
