//
//  XYPHSFGoodsDataSource.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2018/10/22.
//


#import "XYPHSFGoodsDataSource.h"

@interface XYPHSFGoodsDataSource()

@property (nonatomic, assign) BOOL isLoading;

@end

@implementation XYPHSFGoodsDataSource

- (void)requsetFilters:(SFGoodsFilterRequestCompletion)completion {
    if (self.isLoading) { return; }
    self.isLoading = YES;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.isLoading = NO;
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"filter" ofType:@"json"];
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if (completion) {
                completion([XYPHSearchGoodsFilter yy_modelWithJSON:json[@"data"]]);
            }
        });
    });
}

@end
