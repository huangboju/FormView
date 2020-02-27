//
//  ZoomingScrollView.h
//  XYPGPhotoBrowser
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYPGPhotoProtocol.h"
#import "XYPGTapDetectingImageView.h"
#import "XYPGTapDetectingView.h"

@class XYPGPhotoBrowser, XYPGPhoto;

@interface XYPGZoomingScrollView : UIScrollView <UIScrollViewDelegate, XYPGTapDetectingImageViewDelegate, XYPGTapDetectingViewDelegate> {

}

@property () NSUInteger index;
@property (nonatomic) id <XYPGPhoto> photo;
@property (nonatomic, weak) UIButton *playButton;

- (id)initWithPhotoBrowser:(XYPGPhotoBrowser *)browser;
- (void)displayImage;
- (void)displayImageFailure;
- (void)setMaxMinZoomScalesForCurrentBounds;
- (void)prepareForReuse;
- (BOOL)displayingVideo;
- (void)setImageHidden:(BOOL)hidden;

@end
