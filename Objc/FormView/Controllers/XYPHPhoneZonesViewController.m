//
//  XYPHPhoneZonesViewController.m
//  FormView
//
//  Created by 黄伯驹 on 23/02/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYPHPhoneZonesViewController.h"

@interface XYPHPhoneZonesItems : NSObject

@property (nonatomic, strong) NSString *groupKey;

@property (nonatomic, strong) NSArray *zones;

@end

@interface XYPHPhoneZonesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation XYPHPhoneZonesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    return cell;
}

@end
