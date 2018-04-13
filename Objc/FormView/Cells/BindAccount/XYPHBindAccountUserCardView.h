//
//  XYPHBindAccountUserCardView.h
//  FormView
//
//  Created by xiAo_Ju on 27/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYPHBindAccountUserCardView;

@protocol XYPHBindAccountUserCardViewActionable <NSObject>

@optional

- (void)userCardView:(XYPHBindAccountUserCardView *)userCardView willTransform:(BOOL)isExpanding;

- (void)userCardView:(XYPHBindAccountUserCardView *)userCardView didTransform:(BOOL)isExpanding;

@end

@class XYPHBindAccountUserCardCellItem;

@class XYPHBindAccountBindStatusView;

@interface XYPHBindAccountUserCardView : UIView

@property (nonatomic, strong, readonly) UIView *wrapperView;

@property (nonatomic, weak) id <XYPHBindAccountUserCardViewActionable> delegate;

@property (nonatomic, assign, readonly) BOOL isExpanding;

- (void)updateViewData:(XYPHBindAccountUserCardCellItem *)viewData;

- (void)setIsExpanding:(BOOL)isExpanding animated:(BOOL)animated;

@end
