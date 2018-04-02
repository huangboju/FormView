//
//  GroupButtonView.h
//  FormView
//
//  Created by 黄伯驹 on 30/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroupButtonView;

@protocol GroupButtonViewDelegate <NSObject>

- (void)groupButtonViewChangeBindingButtonClicked:(GroupButtonView *)searchBar;

- (void)groupButtonViewUnchangeBindingBtnButtonClicked:(GroupButtonView *)searchBar;

@end

@interface GroupButtonView : UIView

@property (nonatomic, strong) id <GroupButtonViewDelegate> delegate;

@end
