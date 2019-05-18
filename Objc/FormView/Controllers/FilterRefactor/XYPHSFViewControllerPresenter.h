//
//  XYPHSFViewControllerPresenter.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/11.
//

#import "XYSFSelectedFilters.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XYPHSFViewControllerPresenter <NSObject>

@property (nonatomic, strong, readonly) XYSFSelectedFilters *selectedFilters;

@optional

- (void)referenceSelectedFilters:(XYSFSelectedFilters *)selectedFilters;

@end

NS_ASSUME_NONNULL_END
