//
//  UserInfoLayer.h
//  FormView
//
//  Created by xiAo_Ju on 2018/5/14.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface UserInfoLayer : CALayer

/**
 Default 13 * 13;
 */
@property (nonatomic) CGSize avatarSize;

/**
 Default [UIFont systemFontOfSize:11]
 */
@property (nonatomic, strong, nonnull) UIFont *font;

/**
 Default 0x999999
 */
@property (nonatomic, strong, nonnull) UIColor *textColor;

@property (nonatomic, assign) BOOL isCertified;

@property (nonatomic, strong, nonnull) UIImage *avatar;

@property (nonatomic, copy, nonnull) NSString *nickname;

@end
