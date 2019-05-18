//
//  View+SafaArea.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/1/21.
//

#import <Masonry/View+MASAdditions.h>


NS_ASSUME_NONNULL_BEGIN

@interface MAS_VIEW (SafeArea)

@property (nonatomic, strong, readonly) MASViewAttribute *mas_safeTop;

@property (nonatomic, strong, readonly) MASViewAttribute *mas_safeBottom;

@end

NS_ASSUME_NONNULL_END
