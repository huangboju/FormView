//
//  FilterRefactorDataSource.m
//  FormView
//
//  Created by 黄伯驹 on 2019/5/2.
//  Copyright © 2019 黄伯驹. All rights reserved.
//

#import "FilterRefactorDataSource.h"


@interface FilterRefactorDataSource()

@property (nonatomic, strong) XYSFSelectedFilters *selectedFilters;

@property (nonatomic, copy) NSString *selectedFilterStr;

@end


@implementation FilterRefactorDataSource

- (XYSFSelectedFilters *)selectedFilters {
    if (!_selectedFilters) {
        _selectedFilters = XYSFSelectedFilters.new;
    }
    return _selectedFilters;
}

- (BOOL)filtersChanged {
    NSString *result = self.selectedFilters.filterStr;
    if (_selectedFilterStr.length < 1 && result.length < 1) { return NO; }
    if ([_selectedFilterStr isEqualToString:result]) {
        return NO;
    }
    _selectedFilterStr = result;
    return YES;
}

@end
