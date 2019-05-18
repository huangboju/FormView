//
//  XYPHSearchFilterTagViewModel.h
//  Halo
//
//  Created by TomatoPeter on 2017/10/25.
//  Copyright © 2017年 XingIn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XYPHSearchFilterPresenter.h"

@class XYPHSearchNotesFilterGroup;

@interface XYPHSearchFilterTagCellModel : NSObject

@property (nonatomic, copy, readonly) NSString *tagId;

@property (nonatomic, copy, readonly) NSString *title;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign, readonly) NSInteger index;

@property (class, nonatomic, strong, readonly) XYPHSearchFilterTagCellModel *defaultAll;

// 笔记外露筛选使用
@property (nonatomic, assign, readonly) CGSize cellSize;

- (instancetype)initWithModel:(id <XYPHSearchFilterPresenter>)model;


+ (instancetype)modelWithModel:(id <XYPHSearchFilterPresenter> )model
                         index:(NSInteger)index;

@end
