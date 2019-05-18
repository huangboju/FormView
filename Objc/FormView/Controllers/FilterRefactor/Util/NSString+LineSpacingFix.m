//
//  NSString+LineSpacingFix.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/12.
//

#import "NSString+LineSpacingFix.h"
#import <CoreText/CTFontDescriptor.h>

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
    if (@available(iOS 10.0, *)) {
        [attributesDic setObject:@[[UIFont fontWithName:@"AppleColorEmoji" size:font.pointSize]] forKey:(NSString *)kCTFontCascadeListAttribute];
    }
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
                                if (0xD800 <= high && high <= 0xDBFF) {
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

@end
