//
//  XYPHSRSortTabViewDelegate.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/28.
//

NS_ASSUME_NONNULL_BEGIN

@protocol XYPHSRSortTabViewDelegate <NSObject>

- (void)sortTabCellFilterButtonClicked:(UIView *)sortTabView;

- (void)sortTabCellSortButtonClicked:(UIView *)sortTabView;

@end

NS_ASSUME_NONNULL_END
