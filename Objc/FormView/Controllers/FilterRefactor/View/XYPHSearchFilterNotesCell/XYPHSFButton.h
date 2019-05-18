//
//  XYPHSFButton.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/3/7.
//

#import <UIKit/UIKit.h>

@class XYPHSearchFilterTagCellModel;

NS_ASSUME_NONNULL_BEGIN

@interface XYPHSFButton : UIButton

+ (instancetype)buttonWithItem:(XYPHSearchFilterTagCellModel *)item;

@property (nonatomic, strong, readonly) XYPHSearchFilterTagCellModel *item;

@end

NS_ASSUME_NONNULL_END
