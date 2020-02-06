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

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSString *imageLink;

@property (nonatomic, strong, readonly) UIColor *textColor;

@property (nonatomic, strong, readonly) UIFont *textFont;

@property (nonatomic, strong, readonly) UIFont *selectedTitleFont;

@property (nonatomic, strong, readonly) UIColor *selectedTitleColor;

@end

#pragma mark - SegmentBarCellUpdatable
@class XYSegmentControl;

@protocol XYSegmentBarCellUpdatable <NSObject>

- (void)updateViewData:(XYSegmentControlCellItem *)viewData;

@end


@protocol XYSegmentBarDelegate <NSObject>

- (void)segmentBar:(XYSegmentControl *)segmentBar didSelectItemAtIndex:(NSInteger )index;

@end


#pragma mark - XYSegmentBar
@interface XYSegmentControl<__covariant ItemClass : Class > : UIView


@property (nonatomic, weak) id <XYSegmentBarDelegate> delegate;

@property (nonatomic) ItemClass itemClass;


@property (nonatomic, strong) NSArray <NSString *> *titles;

/**
 Text attributes to apply to item title text.
 */
@property (nonatomic, strong) NSDictionary *titleTextAttributes UI_APPEARANCE_SELECTOR;

/*
 Text attributes to apply to selected item title text.
 
 Attributes not set in this dictionary are inherited from `titleTextAttributes`.
 */
@property (nonatomic, strong) NSDictionary *selectedTitleTextAttributes UI_APPEARANCE_SELECTOR;


@property (nonatomic, strong) UIColor *selectionIndicatorColor;

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

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray <XYSegmentControlCellItem *>*)items;

/// 设置默认位置
- (void)setCurrentTabIndex:(NSUInteger)currentTabIndex animated:(BOOL)animated;

/// 给外部做联动用
- (void)updateBottomIndicatorWithScrollView:(UIScrollView *)scrollView isLeft:(BOOL)isLeft;

@end
