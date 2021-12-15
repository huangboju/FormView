//
//  MTExpListSearchResultVC.h
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/3/23.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//


#import <UIKit/UIKit.h>

@class MTDevRow;

NS_ASSUME_NONNULL_BEGIN

// MTExpListSearchResultVC
@interface MTExpListSearchResultVC : UIViewController

/// searchResult
@property (nonatomic, strong) NSArray <MTDevRow *> *searchResult;

@end

NS_ASSUME_NONNULL_END
