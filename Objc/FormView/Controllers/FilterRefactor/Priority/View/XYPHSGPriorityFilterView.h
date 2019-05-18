//
//  XYPHSGPriorityFilterView.h
//  AFNetworking
//
//  Created by 黄伯驹 on 2019/4/13.
//

#import <UIKit/UIKit.h>
#import "XYUpdatable.h"

@class XYSFSelectedFilters, XYPHSGPriorityFilterView;

NS_ASSUME_NONNULL_BEGIN

@protocol XYPHSGPriorityFilterViewDelegate <NSObject>

- (void)friorityFilterViewDidSelectItem:(XYPHSGPriorityFilterView *)friorityFilterView;

@end

@interface XYPHSGPriorityFilterView : UIScrollView <XYUpdatable>

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
