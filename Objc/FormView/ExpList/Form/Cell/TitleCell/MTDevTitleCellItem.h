//
//  MTDevTitleCellItem.h
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/2/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTDevTitleCellItem : NSObject

@property (nonatomic, copy, readonly)  NSString *title;

@property (nonatomic, copy, readonly)  NSString *subTitle;

@property (nonatomic, readonly) SEL selector;

@property (nonatomic, strong, readonly)  UIColor *titleColor;

@property (nonatomic, strong, readonly)  UIColor *subTitleColor;

@property (nonatomic, strong, readonly)  UIFont *titleFont;

@property (nonatomic, assign, readonly)  UITableViewCellStyle cellStyle;

- (void)addTitle:(NSString *)title;

- (void)addSubTitle:(NSString *)detailText;

- (void)addTitleColor:(UIColor *)titleColor;

- (void)addsubTitleColor:(UIColor *)subTitleColor;

- (void)addTitleFont:(UIFont *)titleFont;

- (void)addCellStyle:(UITableViewCellStyle)cellStyle;

- (void)addSelector:(SEL)selector;


@end

NS_ASSUME_NONNULL_END
