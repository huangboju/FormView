//
//  XYPHSearchFilterGroup.h
//  Halo
//
//  Created by QiuFeng on 22/03/2017.
//  Copyright © 2017 XingIn. All rights reserved.
//

#import <YYModel/YYModel.h>
#import "XYPHSearchGoodsFilterTag.h"
#import "XYPHSearchFilterGroupPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYPHSearchGoodsFilterGroup : NSObject <XYPHSearchFilterGroupPresenter>

@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSArray <XYPHSearchGoodsFilterTag *> *filterTags;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL invisible;
@property (nonatomic, assign) BOOL innerInvisible;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign, readonly) BOOL isNonSelected;

@property (nonatomic, strong, readonly) XYPHSearchGoodsFilterTag *nonSelectedTag;

@end

NS_ASSUME_NONNULL_END
