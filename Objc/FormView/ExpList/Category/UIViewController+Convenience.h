//
//  UIViewController+Convenience.h
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/2/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Convenience)

@property (nonatomic, strong, readonly) UIViewController *visibleViewController;

- (void)showComingSoonAlert;

@end

NS_ASSUME_NONNULL_END
