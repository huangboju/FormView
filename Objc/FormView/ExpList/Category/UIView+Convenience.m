//
//  UIView+Convenience.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/2/20.
//

#import "UIView+Convenience.h"

@implementation UIView (Convenience)

- (UIViewController *)viewController {
    UIResponder *nextResponder =  self;
    
    do {
        nextResponder = nextResponder.nextResponder;
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    } while (nextResponder != nil);
    
    return nil;
}

@end
