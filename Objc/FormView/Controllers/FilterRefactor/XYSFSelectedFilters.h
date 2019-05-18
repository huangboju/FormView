//
//  XYSFSelectedFilters.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/3/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYSFSelectedFilters : NSObject

@property (nonatomic, assign, readonly) NSInteger filterCount;

@property (nonatomic, copy, readonly) NSString *filterStr;

@property (nonatomic, assign, readonly) BOOL isOutOfRange;

@property (nonatomic, assign, readonly) BOOL isEmpty;

- (void)addFiltersFromFilterStr:(NSString *)filterStr;

- (void)mergeFilters:(XYSFSelectedFilters *)filters;

- (void)addFiltersToGroup:(NSString *)groupId
                   tagIds:(NSArray <NSString *> *)tagIds;

- (void)addFilterToGroup:(NSString *)groupId
                   tagId:(NSString *)tagId;

- (void)addSingleFilterToGroup:(NSString *)groupId
                         tagId:(NSString *)tagId;

- (void)removeFilterFromGroup:(NSString *)groupId
                        tagId:(NSString *)tagId;

- (void)removeFiltersWithGroupId:(NSString *)groupId;
    
- (void)removeAllFilters;

- (BOOL)containsFilter:(NSString *)filter;

- (BOOL)containsGroup:(NSString *)groupId;

- (NSOrderedSet <NSString *>*)objectForKeyedSubscript:(NSString *)key;

- (void)setObject:(NSOrderedSet <NSString *>*)object forKeyedSubscript:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
