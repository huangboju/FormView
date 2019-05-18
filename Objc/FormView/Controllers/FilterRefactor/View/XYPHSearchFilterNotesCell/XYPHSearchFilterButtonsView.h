//
//  XYPHSearchFilterButtonsView.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/11.
//

#import <UIKit/UIKit.h>

#import "XYUpdatable.h"
#import "XYPHSFButton.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XYPHSearchFilterButtonsViewDelegate <NSObject>

- (void)searchFilterButtonsViewItemClickedWithSender:(XYPHSFButton *)sender;

@end

@interface XYPHSearchFilterButtonsView : UIView <XYUpdatable>

@property (nonatomic, weak) id <XYPHSearchFilterButtonsViewDelegate> delegate;

- (void)deselectedAll;

@end

NS_ASSUME_NONNULL_END
