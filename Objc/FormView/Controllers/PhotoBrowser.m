//
//  PhotoBrowser.m
//  FormView
//
//  Created by 黄伯驹 on 2020/2/26.
//  Copyright © 2020 黄伯驹. All rights reserved.
//

#import "PhotoBrowser.h"

#import "MWPhotoBrowser.h"

@interface PhotoBrowser () <MWPhotoBrowserDelegate>

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
    MWPhoto *photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo5" ofType:@"jpg"]]];
    [photos addObject:photo];
    photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo2" ofType:@"jpg"]]];
    [photos addObject:photo];
    photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo3" ofType:@"jpg"]]];
    [photos addObject:photo];
    photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video_thumb" ofType:@"jpg"]]];
    photo.videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"]];
    [photos addObject:photo];
    photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo4" ofType:@"jpg"]]];
    [photos addObject:photo];

    BOOL displaySelectionButtons = NO;
    BOOL autoPlayOnAppear = NO;

    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:0];
    
    [self showViewController:browser sender:nil];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

//- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
//    return [[_selections objectAtIndex:index] boolValue];
//}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
//    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
//    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
//}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
