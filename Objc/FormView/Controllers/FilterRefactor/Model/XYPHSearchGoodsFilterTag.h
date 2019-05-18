//
//  XYPHSearchFilterTag.h
//  Halo
//
//  Created by QiuFeng on 22/03/2017.
//  Copyright © 2017 XingIn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYPHSearchGoodsFilterTag : NSObject

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *selectedImage;
@property (nonatomic, copy) NSString *selectedColor;

// <XYPHSearchFilterPresenter>
@property (nonatomic, copy) NSString *tagId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL selected;

@end
