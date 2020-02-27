//
//  XYPGPhotoBrowser.h
//  XYPGPhotoBrowser
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPGPhoto.h"
#import "XYPGPhotoProtocol.h"

// Debug Logging
#if 0 // Set to 1 to enable debug logging
#define MWLog(x, ...) NSLog(x, ## __VA_ARGS__);
#else
#define MWLog(x, ...)
#endif

@class XYPGPhotoBrowser;

@protocol XYPGPhotoBrowserDelegate <NSObject>

- (NSUInteger)numberOfPhotosInPhotoBrowser:(XYPGPhotoBrowser *)photoBrowser;
- (id <XYPGPhoto>)photoBrowser:(XYPGPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index;

@optional

- (id <XYPGPhoto>)photoBrowser:(XYPGPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index;
- (void)photoBrowser:(XYPGPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index;
- (void)photoBrowser:(XYPGPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected;
- (void)photoBrowserDidFinishModalPresentation:(XYPGPhotoBrowser *)photoBrowser;

@end

@interface XYPGPhotoBrowser : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet id<XYPGPhotoBrowserDelegate> delegate;
@property (nonatomic) BOOL zoomPhotosToFill;
@property (nonatomic) BOOL autoPlayOnAppear;
@property (nonatomic, readonly) NSUInteger currentIndex;

// Init
- (id)initWithPhotos:(NSArray *)photosArray;
- (id)initWithDelegate:(id <XYPGPhotoBrowserDelegate>)delegate;

// Reloads the photo browser and refetches data
- (void)reloadData;

// Set page that photo browser starts on
- (void)setCurrentPhotoIndex:(NSUInteger)index;

// Navigation
- (void)showNextPhotoAnimated:(BOOL)animated;
- (void)showPreviousPhotoAnimated:(BOOL)animated;

@end
