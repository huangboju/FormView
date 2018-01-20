//
//  Row.h
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Updatable <NSObject>

@optional
- (void)updateViewData:(id)viewData;

@end


@interface Row : NSObject

@property(nonatomic, copy, readonly) NSString *reuseIdentifier;

@property(nonatomic, strong, readonly) Class cellClass;

@property(nonatomic, strong, readonly) id model;

- (instancetype)initWithClass:(Class)cls model:(id)model;

- (instancetype)initWithClass:(Class)cls;

- (void)updateCell:(UITableViewCell *)cell;

@end

NS_ASSUME_NONNULL_END


