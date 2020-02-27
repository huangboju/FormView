//
//  XYPGPhoto.h
//  XYPGPhotoBrowser
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XYPGPhotoProtocol.h"

// This class models a photo/image and it's caption
// If you want to handle photos, caching, decompression
// yourself then you can simply ensure your custom data model
// conforms to XYPGPhotoProtocol
@interface XYPGPhoto : NSObject <XYPGPhoto>

@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic) BOOL emptyImage;
@property (nonatomic) BOOL isVideo;

+ (XYPGPhoto *)photoWithImage:(UIImage *)image;
+ (XYPGPhoto *)photoWithURL:(NSURL *)url;
+ (XYPGPhoto *)videoWithURL:(NSURL *)url; // Initialise video with no poster image

- (id)init;
- (id)initWithImage:(UIImage *)image;
- (id)initWithURL:(NSURL *)url;
- (id)initWithVideoURL:(NSURL *)url;

@end

