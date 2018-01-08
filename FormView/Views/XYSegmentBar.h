//
//  SegmentBar.h
//  FormView
//
//  Created by 黄伯驹 on 04/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - SegmentBarCellItem
@interface XYSegmentBarCellItem : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIFont *textFont;

@end

#pragma mark - SegmentBarCellUpdatable
@protocol XYSegmentBarCellUpdatable <NSObject>


- (void)updateViewData:(XYSegmentBarCellItem *)viewData;

@end

@interface XYSegmentBar : UIView

/// handle会返回SegmentBarCellItem
/// 可以拿到text、textColor、textFont
- (void)customCellWithCellClass:(Class)cellClass configHandle:(id (^)(XYSegmentBarCellItem *item))handle;

@property (nonatomic, strong) NSArray *titles;

/// Default [UIFont systemFontOfSize:17]
@property (nonatomic, strong) UIFont *titleFont;

/// Default 0x333333
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *indicatorBackgrounColor;

/// 字体间的间距
/// Default 8
@property (nonatomic, assign) CGFloat titleInterval;

/// Default 0
@property (nonatomic, assign, readonly) NSInteger currentIndex;

/// Default 2
@property (nonatomic, assign) CGFloat indicatorHeight;

/// 指示线与文字的间距
/// Default 10
@property (nonatomic, assign) CGFloat indicatorInterval;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles;

/// 设置默认位置
- (void)setCurrentTabIndex:(NSUInteger)currentTabIndex withAnimation:(BOOL)animate;

/// 给外部做联动用
- (void)updateBottomIndicatorWithScrollView:(UIScrollView *)scrollView isLeft:(BOOL)isLeft;

@end
