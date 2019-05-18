//
//  XYPHSGPriorityFilterViewController.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/11.
//

#import <Masonry/Masonry.h>

#import "XYPHSGPriorityFilterViewController.h"

#import "XYPHSGFilterPresentationController.h"

#import "XYPHSearchFilterGroupButtonView.h"

#import "XYPHSGPriorityFilterView.h"

#import "XYPHSearchGoodsFilterGroup.h"

@interface XYPHSGPriorityFilterViewController () <XYPHSearchFilterGroupButtonViewDelegate, XYPHSGPriorityFilterViewDelegate>

@property (nonatomic, strong) XYPHSGPriorityFilterView *filterView;

@property (nonatomic, strong) XYPHSearchFilterGroupButtonView *groupButtonView;

@property (nonatomic, strong) XYSFSelectedFilters *selectedFilters;

@end

@implementation XYPHSGPriorityFilterViewController

- (void)showInViewController:(UIViewController *)vc {
    // 已经展开了直接刷新UI
    if (self.presentingViewController) {
        [self refreshUI];
    } else {
        XYPHSGFilterPresentationController *presentationController NS_VALID_UNTIL_END_OF_SCOPE;
        
        presentationController = [[XYPHSGFilterPresentationController alloc] initWithPresentedViewController:self presentingViewController:vc];
        
        self.transitioningDelegate = presentationController;
        
        [vc presentViewController:self animated:YES completion:NULL];
    }
}

- (void)dismissIfNeeded {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    if ([self.delegate respondsToSelector:@selector(searchFilterViewControllerDoneButtonClicked:)]) {
        [self.delegate searchFilterViewControllerDoneButtonClicked:self];
    }
    [super dismissViewControllerAnimated:flag completion:completion];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.filterView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.filterView];
    [self.groupButtonView attachInView:self.view];
    [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.groupButtonView.mas_top);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshUI];
}

#pragma mark <XYPHSearchFilterGroupButtonViewDelegate>
- (void)searchFilterGroupButtonViewClearButtonClicked:(XYPHSearchFilterGroupButtonView *)groupButtonView {
    [self.selectedFilters removeFiltersWithGroupId:_viewData.groupId];
    [self.filterView reloadData];
    if ([self.delegate respondsToSelector:@selector(searchFilterViewControllerDidChangedSelectedTag:)]) {
        [self.delegate searchFilterViewControllerDidChangedSelectedTag:self];
    }
}

- (void)searchFilterGroupButtonViewDoneButtonClicked:(XYPHSearchFilterGroupButtonView *)groupButtonView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark <XYPHSGPriorityFilterViewDelegate>
- (void)friorityFilterViewDidSelectItem:(XYPHSGPriorityFilterView *)friorityFilterView {
    if ([self.delegate respondsToSelector:@selector(searchFilterViewControllerDidChangedSelectedTag:)]) {
        [self.delegate searchFilterViewControllerDidChangedSelectedTag:self];
    }
}

- (void)setViewData:(XYPHSearchGoodsFilterGroup *)viewData {
    if ([_viewData isEqual:viewData]) { return; }
    _viewData = viewData;
    [self.filterView updateViewData:viewData];
}

- (void)refreshUI {
    [self.filterView reloadData];
    [self setContentHeight];
}

- (void)setContentHeight {
    NSInteger rowCount = (self.viewData.filterTags.count + 3 - 1) / 3;
    CGFloat height = 60.0 + 46 * rowCount;
    // offset = 61 * 2 + 80 + 36
    CGFloat offset = 238;
    if (@available(iOS 11.0, *)) {
        offset += UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom;
    }
    height = MAX(162, MIN(height, UIScreen.mainScreen.bounds.size.height - offset));
    self.preferredContentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, height);
}

- (void)referenceSelectedFilters:(XYSFSelectedFilters *)selectedFilters {
    _selectedFilters = selectedFilters;
}

- (void)setTotalCount:(NSInteger)totalCount {
    self.groupButtonView.totalCount = totalCount;
}

- (XYPHSGPriorityFilterView *)filterView {
    if (!_filterView) {
        _filterView = XYPHSGPriorityFilterView.new;
        _filterView.backgroundColor = UIColor.whiteColor;
    }
    return _filterView;
}

- (XYPHSearchFilterGroupButtonView *)groupButtonView {
    if (!_groupButtonView) {
        _groupButtonView = [XYPHSearchFilterGroupButtonView new];
        _groupButtonView.suffix = @"件商品";
    }
    return _groupButtonView;
}

@end
