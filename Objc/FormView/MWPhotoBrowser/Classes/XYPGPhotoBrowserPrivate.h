//
//  XYPGPhotoBrowser_Private.h
//  XYPGPhotoBrowser
//
//  Created by 黄伯驹 on 2017/12/4.
//
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import "XYPGZoomingScrollView.h"

// Declare private methods of browser
@interface XYPGPhotoBrowser () {
    
	// Data
    NSUInteger _photoCount;
    NSMutableArray *_photos;
    NSMutableArray *_thumbPhotos;
	NSArray *_fixedPhotosArray; // Provided via init
	
	// Views
	UIScrollView *_pagingScrollView;
	
	// Paging & layout
	NSMutableSet *_visiblePages, *_recycledPages;
	NSUInteger _currentPageIndex;
    NSUInteger _previousPageIndex;
    CGRect _previousLayoutBounds;
	NSUInteger _pageIndexBeforeRotation;
    
    // Video
    AVPlayerViewController *_currentVideoPlayerViewController;
    NSUInteger _currentVideoIndex;
    UIActivityIndicatorView *_currentVideoLoadingIndicator;
    
    // Misc
    BOOL _hasBelongedToViewController;
    BOOL _isVCBasedStatusBarAppearance;
	BOOL _performingLayout;
	BOOL _rotating;
    BOOL _viewIsActive; // active as in it's in the view heirarchy
    BOOL _didSavePreviousStateOfNavBar;
    BOOL _skipNextPagingScrollViewPositioning;
    BOOL _viewHasAppearedInitially;
    CGPoint _currentGridContentOffset;
    
}

// Layout
- (void)layoutVisiblePages;
- (void)performLayout;

// Paging
- (void)tilePages;
- (BOOL)isDisplayingPageForIndex:(NSUInteger)index;
- (XYPGZoomingScrollView *)pageDisplayedAtIndex:(NSUInteger)index;
- (XYPGZoomingScrollView *)pageDisplayingPhoto:(id<XYPGPhoto>)photo;
- (XYPGZoomingScrollView *)dequeueRecycledPage;
- (void)configurePage:(XYPGZoomingScrollView *)page forIndex:(NSUInteger)index;
- (void)didStartViewingPageAtIndex:(NSUInteger)index;

// Frames
- (CGRect)frameForPagingScrollView;
- (CGRect)frameForPageAtIndex:(NSUInteger)index;
- (CGSize)contentSizeForPagingScrollView;
- (CGPoint)contentOffsetForPageAtIndex:(NSUInteger)index;

- (void)jumpToPageAtIndex:(NSUInteger)index animated:(BOOL)animated;

// Data
- (NSUInteger)numberOfPhotos;
- (id<XYPGPhoto>)photoAtIndex:(NSUInteger)index;
- (id<XYPGPhoto>)thumbPhotoAtIndex:(NSUInteger)index;
- (UIImage *)imageForPhoto:(id<XYPGPhoto>)photo;
- (void)loadAdjacentPhotosIfNecessary:(id<XYPGPhoto>)photo;
- (void)releaseAllUnderlyingPhotos:(BOOL)preserveCurrent;

@end

