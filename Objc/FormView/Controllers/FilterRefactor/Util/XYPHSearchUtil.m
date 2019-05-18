//
//  XYPHSearchUtil.m
//  FormView
//
//  Created by 黄伯驹 on 2019/5/2.
//  Copyright © 2019 黄伯驹. All rights reserved.
//

#import "XYPHSearchUtil.h"

#import "Theme.h"

static CGFloat _pixelOne = -1;

@implementation XYPHSearchUtil

+ (CGFloat)contentWidth {
    return CGRectGetWidth(UIScreen.mainScreen.bounds) * 335.f / 375;
}

+ (CGFloat)pixelOne {
    if (_pixelOne < 0) {
        _pixelOne = 1 / UIScreen.mainScreen.scale;
    }
    return _pixelOne;
}

+ (UIView *)separatorLine {
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    return line;
}

@end
