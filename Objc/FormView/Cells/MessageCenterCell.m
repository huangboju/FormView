//
//  MessageCenterCell.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "MessageCenterCell.h"

@implementation MessageCenterCellItem

@end

@interface MessageCenterCell()<Updatable>

@end

@implementation MessageCenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)updateViewData:(MessageCenterCellItem *)viewData {
    self.textLabel.text = viewData.desc;
    self.imageView.image = [UIImage imageNamed:viewData.imageName];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    // http://www.jianshu.com/p/4237bd89f521

    self.separatorInset = inset;
    self.preservesSuperviewLayoutMargins = NO;

    // 使用这个属性用于指定视图和它的子视图之间的边距
    self.layoutMargins = inset;
}

@end
