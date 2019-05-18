//
//  FilterRefactorDataSource.h
//  FormView
//
//  Created by 黄伯驹 on 2019/5/2.
//  Copyright © 2019 黄伯驹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYSFSelectedFilters.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilterRefactorDataSource : NSObject

@property (nonatomic, strong, readonly) XYSFSelectedFilters *selectedFilters;

@property (nonatomic, assign, readonly) BOOL filtersChanged;


@end

NS_ASSUME_NONNULL_END
