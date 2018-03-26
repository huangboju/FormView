//
//  UserCardCell.h
//  FormView
//
//  Created by xiAo_Ju on 23/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Row.h"

@interface UserCardCellItem : NSObject

@property(nonatomic, copy)  NSString *nickName;

@property (nonatomic, assign) BOOL isBinding;

@end

@interface UserCardCell : UITableViewCell<Updatable>

@end
