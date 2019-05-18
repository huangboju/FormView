//
//  XYSFSelectedFilters.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/3/4.
//

#import "XYSFSelectedFilters.h"

@interface XYSFSelectedFilters()
    
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSOrderedSet <NSString *> *> *selectedFilters;
    
@end



@implementation XYSFSelectedFilters

- (void)addFiltersFromFilterStr:(NSString *)filterStr {
    if (filterStr.length > 0) {
        NSDictionary<NSString *,NSMutableOrderedSet *> *result = [XYSFSelectedFilters noteFiltersToDic:filterStr];
        [self.selectedFilters addEntriesFromDictionary:result];
    }
}

- (void)mergeFilters:(XYSFSelectedFilters *)filters {
    for (NSString *key in filters.selectedFilters) {
        NSMutableOrderedSet <NSString *> *selectedId = [self selectedTagIdWithType:key];
        [selectedId unionOrderedSet:filters.selectedFilters[key]];
    }
}

- (void)addFiltersToGroup:(NSString *)groupId tagIds:(NSArray<NSString *> *)tagIds {
    NSMutableOrderedSet <NSString *> *selectedID = [self selectedTagIdWithType:groupId];
    [selectedID addObjectsFromArray:tagIds];
}

- (void)addFilterToGroup:(NSString *)groupId tagId:(NSString *)tagId {
    NSMutableOrderedSet <NSString *> *selectedID = [self selectedTagIdWithType:groupId];
    [selectedID addObject:tagId];
}

- (void)addSingleFilterToGroup:(NSString *)groupId tagId:(NSString *)tagId {
    NSMutableOrderedSet <NSString *> *selectedID = [self selectedTagIdWithType:groupId];
    [selectedID removeAllObjects];
    [selectedID addObject:tagId];
}
    
- (void)removeFilterFromGroup:(NSString *)groupId tagId:(NSString *)tagId {
    NSMutableOrderedSet <NSString *> *selectedId = [self selectedTagIdWithType:groupId];
    [selectedId removeObject:tagId];
    if (selectedId.count < 1) {
        self.selectedFilters[groupId] = nil;
    }
}

- (void)removeFiltersWithGroupId:(NSString *)groupId {
    self.selectedFilters[groupId] = nil;
}
    
- (void)removeAllFilters {
    [self.selectedFilters removeAllObjects];
}
    
- (NSMutableOrderedSet <NSString *> *)selectedTagIdWithType:(NSString *)type {
    NSMutableOrderedSet <NSString *> *selectedId = [self.selectedFilters[type] mutableCopy];
    if (!selectedId) {
        selectedId = NSMutableOrderedSet.new;
    }
    self.selectedFilters[type] = selectedId;
    return selectedId;
}

- (NSString *)filterStr {
    if (self.selectedFilters.count < 1) { return @""; }
    NSMutableArray *reuslt = [NSMutableArray array];
    for (NSString *key in self.selectedFilters) {
        NSOrderedSet *set = self.selectedFilters[key];
        if (!set || !key) { continue; }
        NSArray *tags = set.array;
        NSDictionary *dict = @{
                               @"type": key,
                               @"tags": tags
                               };
        [reuslt addObject:dict];
    }
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:reuslt options:0 error:nil] encoding:NSUTF8StringEncoding] ?: @"";
}

- (NSInteger)filterCount {
    return self.allFilters.count;
}

- (NSOrderedSet <NSString *>*)allFilters {
    NSMutableOrderedSet *result = NSMutableOrderedSet.new;
    for (NSOrderedSet *set in self.selectedFilters.allValues) {
        [result unionOrderedSet:set];
    }
    return result.copy;
}

- (BOOL)containsFilter:(NSString *)filter {
    return [self.allFilters containsObject:filter];
}

- (BOOL)containsGroup:(NSString *)groupId {
    return self.selectedFilters[groupId].count > 0;
}
    
- (NSMutableDictionary<NSString *, NSOrderedSet<NSString *> *> *)selectedFilters {
    if (!_selectedFilters) {
        _selectedFilters = NSMutableDictionary.dictionary;
    }
    return _selectedFilters;
}

+ (NSDictionary<NSString *,NSMutableOrderedSet *> *)noteFiltersToDic:(NSString *)filterStr {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSArray *filtersArray = [NSJSONSerialization JSONObjectWithData:[filterStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    if (!filtersArray) {
        return result;
    }
    for (NSDictionary *obj in filtersArray) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            if ([obj[@"tags"] isKindOfClass:[NSArray class]]) {
                NSMutableOrderedSet *tags = [NSMutableOrderedSet orderedSetWithArray:obj[@"tags"]];
                result[obj[@"type"]] = tags;
            }
        }

    }
    return result;
}

- (NSOrderedSet <NSString *>*)objectForKeyedSubscript:(NSString *)key {
    return self.selectedFilters[key];
}


- (void)setObject:(NSOrderedSet <NSString *>*)object forKeyedSubscript:(NSString *)key {
    self.selectedFilters[key] = object;
}

- (NSString *)description {
    NSMutableString *result = [NSMutableString stringWithString:@"{\n"];
    for (NSString *key in self.selectedFilters) {
        [result appendFormat:@"%@: %@,\n", key, self.selectedFilters[key]];
    }
    [result appendString:@"\n}"];
    return result.copy;
}

- (BOOL)isOutOfRange {
    if (self.filterCount > 14) {
        NSLog(@"最多只能选15个哦");
        return YES;
    }
    return NO;
}

- (BOOL)isEmpty {
    return self.filterCount < 1;
}

@end
