//
//  CenterTextLayer.m
//  FormView
//
//  Created by xiAo_Ju on 2018/6/12.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "CenterTextLayer.h"
#import <UIKit/UIKit.h>

@implementation CenterTextLayer

- (void)drawInContext:(CGContextRef)ctx {
    CGFloat height = self.bounds.size.height;
    CGFloat offsetHeight = self.fontSize;
    if ([self.string isKindOfClass:[NSAttributedString class]]) {
        offsetHeight = [(NSAttributedString *)self.string size].height;
    }
    CGFloat yDiff = (height - offsetHeight) / 2;

    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, 0, yDiff);
    [super drawInContext:ctx];
    CGContextRestoreGState(ctx);
}

@end
