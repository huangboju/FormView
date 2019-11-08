//
//  SegmentBar.h
//  FormView
//
//  Created by 黄伯驹 on 04/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - SegmentBarCellItem
@interface XYSegmentControlCellItem : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIFont *textFont;

@end

#pragma mark - SegmentBarCellUpdatable
@class XYSegmentControl;

@protocol XYSegmentBarCellUpdatable <NSObject>

- (void)updateViewData:(XYSegmentControlCellItem *)viewData;

@end


@protocol XYSegmentBarDelegate <NSObject>

- (void)segmentBar:(XYSegmentControl *)segmentBar didSelectItemAtIndex:(NSInteger )index;

@end

typedef NS_ENUM(NSUInteger, XYSegmentBarScrollDirection) {
    XYSegmentBarScrollDirectionLeft,
    XYSegmentBarScrollDirectionRight,
};


#pragma mark - XYSegmentBar
@interface XYSegmentControl : UIView

/**
 自定义segmentItem

 @param cellClass 必须为collecitonview Cell
 @param handle 会返回SegmentBarCellItem，可以构造自定义model
 */
- (void)customCellWithCellClass:(Class)cellClass configHandle:(id (^)(XYSegmentControlCellItem *item))handle;


@property (nonatomic, weak) id <XYSegmentBarDelegate> delegate;


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
- (void)setCurrentTabIndex:(NSUInteger)currentTabIndex animated:(BOOL)animated;

/// 给外部做联动用
- (void)updateBottomIndicatorWithScrollView:(UIScrollView *)scrollView isLeft:(BOOL)isLeft;

@end
