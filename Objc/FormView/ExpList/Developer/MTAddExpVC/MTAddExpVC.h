//
//  MTAddExpVC.h
//  Alpha
//
//  Created by xiAo-Ju on 2021/3/18.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTDevSection;

@class MTAddExpVC;
@class MTExpListViewModel;

NS_ASSUME_NONNULL_BEGIN

@protocol MTAddExpVCDelegate <NSObject>

- (void)addExpVCDidAddNewExp:(MTAddExpVC *)addExpVC atIndexPath:(NSIndexPath *)indexPath;

@end

// MTAddExpVC
@interface MTAddExpVC : UIViewController

/// sections
@property (nonatomic, strong) NSArray<MTDevSection *> *sections;

@property (nonatomic, weak) id<MTAddExpVCDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
