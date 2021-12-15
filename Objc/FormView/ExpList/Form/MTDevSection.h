//
//  MTDevSection.h
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/3/17.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//

#import "MTDevRow.h"

NS_ASSUME_NONNULL_BEGIN

// MTDevSection
@interface MTDevSection : NSObject

@property (nonatomic, copy, readonly) NSString *title;

@property (nonatomic, copy, readonly) NSMutableArray <MTDevRow *> *rows;

@property (nonatomic, assign, readonly) NSUInteger rowCount;

+ (instancetype)sectionWithTitle:(NSString *)title;

- (void)addRow:(MTDevRow *)row;

- (void)addRows:(NSArray<MTDevRow *> *)rows;

- (void)insertRow:(MTDevRow *)row atIndex:(NSUInteger)idx;

- (void)removeObjectAtIndex:(NSUInteger)index;

- (MTDevRow *)objectAtIndexedSubscript:(NSUInteger)idx;

- (void)setObject:(MTDevRow *)obj atIndexedSubscript:(NSUInteger)idx;

@end

NS_ASSUME_NONNULL_END
