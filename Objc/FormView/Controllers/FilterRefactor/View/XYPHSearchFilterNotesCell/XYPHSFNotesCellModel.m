//
//  XYPHSearchFilterNotesCellModel.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/3/4.
//

#import "XYPHSFNotesCellModel.h"

@interface XYPHSFNotesCellModel()

@property (nonatomic, strong) NSDictionary *attributes;

@property (nonatomic, strong) id <XYPHSearchFilterGroupPresenter> data;

@property (nonatomic, strong) NSArray <XYPHSearchFilterTagCellModel *> *items;

@property (nonatomic, assign) NSInteger row;

@end

@implementation XYPHSFNotesCellModel

+ (instancetype)modelWithModel:(id <XYPHSearchFilterGroupPresenter>)model
               selectedFilters:(nonnull NSOrderedSet *)selectedFilters
                           row:(NSInteger)row {
    XYPHSFNotesCellModel *cellModel = [XYPHSFNotesCellModel new];
    cellModel.data = model;
    cellModel.row = row;
    
    NSMutableArray *result = NSMutableArray.array;
    NSInteger index = 0;
    for (id <XYPHSearchFilterPresenter> obj in model.filterTags) {
        XYPHSearchFilterTagCellModel *viewModel = [XYPHSearchFilterTagCellModel modelWithModel:obj index:index];
        // 这里没有 || 上 obj.selected，因为selectedFilters中已经包括了，selectedFilters中还包括deeplink过来的默认筛选
        viewModel.selected = [selectedFilters containsObject:obj.tagId];
        // 选中的位置在6个以后，需要展开
        if (viewModel.selected && index > 5) {
            cellModel.expanding = YES;
        }
        [result addObject:viewModel];
        index += 1;
    }
    cellModel.items = result.copy;
    
    return cellModel;
}

- (NSString *)groupName {
    return self.data.title;
}

- (BOOL)noShowMore {
    return self.data.filterTags.count <= 6;
}

- (CGFloat)displayHeight {
    if (self.data.filterTags.count > 3) {
        return 82;
    }
    return 36;
}

- (CGFloat)maxHeight {
    if (self.noShowMore) {
        return self.displayHeight;
    }
    NSInteger row = (self.data.filterTags.count + 3 - 1) / 3;
    return row * 36.f + (row - 1) * 10;
}

- (BOOL)isMulti {
    return [self.data.type isEqualToString:@"multi"];
}

- (NSString *)groupId {
    return self.data.groupId;
}

- (BOOL)invisible {
    return self.data.invisible;
}

@end
