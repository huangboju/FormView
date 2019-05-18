//
//  XYPHSRGoodsSortTabView.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/23.
//

#import "XYUpdatable.h"

#import "XYNoteCardSizePresenter.h"
#import "XYPHSRSortTabViewDelegate.h"

@class XYPHSRGoodsSortTabView;

NS_ASSUME_NONNULL_BEGIN

@interface XYPHSRGoodsSortTabView : UIView <XYUpdatable>

- (void)refresh;

@end

NS_ASSUME_NONNULL_END
