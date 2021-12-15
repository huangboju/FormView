//
//  MTAddExpVC.m
//  Alpha
//
//  Created by xiAo-Ju on 2021/3/18.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//


#import "MTAddExpVC.h"
#import "MTTableDataSource.h"
#import "MTExpListViewModel.h"
#import "MTExpListCell.h"
#import "MTExpStorage.h"

@interface MTAddExpVC () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MTTableDataSource *dataSource;

@end

// MTAddExpVC
@implementation MTAddExpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择实验分组";
    
    [self initSubviews];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(closeBarButtonClicked)];
}

- (void)closeBarButtonClicked {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)setSections:(NSArray<MTDevSection *> *)sections {
    _sections = sections;
    MTDevSection *section = [MTDevSection new];
    for (MTDevSection *sc in sections) {
        MTDevTitleCellItem *item = [[MTDevTitleCellItem alloc] init];
        [item addTitle:sc.title];
        MTDevRow *row = [MTDevRow rowWithClass:MTDevTitleCell.class model:item];
        [section addRow:row];
    }
    self.dataSource.form[0] = section;
}

- (void)initSubviews {
    [self.view addSubview:self.tableView];

    [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

#pragma mark <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self addNewExpAdIndexPath:indexPath];
}

- (void)addNewExpAdIndexPath:(NSIndexPath *)indexPath {
    MTExpListCellItem *item = [self.dataSource modelAtIndexPath:indexPath];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:item.title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"实验名称";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"实验值";
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }];
    __weak typeof (self) weakSelf = self;
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *expName = alert.textFields[0].text;
        NSString *expValue = alert.textFields[1].text;
        if (expName.length > 0 && expValue.length > 0) {
            NSDictionary *group = MTExpStorage.sharedInstance.disguisedCache[item.title];
            NSInteger expState = group[expName] ? 2 : 1;
            MTExpListCellItem *newItem = [[MTExpListCellItem alloc] init];
            [newItem addGroupTitle:item.title];
            [newItem addTitle:expName];
            [newItem addSubTitle:expValue];
            [newItem addExpState:expState];
            MTDevRow *row = [MTDevRow rowWithClass:MTExpListCell.class model:newItem];

            MTDevSection *section = weakSelf.sections[indexPath.row];
            [section insertRow:row atIndex:0];
            [weakSelf.delegate addExpVCDidAddNewExp:weakSelf atIndexPath:indexPath];
            [MTExpStorage.sharedInstance saveExpItem:newItem];
        }
        [weakSelf closeBarButtonClicked];
        [weakSelf.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
    [alert addAction:cancel];
    [alert addAction:confirm];
    [self showDetailViewController:alert sender:nil];
}

- (MTTableDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = MTTableDataSource.new;
    }
    return _dataSource;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:MTDevTitleCell.class forCellReuseIdentifier:NSStringFromClass(MTDevTitleCell.class)];
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

@end
