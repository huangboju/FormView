//
//  XYPHSearchShapeImageView.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2018/12/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYShapeImageView : UIImageView

@property (nonatomic, copy) UIColor *maskColor;

@property (nonatomic, assign) CGFloat cornerRadius;

- (void)addTransparentRoundedRect:(CGRect)rect
                byRoundingCorners:(UIRectCorner)corners
                      cornerRadii:(CGSize)cornerRadii;

@end

NS_ASSUME_NONNULL_END
