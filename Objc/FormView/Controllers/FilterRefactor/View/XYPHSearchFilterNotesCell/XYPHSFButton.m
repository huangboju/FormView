//
//  XYPHSFButton.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/3/7.
//

#import "XYPHSFButton.h"
#import "XYPHSearchFilterTagCellModel.h"
#import "XYPHSearchUtil.h"
#import "UIColor+Hex.h"
#import "Theme.h"

@interface XYPHSFButton()

@property (nonatomic, strong) XYPHSearchFilterTagCellModel *item;

@end

@implementation XYPHSFButton

+ (instancetype)buttonWithItem:(XYPHSearchFilterTagCellModel *)item {
    XYPHSFButton *button = XYPHSFButton.new;
    button.item = item;
    return button;
}

- (instancetype)initWithFrame:(CGRect)frame {
    CGSize size = CGSizeMake(floor((XYPHSearchUtil.contentWidth - 50) / 3), 36);
    if (self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)]) {
        self.layer.cornerRadius = 4;
        self.layer.borderWidth = 0.5;
        self.backgroundColor = [UIColor colorWithHex:0xF5F8FA];
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }
    return self;
}

- (void)setItem:(XYPHSearchFilterTagCellModel *)item {
    _item = item;
    self.selected = item.selected;
    [self setTitle:item.title forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.item.selected = selected;
    if (selected) {
        self.backgroundColor = [UIColor whiteColor];
        [self setTitleColor:[UIColor colorWithHex:0xFF2741] forState:UIControlStateNormal];
        self.titleLabel.font = Theme.fontSmallBold;
        self.layer.borderColor = [UIColor colorWithHex:0xFF2741].CGColor;
    } else {
        self.backgroundColor = [UIColor colorWithHex:0xF5F8FA];
        [self setTitleColor:Theme.colorGrayLevel1 forState:UIControlStateNormal];
        self.titleLabel.font = Theme.fontSmall;
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

@end
