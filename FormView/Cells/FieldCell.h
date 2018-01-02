//
//  FieldCell.h
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FieldCell : UITableViewCell

@property(nonatomic, strong, readonly) UITextField *textField;

@property(nonatomic, strong) NSString *inputText;

@end
