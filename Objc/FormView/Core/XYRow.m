//
//  XYPHRow.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "XYRow.h"

@interface XYRow()

@property (nonatomic, strong, readwrite) Class cellClass;

@property (nonatomic, strong, readwrite) id model;

@end

@implementation XYRow

+ (instancetype)rowWithClass:(Class)cls {
    return [[self alloc] initWithClass:cls model:nil];
}

+ (instancetype)rowWithClass:(Class)cls model:(id)model {
    return [[self alloc] initWithClass:cls model:model];
}

- (instancetype)initWithClass:(Class)cls model:(id)model {
    if (self = [super init]) {
        self.cellClass = cls;
        self.model = model;
    }
    return self;
}

- (void)updateCell:(UIView *)cell {
    if ([cell respondsToSelector:@selector(updateViewData:)]) {
        [(id<XYUpdatable>)cell updateViewData: self.model];
    }
}

- (NSString *)reuseIdentifier {
    return [NSString stringWithFormat:@"%@", self.cellClass];
}

@end
