//
//  UIWindow+Shake.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/2/20.
//

#import "UIWindow+MTDeveloperEntrance.h"

#import "MTDevNavController.h"

@implementation UIWindow (MTDeveloperEntrance)

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
#ifdef DEBUG
    if (motion != UIEventSubtypeMotionShake) {
        return;
    }
    [MTDevNavController showIfNeeded];
#endif
}

@end
