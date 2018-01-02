//
//  ButtonCell.h
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Row.h"

@protocol ButtonCellActionable <NSObject>

- (void)buttonAction:(UIButton *)sender;

@end


@interface ButtonCellItem : NSObject

@property(nonatomic, copy)  NSString *title;

@end

@interface ButtonCell : UITableViewCell<Updatable>

@property(nonatomic, strong) void (^buttonAction)(void);

@end
