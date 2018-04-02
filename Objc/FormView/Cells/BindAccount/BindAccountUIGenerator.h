//
//  BindAccountUIGenerator.h
//  FormView
//
//  Created by 黄伯驹 on 28/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserCardView.h"

#import "BindStatusView.h"

@class UserCardCellItem;

@interface BindAccountUIGenerator : NSObject

+ (UIButton *)darkButtonWithTitle:(NSString *)title;

+ (UserCardView *)userCardViewWithItem:(UserCardCellItem *)item;


@end
