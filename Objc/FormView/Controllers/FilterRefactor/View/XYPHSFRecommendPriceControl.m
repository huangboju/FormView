//
//  XYPHSFPriceSuggestControl.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/2/25.
//

#import <Masonry/Masonry.h>
#import "Theme.h"
#import "UIColor+Hex.h"

#import "XYPHSFRecommendPriceControl.h"

@interface XYPHSFRecommendPriceControl()

@property (nonatomic, strong) UIView *dummyView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation XYPHSFRecommendPriceControl

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.dummyView];
        [self.dummyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
        
        [self.dummyView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(self);
            make.leading.mas_greaterThanOrEqualTo(0);
        }];
        
        [self.dummyView addSubview:self.descLabel];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(2);
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(0);
            make.leading.mas_greaterThanOrEqualTo(0);
        }];
        
        self.layer.cornerRadius = 4;
        self.layer.borderWidth = 0.5;
        self.backgroundColor = [UIColor colorWithHex:0xF5F8FA];
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.titleLabel.textColor = Theme.colorRed;
        self.descLabel.textColor = Theme.colorRed;
        self.layer.borderColor = Theme.colorRed.CGColor;
        self.layer.backgroundColor = UIColor.whiteColor.CGColor;
    } else {
        self.titleLabel.textColor = Theme.colorGrayLevel1;
        self.descLabel.textColor = Theme.colorGrayLevel2;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.backgroundColor = [UIColor colorWithHex:0xF5F8FA].CGColor;
    }
}

- (void)setDesc:(NSString *)desc {
    _desc = desc;
    self.descLabel.text = desc;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
        _titleLabel.font = Theme.fontSmall;
        _titleLabel.textColor = Theme.colorGrayLevel1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = UILabel.new;
        _descLabel.font = Theme.fontXSmall;
        _descLabel.textColor = Theme.colorGrayLevel2;
        _descLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _descLabel;
}

- (UIView *)dummyView {
    if (!_dummyView) {
        _dummyView = UIView.new;
        _dummyView.userInteractionEnabled = NO;
    }
    return _dummyView;
}

@end
