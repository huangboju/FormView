//
//  MTExpListVC.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/3/5.
//

#import "MTExpListVC.h"
#import "MTExpDetailVC.h"

#import "MTDevSection.h"
#import "MTExpListCell.h"

#import "MTExpListDataSource.h"
#import "MTExpListViewModel.h"

#import "MTAddExpVC.h"
#import "MTExpStorage.h"
#import "MTExpFileMonitor.h"
#import "MTExpListSearchResultVC.h"

@interface MTExpListVC ()
<
UITableViewDelegate,
MTAddExpVCDelegate,
MTExpFileMonitorDelegate,
UISearchResultsUpdating,
MTExpVCPresenter,
UISearchControllerDelegate
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MTExpListDataSource *dataSource;

@property (nonatomic, strong) MTExpListViewModel *viewModel;

@property (nonatomic, strong) UIButton *addExpButton;

@property (nonatomic, strong) MTExpFileMonitor *monitor;

@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation MTExpListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.title = @"无极实验";

    [self prepareRows];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Raw"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(rawButtonClicked)];
    
    [self initSubviews];
    
    [self initMonitor];
}

- (void)initMonitor {
    NSString *cachePath = MTExpStorage.sharedInstance.configCachePath;
    if (!cachePath) {
        return ;
    }
    _monitor = [[MTExpFileMonitor alloc] initWithURL:[NSURL fileURLWithPath:cachePath]];
    _monitor.delegate = self;
}

- (void)prepareRows {
    __weak typeof (self) weakSelf = self;
    [self.viewModel prepareRowsWithCompletion:^(NSArray<MTDevSection *> * _Nonnull sections) {
        [weakSelf.dataSource.form removeAllObjects];
        [weakSelf.dataSource.form addObjectsFromArray:sections];
        [weakSelf.tableView reloadData];
    }];
}

- (void)initSubviews {

    self.definesPresentationContext = YES;

    // https://useyourloaf.com/blog/supporting-iphone-x/
    if (@available(iOS 11, *)) {
        self.navigationItem.searchController = self.searchController;
        self.navigationItem.hidesSearchBarWhenScrolling = false;
    } else {
        
        self.tableView.tableHeaderView = self.searchController.searchBar;
    }
    
    [self.view addSubview:self.tableView];

    [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;


    UIView *spacingView = UIView.new;
    spacingView.backgroundColor = self.addExpButton.backgroundColor;

    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[
        self.addExpButton,
        spacingView
    ]];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.axis = UILayoutConstraintAxisVertical;
    [self.view addSubview:stackView];
    
    
    CGFloat height = 0;
    if (@available(iOS 11, *)) {
        height = UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom;
    }
    [NSLayoutConstraint activateConstraints:@[
        [spacingView.heightAnchor constraintEqualToConstant:height],
        [self.addExpButton.heightAnchor constraintEqualToConstant:44],
        [stackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [stackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [stackView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ]];
    
}

- (void)rawButtonClicked {
    MTExpDetailVC *detailVC = MTExpDetailVC.new;
    detailVC.text = self.viewModel.dict.description;
    [self showViewController:detailVC sender:nil];
}

#pragma mark <UISearchResultsUpdating>
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    NSMutableArray *searchResult = NSMutableArray.array;
    
    for (MTDevSection *section in self.dataSource.form) {
        for (MTDevRow *row in section.rows) {
            MTExpListCellItem *item = row.model;
            if ([item.title.lowercaseString containsString:searchText.lowercaseString]) {
                [searchResult addObject:row];
            }
        }
    }

    MTExpListSearchResultVC *resultVC = (MTExpListSearchResultVC *)searchController.searchResultsController;
    resultVC.searchResult = searchResult.copy;
}

#pragma mark <MTExpFileMonitorDelegate>
- (void)fileMonitor:(MTExpFileMonitor *)fileMonitor
       didSeeChange:(MTExpFileMonitorChangeType)changeType {
    [self prepareRows];
}

#pragma mark <UISearchControllerDelegate>
- (void)willDismissSearchController:(UISearchController *)searchController {
    [self.tableView reloadData];
}

#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [MTExpStorage modifyExpValueAtIndexPath:indexPath WithVC:self];
}

- (nullable UIContextMenuConfiguration *)tableView:(UITableView *)tableView
         contextMenuConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath
                                             point:(CGPoint)point  API_AVAILABLE(ios(13.0)) {
    MTExpListCellItem *item = [self.dataSource modelAtIndexPath:indexPath];
    UIAction *copy = [UIAction actionWithTitle:@"copy"
                                         image:nil
                                    identifier:nil
                                       handler:^(UIAction *action) {
        [UIPasteboard generalPasteboard].string = item.subTitle;
    }];

    UIContextMenuConfiguration *config = [UIContextMenuConfiguration configurationWithIdentifier:nil
                                                                                 previewProvider:nil
                                                                                  actionProvider:^UIMenu * _Nullable(NSArray<UIMenuElement *> * _Nonnull suggestedActions) {
        return [UIMenu menuWithTitle:@"Options" children:@[copy]];
    }];

    return config;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    return action == @selector(copy:);
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    MTExpListCellItem *item = [self.dataSource modelAtIndexPath:indexPath];
    if (action == @selector(copy:)) {
        [UIPasteboard generalPasteboard].string = item.subTitle;
    }
}

- (void)addExpButtonClicked:(UIButton *)sender {
    MTAddExpVC *addExpVC = MTAddExpVC.new;
    addExpVC.sections = self.dataSource.form;
    addExpVC.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:addExpVC];
    [self showDetailViewController:nav sender:nil];
}

#pragma mark <MTAddExpVCDelegate>
- (void)addExpVCDidAddNewExp:(MTAddExpVC *)addExpVC
                 atIndexPath:(NSIndexPath *)indexPath {
    [self.tableView reloadData];
}

- (MTExpListDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = MTExpListDataSource.new;
    }
    return _dataSource;
}

- (MTExpListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = MTExpListViewModel.new;
    }
    return _viewModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        Class cellClass = MTExpListCell.class;
        [_tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
        _tableView.dataSource = self.dataSource;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tableView;
}

- (UIButton *)addExpButton {
    if (!_addExpButton) {
        _addExpButton = [UIButton new];
        [_addExpButton setTitle:@"添加实验" forState:UIControlStateNormal];
        [_addExpButton addTarget:self action:@selector(addExpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _addExpButton.translatesAutoresizingMaskIntoConstraints = NO;
        _addExpButton.backgroundColor = [UIColor colorWithRed:0 green:122.f/255.f blue:1 alpha:1];
    }
    return _addExpButton;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:MTExpListSearchResultVC.new];
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.searchBar.placeholder = @"请输入实验名称";
        _searchController.searchBar.barTintColor = [UIColor groupTableViewBackgroundColor];
        _searchController.searchResultsUpdater = self;
        _searchController.delegate = self;

        /// 去除 searchBar 上下两条黑线
        UIImageView *barImageView = [[[_searchController.searchBar.subviews firstObject] subviews] firstObject];
        barImageView.layer.borderColor =  [UIColor groupTableViewBackgroundColor].CGColor;
        barImageView.layer.borderWidth = 1;
    }
    return _searchController;
}

@end
