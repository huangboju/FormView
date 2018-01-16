//
//  ThirdPartButtonCell.h
//  FormView
//
//  Created by 黄伯驹 on 16/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ThirdPartButtonCellActionable <NSObject>

- (void)weiboButtonAction:(UIButton *)sender;

- (void)qqButtonAction:(UIButton *)sender;

- (void)facebookButtonAction:(UIButton *)sender;

@end

@interface ThirdPartButtonCell : UITableViewCell

@end
