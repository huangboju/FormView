//
//  AccountCell.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "AccountFieldCell.h"

@implementation AccountCellItem

@end


@interface AccountFieldCell()<Updatable>


@end

@implementation AccountFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UIView *dummyView = [[UIView alloc] init];
        dummyView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView insertSubview:dummyView belowSubview:self.textField];
        [dummyView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [dummyView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        NSLayoutConstraint *constraint = [dummyView.heightAnchor constraintEqualToConstant:60];

        constraint.priority = 999;
        constraint.active = YES;
    }
    return self;
}

- (void)updateViewData:(AccountCellItem *)viewData {
    self.textField.placeholder = viewData.placeholder;
}


@end
