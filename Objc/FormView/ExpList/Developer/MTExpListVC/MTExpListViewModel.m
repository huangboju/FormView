//
//  MTExpListViewModel.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/3/17.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//

#import "MTExpListViewModel.h"

#import "MTExpListCell.h"

#import "MTExpStorage.h"


@interface MTExpListViewModel()

/// dict
@property (nonatomic, strong) NSDictionary *dict;

@property (nonatomic, copy) NSString *wujiPath;

@property (nonatomic, strong) NSNumberFormatter *numberFormatter;

@end

// MTExpListViewModel
@implementation MTExpListViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.numberFormatter = [NSNumberFormatter new];
    }
    return self;
}

- (void)prepareRowsWithCompletion:(void (^)(NSArray<MTDevSection *> * _Nonnull))completion {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{

        self.dict = MTExpStorage.sharedInstance.configCache;
        
        NSDictionary *disguisedCache = MTExpStorage.sharedInstance.disguisedCache;

        NSMutableArray <MTDevSection *> *sections = NSMutableArray.array;
        for (NSString *groupTitle in disguisedCache) {
            NSDictionary *disguisedGroup = disguisedCache[groupTitle];
            NSDictionary *group = self.dict[groupTitle];
            MTDevSection *section = [MTDevSection sectionWithTitle:groupTitle];
            if ([disguisedGroup isKindOfClass:NSDictionary.class]) {
                for (NSString *key in disguisedGroup) {
                    NSInteger expState = [self expStateWithKey:key disguisedGroup:disguisedGroup group:group];
                    id dictValue = disguisedGroup[key];
                    
                    MTExpListCellItem *item = [[MTExpListCellItem alloc] init];
                    [item addTitle:key];
                    [item addGroupTitle:groupTitle];
                    [item addSubTitle:[dictValue description]];
                    [item addExpState:expState];
                    [item addCellStyle:[self cellStyleWithValue:dictValue]];;
                    MTDevRow *row = [MTDevRow rowWithClass:MTExpListCell.class model:item];
                    [section addRow:row];
                }
            } else {
                MTExpListCellItem *item = [[MTExpListCellItem alloc] init];
                [item addTitle:groupTitle];
                [item addGroupTitle:groupTitle];
                [item addSubTitle:[disguisedGroup description]];
                [item addCellStyle:[self cellStyleWithValue:disguisedGroup]];
                MTDevRow *row = [MTDevRow rowWithClass:MTExpListCell.class model:item];
                [section addRow:row];
            }
            [sections addObject:section];
        }
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            completion(sections.copy);
        }];
    });
}

- (NSInteger)expStateWithKey:(NSString *)key
              disguisedGroup:(NSDictionary *)disguisedGroup
                       group:(NSDictionary *)group {
    NSInteger expState = 0;
    id groupValue = group[key];
    id disguisedGroupValue = disguisedGroup[key];
    if (groupValue) {
        if ([groupValue isKindOfClass:NSArray.class] && ![groupValue isEqualToArray:disguisedGroupValue]) {
            expState = 2;
        } else if ([groupValue isKindOfClass:NSDictionary.class] && ![groupValue isEqualToDictionary:disguisedGroupValue]) {
            expState = 2;
        } else {
            expState = [[groupValue description] isEqualToString:[disguisedGroupValue description]] ? 0 : 2;
        }
    } else {
        expState = 1;
    }
    return expState;
}

- (NSNumber *)numberWithValue:(id) value {
    return [self.numberFormatter numberFromString:[value description]];
}

- (UITableViewCellStyle)cellStyleWithValue:(id)value {
    BOOL isNumeric = [self numberWithValue:value];
    return isNumeric ? UITableViewCellStyleValue1 : UITableViewCellStyleSubtitle;;
}

@end
