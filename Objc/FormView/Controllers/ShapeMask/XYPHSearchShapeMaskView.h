//
//  XYPHSearchShapeMaskView.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2018/12/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYPHSearchShapeMaskView : UIView

@property (nonatomic, copy) UIColor *maskColor;

- (void)addTransparentRect:(CGRect)rect;

- (void)addTransparentRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;

- (void)addTransparentRoundedRect:(CGRect)rect
                byRoundingCorners:(UIRectCorner)corners
                      cornerRadii:(CGSize)cornerRadii;

- (void)addTransparentOvalRect:(CGRect)rect;

- (void)reset;

@end

NS_ASSUME_NONNULL_END
