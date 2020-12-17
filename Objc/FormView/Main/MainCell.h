//
//  MainCell.h
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYRow.h"

@interface MainCellItem : NSObject

@property (nonatomic, copy, readonly)  NSString *title;

@property (nonatomic, readonly) SEL selector;

+ (instancetype)itemWithTitle:(NSString *)title selector:(SEL)selector;

@end

@interface MainCell : UITableViewCell <XYUpdatable>

@end
