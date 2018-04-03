//
//  AccountTitleCell.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "AccountTitleCell.h"

@implementation AccountXYPHBindAccountTitleCellItem

@end


@implementation AccountTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.font = [UIFont boldSystemFontOfSize:30];
    }
    return self;
}

- (void)updateViewData:(AccountXYPHBindAccountTitleCellItem *)viewData {
    self.textLabel.text = viewData.text;
}

@end
