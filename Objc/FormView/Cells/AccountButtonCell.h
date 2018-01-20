//
//  AccountButtonCell.h
//  FormView
//
//  Created by 黄伯驹 on 16/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AccountButtonCellActionable <NSObject>

- (void)signInButtonAction:(UIButton *)sender;

- (void)signUpButtonAction:(UIButton *)sender;

@end

@interface AccountButtonCell : UITableViewCell

@end
