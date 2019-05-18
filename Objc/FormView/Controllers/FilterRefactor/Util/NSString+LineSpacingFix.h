//
//  NSString+LineSpacingFix.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (LineSpacingFix)

/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing;

@end
