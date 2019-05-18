//
//  XYPHSearchFilterGroupPresenter.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/29.
//

#import "XYPHSearchFilterPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XYPHSearchFilterGroupPresenter <NSObject>

@property (nonatomic, assign) BOOL invisible;

@property (nonatomic, copy) NSString *groupId;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray <XYPHSearchFilterPresenter> *filterTags;

@end

NS_ASSUME_NONNULL_END
