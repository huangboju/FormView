//
//  MTDevTitleCellItem.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/2/24.
//

#import "MTDevTitleCellItem.h"

@interface MTDevTitleCellItem()

@property (nonatomic, copy)  NSString *title;

@property (nonatomic, copy)  NSString *subTitle;

@property (nonatomic) SEL selector;

@property (nonatomic, strong)  UIColor *titleColor;

@property (nonatomic, strong)  UIColor *subTitleColor;

@property (nonatomic, strong)  UIFont *titleFont;

@property (nonatomic, assign)  UITableViewCellStyle cellStyle;

@end

@implementation MTDevTitleCellItem

- (instancetype)init {
    if (self = [super init]) {
        [self addTitleFont:[UIFont boldSystemFontOfSize:18]];
    }
    return self;
}

- (void)addTitle:(NSString *)title {
    self.title = title;
}

- (void)addSubTitle:(NSString *)detailText {
    self.subTitle = detailText;
}

- (void)addSelector:(SEL)selector {
    self.selector = selector;
}

- (void)addTitleColor:(UIColor *)titleColor {
    self.titleColor = titleColor;
}

- (void)addsubTitleColor:(UIColor *)subTitleColor {
    self.subTitleColor = subTitleColor;
}

- (void)addTitleFont:(UIFont *)titleFont {
    self.titleFont = titleFont;
}

- (void)addCellStyle:(UITableViewCellStyle)cellStyle {
    self.cellStyle = cellStyle;
}

@end
