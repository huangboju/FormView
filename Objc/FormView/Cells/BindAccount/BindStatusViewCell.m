//
//  BindStatusViewCell.m
//  FormView
//
//  Created by 黄伯驹 on 28/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "BindStatusViewCell.h"

#import "BindStatusView.h"

#import <Masonry.h>

#import "TitleCellItem.h"

@interface BindStatusViewCell()

@property (nonatomic, strong) BindStatusView *bindStatusView;

@end

@implementation BindStatusViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    
        NSArray *icontypes = @[
                               @"qq",
                               @"weixin",
                               @"weibo",
                               @"facebook",
                               @"mobile"
                               ];
        
        NSMutableArray *items = [NSMutableArray array];
        for (NSString *icontype in icontypes) {
            BindStatusViewItem *item = [BindStatusViewItem new];
            item.text = icontype;
            item.socialType = icontype;
            [items addObject:item];
        }
        
        [self addSubview:self.bindStatusView];
        [self.bindStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0);
            make.leading.mas_equalTo(47);
        }];
        
        [self.bindStatusView updateViewData:items];
    }
    return self;
}

- (void)updateViewData:(TitleCellItem *)viewData {
    
}

- (BindStatusView *)bindStatusView {
    if (!_bindStatusView) {
        _bindStatusView = [BindStatusView new];
        _bindStatusView.backgroundColor = [UIColor redColor];
        _bindStatusView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _bindStatusView.layer.cornerRadius = 4;
        _bindStatusView.layer.shadowOpacity = 0.8f;
        _bindStatusView.layer.shadowOffset = CGSizeMake(0, 2);
    }
    return _bindStatusView;
}

@end
