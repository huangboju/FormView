//
//  ScrollAnimationImageView.h
//  FormView
//
//  Created by 黄伯驹 on 17/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CALayer (AnimationControl)

- (void)pauseAnimation;

- (void)resumeAnimation;

@end

@interface XYPHResumeAnimationImageView : UIImageView

- (void)resumeAnimation;

- (void)pauseAnimation;

@end
