//
//  ScrollAnimationImageView.m
//  FormView
//
//  Created by 黄伯驹 on 17/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYPHResumeAnimationImageView.h"

@implementation CALayer (AnimationControl)

- (void)pauseAnimation {
    if (![self isPaused]) {
        CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
        self.speed = 0.0;
        self.timeOffset = pausedTime;
    }
}

- (void)resumeAnimation {
    if (![self isPaused]) { return; }

    CFTimeInterval pausedTime = self.timeOffset;
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}

- (BOOL)isPaused {
    return self.speed == 0.0;
}

@end

@interface XYPHResumeAnimationImageView()

@property (nonatomic, strong) NSMutableDictionary <NSString *, CAAnimation *> *persistentAnimations;

@property (nonatomic, assign) float persistentSpeed;

@end

@implementation XYPHResumeAnimationImageView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super initWithImage:image]) {
        self.persistentAnimations = [NSMutableDictionary dictionary];
        self.persistentSpeed = 0;
        [self addObservers];
    }
    return self;
}

- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resumeAnimation) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pauseAnimation) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)resumeAnimation {
    [self restoreAnimationsWithKeys:self.persistentAnimations.allKeys];
    [self.persistentAnimations removeAllObjects];
    if (self.persistentSpeed == 1.0) { //if layer was plaiyng before backgorund, resume it
        [self.layer resumeAnimation];
    }
}

- (void)pauseAnimation {
    self.persistentSpeed = self.layer.speed;
    self.layer.speed = 1.0; //in case layer was paused from outside, set speed to 1.0 to get all animations
    [self persistAnimationsWithKeys:[self.layer animationKeys]];
    self.layer.speed = self.persistentSpeed; //restore original speed
    [self.layer pauseAnimation];
}
    
- (void)persistAnimationsWithKeys:(NSArray <NSString *>*)keys {
    for (NSString *key in keys) {
        CAAnimation *animation = [self.layer animationForKey:key];
        self.persistentAnimations[key] = animation;
    }
}
    
- (void)restoreAnimationsWithKeys:(NSArray <NSString *>*)keys {
    for (NSString *key in keys) {
        CAAnimation *animation = self.persistentAnimations[key];
        if (animation) {
            [self.layer addAnimation:animation forKey:key];
        }
    }
}

@end
