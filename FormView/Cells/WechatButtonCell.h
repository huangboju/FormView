//
//  WechatButtonCell.h
//  FormView
//
//  Created by 黄伯驹 on 16/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WechatButtonCellActionable <NSObject>

- (void)wechatButtonAction:(UIButton *)sender;

@end

@interface WechatButtonCell : UITableViewCell

@end
