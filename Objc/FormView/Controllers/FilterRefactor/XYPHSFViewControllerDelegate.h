//
//  XYPHSFViewControllerDelegate.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/11.
//

#import "XYPHSFViewControllerPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XYPHSFViewControllerDelegate <NSObject>

- (void)searchFilterViewControllerDoneButtonClicked:(UIViewController <XYPHSFViewControllerPresenter> *)viewController;

- (void)searchFilterViewControllerDidChangedSelectedTag:(UIViewController <XYPHSFViewControllerPresenter> *)viewController;

@end

NS_ASSUME_NONNULL_END
