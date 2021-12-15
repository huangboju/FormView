//
//  MainCell.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "MTDevTitleCell.h"

@implementation MTDevTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)updateViewData:(MTDevTitleCellItem *)viewData {
    self.accessoryType = viewData.selector ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    self.textLabel.font = viewData.titleFont;
    self.textLabel.text = viewData.title;
    self.textLabel.textColor = viewData.titleColor;
}

@end
