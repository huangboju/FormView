//
//  XYPHSRGoodsSortButton.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/10.
//

#import "XYPHSRGoodsSortButton.h"
#import "Theme.h"

@implementation XYPHSRGoodsSortButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.titleLabel setFont:Theme.fontSmall];
        [self setTitleColor:Theme.colorGrayLevel2 forState:UIControlStateNormal];
        [self setTitleColor:Theme.colorGrayLevel1 forState:UIControlStateSelected];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.titleLabel.font = selected ? Theme.fontSmallBold : Theme.fontSmall;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    CGFloat maxWidth = 44;
    CGFloat widthDelta = MAX(maxWidth - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
