//
//  BindAccountTitleCell.m
//  FormView
//
//  Created by xiAo_Ju on 23/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "BindAccountTitleCell.h"
#import <Masonry.h>

@implementation BindAccountTitleCellItem

@end

@interface BindAccountTitleCell()<Updatable>

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BindAccountTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(38);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(40);
            make.bottom.mas_equalTo(-20);
        }];
        
    }
    return self;
}

- (void)updateViewData:(BindAccountTitleCellItem *)viewData {
    self.titleLabel.text = viewData.title;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
