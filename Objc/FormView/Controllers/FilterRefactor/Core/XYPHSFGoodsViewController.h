//
//  XYPHSFGoodsViewController.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/11.
//

#import <UIKit/UIKit.h>

#import "XYPHSFViewControllerDelegate.h"

#import "XYPHSFGoodsDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYPHSFGoodsViewController : UIViewController <XYPHSFViewControllerPresenter>


@property (nonatomic, copy) NSString *keyword;

// 商品数
@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, assign, readonly) BOOL needShow;

@property (nonatomic, weak) UIViewController <XYPHSFViewControllerDelegate> *delegate;

// XYPHSFViewControllerPresenter
@property (nonatomic, strong, readonly) XYSFSelectedFilters *selectedFilters;

- (void)referenceSelectedFilters:(XYSFSelectedFilters *)selectedFilters;

- (void)requsetFilters:(SFGoodsFilterRequestCompletion)completion;

@end

NS_ASSUME_NONNULL_END
