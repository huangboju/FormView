//
//  XYPHSearchFilterGroupButtonView.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2018/8/16.
//

#import <UIKit/UIKit.h>

@class XYPHSearchFilterGroupButtonView;

@protocol XYPHSearchFilterGroupButtonViewDelegate <NSObject>

- (void)searchFilterGroupButtonViewClearButtonClicked:(XYPHSearchFilterGroupButtonView *)groupButtonView;

- (void)searchFilterGroupButtonViewDoneButtonClicked:(XYPHSearchFilterGroupButtonView *)groupButtonView;

@end

@interface XYPHSearchFilterGroupButtonView : UIView

@property (nonatomic, assign) NSInteger totalCount;

// default 篇笔记
@property (nonatomic, copy) NSString *suffix;

- (void)attachInView:(UIView *)view;

@end
