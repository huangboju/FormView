//
//  UserCardView.h
//  FormView
//
//  Created by xiAo_Ju on 27/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserCardView;

@protocol UserCardViewActionable <NSObject>

- (void)userCardView:(UserCardView *)userCardView didSelect:(BOOL)isSelect;

@end

@class UserCardCellItem;

@interface UserCardView : UIView

@property (nonatomic, weak) id <UserCardViewActionable> delegate;

@property (nonatomic, assign, readonly) BOOL isExpanding;

- (void)updateViewData:(UserCardCellItem *)viewData;


@end
