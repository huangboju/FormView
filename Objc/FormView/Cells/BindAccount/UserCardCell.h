//
//  UserCardCell.h
//  FormView
//
//  Created by xiAo_Ju on 23/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Row.h"

@class UserCardCell;

@protocol UserCardCellActionable

- (void)userCardCell:(UserCardCell *)userCardCell didShowBindStatusView:(UIView *)bindStatusView;

@end

@interface UserCardCell : UITableViewCell<Updatable>

@end
