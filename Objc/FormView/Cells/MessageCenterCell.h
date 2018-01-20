//
//  MessageCenterCell.h
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Row.h"

@interface MessageCenterCellItem : NSObject

@property(nonatomic, copy)  NSString *imageName;

@property(nonatomic, copy) NSString *desc;

@property(nonatomic, strong)  Class controllerClass;

@end

@interface MessageCenterCell : UITableViewCell

@end
