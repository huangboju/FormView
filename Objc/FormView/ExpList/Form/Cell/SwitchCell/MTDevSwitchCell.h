//
//  MTDevSwitchCell.h
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/2/20.
//

#import <UIKit/UIKit.h>
#import "MTDevRow.h"

@class MTDevSwitchCell;

NS_ASSUME_NONNULL_BEGIN

@interface MTDevSwitchCellItem : NSObject

@property (nonatomic, copy, readonly)  NSString *title;

- (void)addTitle:(NSString *)title;

- (void)addIsOn:(BOOL)isOn;

@end


@protocol MTDevSwitchCellDelegate <NSObject>

- (void)switchCellSwitchViewValueChanged:(MTDevSwitchCell *)cell;

@end


@interface MTDevSwitchCell : UITableViewCell <MTDevUpdatable>

@property (nonatomic, strong, readonly) UISwitch *switchView;

@property (nonatomic, strong, readonly) MTDevSwitchCellItem *viewData;

@end

NS_ASSUME_NONNULL_END
