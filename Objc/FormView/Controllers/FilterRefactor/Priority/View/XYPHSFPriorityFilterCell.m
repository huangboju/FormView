//
//  XYPHSFPriorityFilterCell.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/12.
//

#import <Masonry/Masonry.h>

#import "XYPHSFPriorityFilterCell.h"

#import "XYPHSearchGoodsFilterTag.h"

#import "Theme.h"


@interface XYPHSFPriorityFilterCell ()

@property (nonatomic, strong) UILabel *tagNameLabel;
@property (nonatomic, strong) UIImageView *accessoryView;

@end

@implementation XYPHSFPriorityFilterCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.accessoryView];
        [self.accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.trailing.mas_equalTo(0);
        }];
        
        [self addSubview:self.tagNameLabel];
        [self.tagNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.centerY.mas_equalTo(0);
            make.trailing.mas_equalTo(self.accessoryView.mas_leading);
        }];
    }
    return self;
}

#pragma mark - public Method

- (void)updateViewData:(XYPHSearchGoodsFilterTag *)viewData {
    self.tagNameLabel.text = viewData.title;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.accessoryView.hidden = !selected;
    if (selected) {
        self.tagNameLabel.font = Theme.fontSmallBold;
        self.tagNameLabel.textColor = Theme.colorRed;
    } else {
        self.tagNameLabel.font = Theme.fontSmall;
        self.tagNameLabel.textColor = Theme.colorGrayLevel1;
    }
}

#pragma mark - Accessors

- (UILabel *)tagNameLabel {
    if (_tagNameLabel == nil) {
        _tagNameLabel = [[UILabel alloc] init];
        _tagNameLabel.font = Theme.fontSmall;
        _tagNameLabel.textColor = Theme.colorGrayLevel1;
        _tagNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tagNameLabel;
}

- (UIImageView *)accessoryView {
    if (!_accessoryView) {
        _accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"priority_filter_seleceted"]];
        _accessoryView.hidden = YES;
        [_accessoryView setContentCompressionResistancePriority:751 forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _accessoryView;
}

@end
