//
//  BindAccountUIGenerator.h
//  FormView
//
//  Created by 黄伯驹 on 28/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYPHBindAccountUserCardView.h"

#import "XYPHBindAccountBindStatusView.h"

@class XYPHBindAccountUserCardCellItem;

@interface XYPHBindAccountUIGenerator : NSObject

+ (UIButton *)darkButtonWithTitle:(NSString *)title;

+ (XYPHBindAccountUserCardView *)userCardViewWithItem:(XYPHBindAccountUserCardCellItem *)item;


@end
