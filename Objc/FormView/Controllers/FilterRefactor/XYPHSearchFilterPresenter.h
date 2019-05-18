//
//  XYPHSearchFilterPresenter.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/12.
//

NS_ASSUME_NONNULL_BEGIN

@protocol XYPHSearchFilterPresenter <NSObject>

@property (nonatomic, copy) NSString *tagId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL selected;

@end

NS_ASSUME_NONNULL_END
