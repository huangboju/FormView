//
//  XYPHRow.h
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTDevUpdatable.h"

NS_ASSUME_NONNULL_BEGIN


@interface MTDevRow : NSObject

@property (nonatomic, copy, readonly) NSString *reuseIdentifier;

@property (nonatomic, strong, readonly) Class cellClass;

@property (nonatomic, strong, readonly) id model;

+ (instancetype)rowWithClass:(Class)cls;

+ (instancetype)rowWithClass:(Class)cls model:(id)model;

// 用UIView主要兼容UITableViewCell和UICollectionViewCell
- (void)updateCell:(UIView *)cell;

@end

NS_ASSUME_NONNULL_END


