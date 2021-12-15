//
//  MTDevSection.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/3/17.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//

#import "MTDevSection.h"

@interface MTDevSection()

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSMutableArray <MTDevRow *> *rows;

@end


// MTDevSection
@implementation MTDevSection

+ (instancetype)sectionWithTitle:(NSString *)title {
    MTDevSection *section = MTDevSection.new;
    section.title = title;
    return section;
}

- (NSUInteger)rowCount {
    return self.rows.count;
}

- (void)insertRow:(MTDevRow *)row atIndex:(NSUInteger)idx {
    [self.rows insertObject:row atIndex:idx];
}

- (void)addRow:(MTDevRow *)row {
    [self.rows addObject:row];
}

- (void)addRows:(NSArray<MTDevRow *> *)rows {
    [self.rows addObjectsFromArray:rows];
}

- (MTDevRow *)objectAtIndexedSubscript:(NSUInteger)idx {
    return self.rows[idx];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self.rows removeObjectAtIndex:index];
}

- (void)setObject:(MTDevRow *)obj atIndexedSubscript:(NSUInteger)idx {
    self.rows[idx] = obj;
}

- (NSMutableArray<MTDevRow *> *)rows {
    if (!_rows) {
        _rows = NSMutableArray.array;
    }
    return _rows;
}

- (NSString *)description {
    return self.rows.description;
}

@end
