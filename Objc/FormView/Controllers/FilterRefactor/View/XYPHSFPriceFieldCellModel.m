//
//  XYPHSFPriceFieldCellModel.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/12.
//

#import "XYPHSFPriceFieldCellModel.h"
#import "XYPHSearchGoodsRecommendPriceRange.h"
#import "XYPHSearchUtil.h"

@interface XYPHSFPriceFieldCellModel()

@property (nonatomic, strong) NSArray<XYPHSearchGoodsRecommendPriceRange *> *model;

@end


@implementation XYPHSFPriceFieldCellModel

+ (instancetype)modelWithModel:(NSArray<XYPHSearchGoodsRecommendPriceRange *> *)model {
    XYPHSFPriceFieldCellModel *cellModel = XYPHSFPriceFieldCellModel.new;
    cellModel.model = model;
    return cellModel;
}

- (CGSize)cellSize {
    if (self.needShowRecommendPrice) {
        return CGSizeMake(XYPHSearchUtil.contentWidth - 30, 90);
    }
    return CGSizeMake(XYPHSearchUtil.contentWidth - 30, 36);
}

- (BOOL)needShowRecommendPrice {
    return self.model.count > 0;
}

@end
