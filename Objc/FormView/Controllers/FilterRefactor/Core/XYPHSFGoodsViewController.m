//
//  XYPHSFGoodsViewController.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/11.
//

#import <Masonry/Masonry.h>

#import "XYPHSFGoodsViewController.h"

#import "XYPHSearchFilterGroupButtonView.h"

#import "XYPHSearchFilterDismissPanGestureRecognizer.h"

#import "XYPHSFGoodsViewModel.h"

@interface XYPHSFGoodsViewController ()
<
XYPHSFNotesFilterCellDelegate,
XYPHSFPriceFieldCellDelegate,
XYPHSearchFilterGroupButtonViewDelegate
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) XYPHSearchFilterGroupButtonView *groupButtonView;

@property (nonatomic, strong) XYPHSearchFilterDismissPanGestureRecognizer *pan;

@property (nonatomic, strong) XYPHSFGoodsViewModel *viewModel;

@property (nonatomic, strong) XYPHSFGoodsDataSource *dataSource;

@property (nonatomic, strong) XYPHSearchGoodsFilter *filter;

@property (nonatomic, strong) XYSFSelectedFilters *selectedFilters;

@end

@implementation XYPHSFGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.groupButtonView attachInView:self.view];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addGestureRecognizer:self.pan];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.top.mas_equalTo(40);
        make.bottom.mas_equalTo(self.groupButtonView.mas_top);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel updateRowsWithModel:self.filter selectedFilters:self.selectedFilters];
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHidden) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (BOOL)needShow {
    return _filter != nil;
}

- (void)keyBoardDidHidden {
    // case 1 点击完成收起键盘
    // case 2 tap收起键盘
    // case 3 滑动collectionView收起键盘
    XYPHSFPriceFieldCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if ([cell isKindOfClass:[XYPHSFPriceFieldCell class]]) {
        [(XYPHSFPriceFieldCell *)cell completeInput];
    }
}

- (void)requsetFilters:(SFGoodsFilterRequestCompletion)completion {
    __weak typeof(self) weakself = self;
    [self.dataSource requsetFilters:^(XYPHSearchGoodsFilter * _Nonnull model) {
        if (completion) { completion(model); }
        weakself.filter = model;
    }];
}

#pragma mark - <XYPHSFNotesFilterCellDelegate>

- (void)searchFilterNotesCellMoreButtonClicked:(XYPHSearchFilterNotesCell *)cell {
    [UIView performWithoutAnimation:^{
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }];
}

- (void)searchFilterNotesCellDidSelectItem:(XYPHSearchFilterNotesCell *)cell {
    [self didChangedSelectedTags];
}

#pragma mark <XYPHSFPriceFieldCellDelegate>
- (void)searchFilterPriceFieldCellCompleteInput:(XYPHSFPriceFieldCell *)cell {
    [self didChangedSelectedTags];
}


#pragma mark <XYPHSearchFilterGroupButtonViewDelegate>

- (void)searchFilterGroupButtonViewClearButtonClicked:(XYPHSearchFilterGroupButtonView *)groupButtonView {
    [self.selectedFilters removeAllFilters];
    [self.viewModel removeAllSelected];
    
    [self.tableView reloadData];

    [self didChangedSelectedTags];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    if ([self.delegate respondsToSelector:@selector(searchFilterViewControllerDoneButtonClicked:)]) {
        [self.delegate searchFilterViewControllerDoneButtonClicked:self];
    }
    [super dismissViewControllerAnimated:flag completion:completion];
}

- (void)searchFilterGroupButtonViewDoneButtonClicked:(XYPHSearchFilterGroupButtonView *)groupButtonView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setTotalCount:(NSInteger)totalCount {
    self.groupButtonView.totalCount = totalCount;
}

- (void)didChangedSelectedTags {
    if ([self.delegate respondsToSelector:@selector(searchFilterViewControllerDidChangedSelectedTag:)]) {
        [self.delegate searchFilterViewControllerDidChangedSelectedTag:self];
    }
}

- (void)referenceSelectedFilters:(XYSFSelectedFilters *)selectedFilters {
    _selectedFilters = selectedFilters;
}

#pragma mark - Accessors

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.dataSource = self.viewModel;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 120;
        [self.viewModel registerClassInTableView:_tableView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return _tableView;
    }
    return _tableView;
}


- (XYPHSearchFilterGroupButtonView *)groupButtonView {
    if (!_groupButtonView) {
        _groupButtonView = [XYPHSearchFilterGroupButtonView new];
        _groupButtonView.suffix = @"件商品";
    }
    return _groupButtonView;
}

- (XYPHSearchFilterDismissPanGestureRecognizer *)pan {
    if (!_pan) {
        __weak typeof(self) weakself = self;
        _pan = [XYPHSearchFilterDismissPanGestureRecognizer gestureBeginHandleBlock:^(XYPHSearchFilterDismissAnimator *animator) {
            weakself.transitioningDelegate = animator;
            [weakself dismissViewControllerAnimated:YES completion:nil];
        }];
        _pan.finishHandleBlock = ^{
            
        };
    }
    return _pan;
}

- (XYPHSFGoodsDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [XYPHSFGoodsDataSource new];
        _dataSource.keyword = self.keyword;
    }
    return _dataSource;
}

- (XYPHSFGoodsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = XYPHSFGoodsViewModel.new;
    }
    return _viewModel;
}

@end
