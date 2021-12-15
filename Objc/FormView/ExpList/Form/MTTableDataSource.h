//
//  MTTableDataSource.h
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/3/17.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MTDevSection.h"

NS_ASSUME_NONNULL_BEGIN

// MTTableDataSource
@interface MTTableDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong, readonly) NSMutableArray <MTDevSection *>*form;

- (MTDevRow *)rowAtIndexPath:(NSIndexPath *)indexPath;

- (id)modelAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
