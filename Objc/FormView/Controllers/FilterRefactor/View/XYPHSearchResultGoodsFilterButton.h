//
//  XYPHSearchResultGoodsFilterButton.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/10.
//

#import <UIKit/UIKit.h>

#import "XYUpdatable.h"

@class XYPHSearchGoodsFilterGroup;

NS_ASSUME_NONNULL_BEGIN

@interface XYPHSearchResultGoodsFilterButton : UIButton <XYUpdatable>

@property (nonatomic, assign, getter=canExtensible) BOOL extensible;

@property (nonatomic, assign, getter=isExpanding) BOOL expanding;

@property (nonatomic, assign, getter=isImageOnly) BOOL imageOnly;

@property (nonatomic, strong) NSString *selectedColor;

@property (nonatomic, strong, readonly) XYPHSearchGoodsFilterGroup *viewData;

@end

NS_ASSUME_NONNULL_END
