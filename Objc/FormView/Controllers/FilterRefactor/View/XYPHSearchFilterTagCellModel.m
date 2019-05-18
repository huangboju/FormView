//
//  XYPHSearchFilterTagViewModel.m
//  Halo
//
//  Created by TomatoPeter on 2017/10/25.
//  Copyright © 2017年 XingIn. All rights reserved.
//

#import "XYPHSearchFilterTagCellModel.h"
#import "NSString+LineSpacingFix.h"
#import "Theme.h"

@interface XYPHSearchFilterTagCellModel()

@property (nonatomic, copy) NSString *tagId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) CGSize cellSize;

@end

@implementation XYPHSearchFilterTagCellModel

- (instancetype)initWithModel:(id <XYPHSearchFilterPresenter> )model {
    if (self = [super init]) {
        self.tagId = model.tagId;
        self.title = model.title;
    }
    return self;
}

+ (XYPHSearchFilterTagCellModel *)defaultAll {
    XYPHSearchFilterTagCellModel *viewModel = [XYPHSearchFilterTagCellModel new];
    viewModel.tagId = @"all";
    viewModel.title = @"全部";
    viewModel.index = 0;
    viewModel.selected = YES;
    return viewModel;
}

+ (instancetype)modelWithModel:(id <XYPHSearchFilterPresenter>)model
                         index:(NSInteger)index {
    XYPHSearchFilterTagCellModel *viewModel = [XYPHSearchFilterTagCellModel new];
    viewModel.tagId = model.tagId;
    viewModel.title = model.title;
    viewModel.selected = model.selected;
    viewModel.index = index;
    return viewModel;
}

- (CGSize)cellSize {
    if (CGSizeEqualToSize(_cellSize, CGSizeZero)) {
        _cellSize = [self.title boundingRectWithSize:CGSizeMake(200, 26) font:Theme.fontSmallBold lineSpacing:0];
        _cellSize.height = 26;
        CGFloat width = ceil(_cellSize.width);
        _cellSize.width = width + 30;
    }
    return _cellSize;
}

@end
