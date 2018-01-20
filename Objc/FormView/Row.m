//
//  Row.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "Row.h"

@interface Row()

@property(nonatomic, strong, readwrite) Class cellClass;

@property(nonatomic, strong, readwrite) id model;

@end

@implementation Row

- (instancetype)initWithClass:(Class)cls {
    if (self = [self initWithClass:cls model:@""]) {
        
    }
    return self;
}

- (instancetype)initWithClass:(Class)cls model:(id)model {
    if (self = [super init]) {
        self.cellClass = cls;
        self.model = model;
    }
    return self;
}

- (void)updateCell:(UITableViewCell *)cell {
    if ([cell respondsToSelector:@selector(updateViewData:)]) {
        [cell performSelector:@selector(updateViewData:) withObject:self.model];
    }
}

- (NSString *)reuseIdentifier {
    return [NSString stringWithFormat:@"%@", self.cellClass];
}

@end
