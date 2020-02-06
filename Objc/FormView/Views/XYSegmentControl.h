//
//  SegmentBar.h
//  FormView
//
//  Created by 黄伯驹 on 04/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYSegmentControl;

@protocol XYSegmentBarDelegate <NSObject>

- (void)segmentBar:(XYSegmentControl *)segmentBar didSelectItemAtIndex:(NSInteger )index;

@end


#pragma mark - XYSegmentBar
@interface XYSegmentControl : UIView


@property (nonatomic, weak) id <XYSegmentBarDelegate> delegate;


@property (nonatomic, strong) NSArray <NSString *> *sectionTitles;

@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *titleImageLinks;

@property (nonatomic, strong) NSDictionary<NSString *, UIImage *> *titleImages;

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
@property (nonatomic, assign) NSInteger selectedSegmentIndex;

/// Default 2
@property (nonatomic, assign) CGFloat selectionIndicatorHeight;

/// 指示线与文字的间距
/// Default 10
@property (nonatomic, assign) CGFloat indicatorInterval;

- (id)initWithSectionTitles:(NSArray<NSString *> *)sectiontitles;

/// 设置默认位置
- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated;

/// 给外部做联动用
- (void)updateBottomIndicatorWithScrollView:(UIScrollView *)scrollView isLeft:(BOOL)isLeft;

@end
