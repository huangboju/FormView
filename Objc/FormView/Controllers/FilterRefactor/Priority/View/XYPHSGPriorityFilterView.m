//
//  XYPHSGPriorityFilterView.m
//  AFNetworking
//
//  Created by 黄伯驹 on 2019/4/13.
//

#import "XYPHSGPriorityFilterView.h"

#import "XYPHSFPriorityFilterCell.h"

#import "XYPHSearchGoodsFilterGroup.h"

#import "XYPHSFNotesFilterCellDelegate.h"

#import "XYPHSFViewControllerPresenter.h"

#import "UIView+Extension.h"
#import "UIView+XYLayout.h"

static const NSInteger kXYPHSGPriorityFilterViewTag = 1123;

@interface XYPHSGPriorityFilterView()

@property (nonatomic, strong) NSArray <XYPHSFPriorityFilterCell *> *cells;

@property (nonatomic, strong) XYPHSearchGoodsFilterGroup *viewData;

@end


@implementation XYPHSGPriorityFilterView

- (void)updateViewData:(XYPHSearchGoodsFilterGroup *)viewData {
    _viewData = viewData;
}

- (void)reloadData {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
    NSMutableArray <XYPHSFPriorityFilterCell *> *result = NSMutableArray.array;
    
    NSInteger row = 0;
    NSInteger col = 0;
    CGFloat width = CGRectGetWidth(UIScreen.mainScreen.bounds);
    for (NSInteger i = 0; i < self.viewData.filterTags.count; i++) {
        XYPHSearchGoodsFilterTag *tag = self.viewData.filterTags[i];
        row = i / 3;
        if (result.count == 0 || i % 3 == 0) {
            col = 0;
        } else {
            col += 1;
        }
        XYPHSFPriorityFilterCell *cell = [[XYPHSFPriorityFilterCell alloc] initWithFrame:CGRectMake(0, 0, (width - 50) / 3, 36)];
        cell.backgroundColor = UIColor.whiteColor;
        cell.tag = kXYPHSGPriorityFilterViewTag + i;
        cell.selected = [self.selectedFilters containsFilter:tag.tagId];
        [cell updateViewData:tag];
        
        cell.xy_top = 15 + row * (cell.xy_height + 10);
        cell.xy_leading = 15 + col * (cell.xy_width + 10);
        [cell addTarget:self action:@selector(cellClicked:) forControlEvents:UIControlEventTouchUpInside];
        [result addObject:cell];
        [self addSubview:cell];
    }
    self.cells = result.copy;
    self.contentSize = CGSizeMake(width, result.lastObject.xy_bottom + 15);
}

- (void)cellClicked:(XYPHSFPriorityFilterCell *)cell {
    // 是否超过最多可以选择的15个
    if (self.selectedFilters.isOutOfRange) { return; }
    UIViewController *vc = self.viewController;
    if ([vc conformsToProtocol:@protocol(XYPHSGPriorityFilterViewDelegate)]) {
        if (self.isMulti) {
            [self multiSelect:cell];
        } else {
            [self singleSelect:cell];
        }
        [(id <XYPHSGPriorityFilterViewDelegate>)vc friorityFilterViewDidSelectItem:self];
    }
}

- (void)singleSelect:(XYPHSFPriorityFilterCell *)sender {
    XYPHSearchGoodsFilterTag *tag = self.viewData.filterTags[sender.tag - kXYPHSGPriorityFilterViewTag];
    if (sender.isSelected) {
        // 取消选中
        sender.selected = NO;
        [self deselectedWithCellModel:tag];
    } else {
        [self.selectedFilters removeFiltersWithGroupId:self.viewData.groupId];
        [self.cells makeObjectsPerformSelector:@selector(setSelected:) withObject:nil];
        sender.selected = YES;
        [self selectedWithCellModel:tag];
    }
}

- (void)multiSelect:(XYPHSFPriorityFilterCell *)sender {
    XYPHSearchGoodsFilterTag *tag = self.viewData.filterTags[sender.tag - kXYPHSGPriorityFilterViewTag];
    if (sender.isSelected) {
        // 取消选中
        sender.selected = NO;
        [self deselectedWithCellModel:tag];
    } else {
        sender.selected = YES;
        [self selectedWithCellModel:tag];
        
    }
}

- (void)selectedWithCellModel:(XYPHSearchGoodsFilterTag *)cellModel {
    NSString *groupId = self.viewData.groupId;
    NSString *tagId = cellModel.tagId;
    [self.selectedFilters addFilterToGroup:groupId tagId:tagId];
}

- (void)deselectedWithCellModel:(XYPHSearchGoodsFilterTag *)cellModel {
    NSString *groupId = self.viewData.groupId;
    NSString *tagId = cellModel.tagId;
    [self.selectedFilters removeFilterFromGroup:groupId tagId:tagId];
}

- (BOOL)isMulti {
    return [_viewData.type isEqualToString:@"multi"];
}

- (XYSFSelectedFilters *)selectedFilters {
    UIViewController *vc = self.viewController;
    if ([vc conformsToProtocol:@protocol(XYPHSFViewControllerPresenter)]) {
        return [(id <XYPHSFViewControllerPresenter>)vc selectedFilters];
    }
    return nil;
}

@end
