//
//  MTExpListViewModel.h
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/3/17.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//

#import "MTDevSection.h"

@class MTExpListCellItem;

NS_ASSUME_NONNULL_BEGIN

// MTExpListViewModel
@interface MTExpListViewModel : NSObject

@property (nonatomic, strong, readonly) NSDictionary *dict;

- (void)prepareRowsWithCompletion:(void (^ __nullable)(NSArray <MTDevSection *> *sections))completion;

@end

NS_ASSUME_NONNULL_END
