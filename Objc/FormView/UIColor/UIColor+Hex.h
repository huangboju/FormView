//
//  UIColor+Hex.h
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex) 

+ (UIColor*) colorWithCSS: (NSString*) css;
+ (UIColor*) colorWithHex: (NSUInteger) hex;
+ (UIColor*) colorWithHex: (NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)colorWithR:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue a:(CGFloat)alpha;

- (uint)hex;
- (NSString*)hexString;
- (NSString*)cssString;

@end
