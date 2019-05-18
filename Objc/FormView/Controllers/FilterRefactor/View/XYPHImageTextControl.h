//
//  XYPHImageTextControl.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XYPHImageTextControlPosition) {
    XYPHImageTextControlPositionTop,                       // imageView在titleLabel上面
    XYPHImageTextControlPositionLeft,                      // imageView在titleLabel左边
    XYPHImageTextControlPositionBottom,                    // imageView在titleLabel下面
    XYPHImageTextControlPositionRight                      // imageView在titleLabel右边
};

@interface XYPHImageTextControl : UIControl

// Default XYPHImageTextControlPositionLeft
@property (nonatomic, assign) XYPHImageTextControlPosition imagePosition;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) BOOL adjustsFontSizeToFitWidth;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIFont *textFont;

@property (nonatomic, assign) CGFloat interval;

@end

NS_ASSUME_NONNULL_END
