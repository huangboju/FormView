//
//  BindAccountTitleCell.m
//  FormView
//
//  Created by xiAo_Ju on 23/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "BindAccountTitleCell.h"
#import <Masonry.h>

#import "TitleCellItem.h"

@interface BindAccountTitleCell()<Updatable>

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BindAccountTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(38);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(40);
            make.bottom.mas_equalTo(-10);
        }];
    }
    return self;
}

- (void)updateViewData:(TitleCellItem *)viewData {
    self.titleLabel.text = viewData.title;
    
    if (viewData.isShow) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(38);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(20);
            make.top.bottom.mas_equalTo(0);
        }];
    } else {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(38);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(40);
            make.bottom.mas_equalTo(-10);
        }];
    }
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
