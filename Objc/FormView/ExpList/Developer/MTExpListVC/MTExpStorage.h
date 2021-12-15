//
//  MTExpStorage.h
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/3/19.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTExpListCellItem, MTTableDataSource;

NS_ASSUME_NONNULL_BEGIN

@protocol MTExpVCPresenter <NSObject>

@property (nonatomic, strong, readonly) MTTableDataSource *dataSource;

@property (nonatomic, strong, readonly) UITableView *tableView;

@end

// MTExpStorage
@interface MTExpStorage : NSObject

+ (instancetype)sharedInstance;

/// 本地存储的实验配置（添加或者修改的）
@property (nonatomic, strong, readonly) NSDictionary *wujiCache;

/// 缓存在本地的wuji配置，MTAdConfigModel中拉到的
@property (nonatomic, strong, readonly) NSDictionary *configCache;

/// 真正的wuji配置和本地添加、修改的，
/// 注意：相同的配置会保留本地修改过的
@property (nonatomic, strong, readonly) NSDictionary *disguisedCache;

/// wuji配置的缓存路径
@property (nonatomic, copy, readonly) NSString *configCachePath;

- (void)saveExpItem:(MTExpListCellItem *)item;

- (void)removeExpItem:(MTExpListCellItem *)item;

+ (void)modifyExpValueAtIndexPath:(NSIndexPath *)indexPath WithVC:(UIViewController <MTExpVCPresenter> *)vc;

@end

NS_ASSUME_NONNULL_END
