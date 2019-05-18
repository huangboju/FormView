//
//  XYPHSGPriorityFilterViewController.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/11.
//

#import <UIKit/UIKit.h>

#import "XYPHSFViewControllerDelegate.h"

@class XYPHSearchGoodsFilterGroup;

NS_ASSUME_NONNULL_BEGIN

@interface XYPHSGPriorityFilterViewController : UIViewController <XYPHSFViewControllerPresenter>

@property (nonatomic, strong) XYPHSearchGoodsFilterGroup *viewData;

@property (nonatomic, weak) UIViewController <XYPHSFViewControllerDelegate> *delegate;

@property (nonatomic, strong, readonly) XYSFSelectedFilters *selectedFilters;

- (void)referenceSelectedFilters:(XYSFSelectedFilters *)selectedFilters;

- (void)showInViewController:(UIViewController *)vc;

- (void)dismissIfNeeded;

// 商品数
@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, copy) NSString *keyword;

@end

NS_ASSUME_NONNULL_END
