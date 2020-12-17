//
//  MainCell.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "MainCell.h"

@interface MainCellItem()

@property (nonatomic, copy)  NSString *title;

@property (nonatomic) SEL selector;

@end

@implementation MainCellItem

+ (instancetype)itemWithTitle:(NSString *)title selector:(SEL)selector {
    MainCellItem *item = MainCellItem.new;
    item.title = title;
    item.selector = selector;
    return item;
}

@end

@implementation MainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return self;
}

- (void)updateViewData:(MainCellItem *)viewData {
    self.textLabel.text = viewData.title;
}

@end
