//
//  XYPHSFGoodsDataSource.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2018/10/22.
//

#import <Foundation/Foundation.h>

#import "XYPHSearchGoodsFilter.h"

NS_ASSUME_NONNULL_BEGIN

@class XYPHSearchGoodsFilterGroup, XYPHSearchNotesFilter;

typedef void(^SFGoodsFilterRequestCompletion)(XYPHSearchGoodsFilter *model);

@interface XYPHSFGoodsDataSource : NSObject

@property (nonatomic, copy) NSString *keyword;

- (void)requsetFilters:(SFGoodsFilterRequestCompletion)completion;

@end

NS_ASSUME_NONNULL_END
