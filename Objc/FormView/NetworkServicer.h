//
//  NetworkServicer.h
//  FormView
//
//  Created by xiAo-Ju on 2020/12/17.
//  Copyright © 2020 黄伯驹. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkServicer : NSObject

+ (void)initCronet;

+ (void)startNetLogToFile;

+ (void)stopNetLog;

+ (void)fetchImages;

+ (void)logMetrics:(NSURLSessionTaskMetrics *)metrics;

@end

NS_ASSUME_NONNULL_END
