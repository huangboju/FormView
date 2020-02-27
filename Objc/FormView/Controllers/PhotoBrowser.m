//
//  PhotoBrowser.m
//  FormView
//
//  Created by 黄伯驹 on 2020/2/26.
//  Copyright © 2020 黄伯驹. All rights reserved.
//

#import "PhotoBrowser.h"

#import "XYPGPhotoBrowser.h"

@interface PhotoBrowser () <XYPGPhotoBrowserDelegate>

@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic, strong) NSMutableArray *thumbs;

@end

@implementation PhotoBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSMutableArray *photos = NSMutableArray.array;
    _photos = photos;
    XYPGPhoto *photo = [XYPGPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo5" ofType:@"jpg"]]];
    [photos addObject:photo];
    photo = [XYPGPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo2" ofType:@"jpg"]]];
    [photos addObject:photo];
    photo = [XYPGPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo3" ofType:@"jpg"]]];
    [photos addObject:photo];
    photo = [XYPGPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video_thumb" ofType:@"jpg"]]];
    photo.videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"]];
    [photos addObject:photo];
    photo = [XYPGPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo4" ofType:@"jpg"]]];
    [photos addObject:photo];

    BOOL autoPlayOnAppear = NO;

    XYPGPhotoBrowser *browser = [[XYPGPhotoBrowser alloc] initWithDelegate:self];
    browser.zoomPhotosToFill = YES;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:3];
    
    [self showViewController:browser sender:nil];
}

#pragma mark - XYPGPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(XYPGPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <XYPGPhoto>)photoBrowser:(XYPGPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <XYPGPhoto>)photoBrowser:(XYPGPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}


- (void)photoBrowser:(XYPGPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (void)photoBrowserDidFinishModalPresentation:(XYPGPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
