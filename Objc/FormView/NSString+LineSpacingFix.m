//
//  NSString+LineSpacingFix.m
//  Halo
//
//  Created by steven sun on 2017/7/11.
//  Copyright © 2017年 XingIn. All rights reserved.
//

#import "NSString+LineSpacingFix.h"
@import CoreText;
@implementation NSString (LineSpacingFix)

/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font lineSpacing:(CGFloat)lineSpacing {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    NSMutableDictionary *attributesDic = [[NSMutableDictionary alloc] initWithDictionary:@{
                                                                                          NSFontAttributeName:font,
                                                                                          NSParagraphStyleAttributeName:paragraphStyle}];

    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self attributes:attributesDic];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributeString boundingRectWithSize:size options:options context:nil];

    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    if ((rect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing) {
        if ([self containChinese:self] || [self containEmoji:self]) {  //如果包含中文、Emoji
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - paragraphStyle.lineSpacing);
        }
    }
    
    return rect.size;
}

//判断如果包含中文
- (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++) {
        int a = [str characterAtIndex:i];
        if(a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

//判断是否有emoji
- (BOOL)containEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar high = [substring characterAtIndex: 0];
                                if (0xD800 <= high && high <= 0xDBFF && substring.length > 1) {
                                    //三方键盘越界crash防护
                                    const unichar low = [substring characterAtIndex: 1];
                                    const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                    
                                    if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= high && high <= 0x27BF){
                                        returnValue = YES;
                                    }
                                }
                            }];
    return returnValue;
}

/**
 *  计算最大行数文字高度,可以处理计算带行间距的
 */
- (CGFloat)boundingRectWithSize:(CGSize)size font:(UIFont*)font lineSpacing:(CGFloat)lineSpacing maxLines:(NSInteger)maxLines {
    if (maxLines <= 0) {
        return 0;
    }
    
    CGFloat maxHeight = font.lineHeight * maxLines + lineSpacing * (maxLines - 1);
    
    CGSize orginalSize = [self boundingRectWithSize:size font:font lineSpacing:lineSpacing];
    
    if (orginalSize.height >= maxHeight) {
        return maxHeight;
    } else {
        return orginalSize.height;
    }
}

/**
 *  计算是否超过一行   用于给Label 赋值attribute text的时候 超过一行设置lineSpace
 */
- (BOOL)isMoreThanOneLineWithSize:(CGSize)size font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing {
    if ([self boundingRectWithSize:size font:font lineSpacing:lineSpacing].height > font.lineHeight) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isEmoji {
    NSUInteger stringUtf8Length = [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    return stringUtf8Length >= 4 && (stringUtf8Length / self.length != 3);
}

@end
