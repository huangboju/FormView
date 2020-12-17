//
//  NetworkServicer.m
//  FormView
//
//  Created by jourhuang on 2020/12/17.
//  Copyright © 2020 黄伯驹. All rights reserved.
//

#import <Cronet/Cronet.h>
#import <AFNetworking/AFNetworking.h>

#import "NetworkServicer.h"

@implementation NetworkServicer

+ (void)initCronet {
    [Cronet setHttp2Enabled:YES];
    [Cronet setQuicEnabled:YES];
    [Cronet setBrotliEnabled:YES];
    
    BOOL flag = [Cronet addQuicHint:@"www.google.com" port:443 altPort:443];
    
    [Cronet start];
    [Cronet registerHttpProtocolHandler];
    [Cronet startNetLogToFile:@"netlog.json" logBytes:NO];
}

+ (void)startNetLogToFile {
    [Cronet startNetLogToFile:@"netlog.json" logBytes:NO];
}

+ (void)stopNetLog {
    [Cronet stopNetLog];
}

+ (void)fetchImages {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = AFImageResponseSerializer.serializer;
    
    for (NSString *link in self.links) {
        [self fetchImageWithManager:manager imageLink:link];
    }
}

+ (void)fetchImageWithManager:(AFURLSessionManager *)manager imageLink:(NSString *)imageLink {
    NSURL *URL = [NSURL URLWithString:imageLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//        } else {
//            NSLog(@"%@ %@", response, responseObject);
//        }
    }];
    
    [manager setTaskDidFinishCollectingMetricsBlock:^(NSURLSession * _Nonnull session, NSURLSessionTask * _Nonnull task, NSURLSessionTaskMetrics * _Nullable metrics) {
        [self logMetrics:metrics];
    }];
    
    [dataTask resume];
}

+ (void)logMetrics:(NSURLSessionTaskMetrics *)metrics {
    NSURLSessionTaskTransactionMetrics *metric = [metrics.transactionMetrics lastObject];
    //请求开始时间
    NSString *startRequestTime = [NSString stringWithFormat:@"%.f", metric.fetchStartDate.timeIntervalSince1970 * 1000];
    NSLog(@"startRequestTime = %@ms", startRequestTime);
    //域名解析时长
    NSString *dnsDuration = [NSString stringWithFormat:@"%.f", [metric.domainLookupEndDate timeIntervalSinceDate:metric.domainLookupStartDate] * 1000];
    NSLog(@"dnsDuration = %@ms", dnsDuration);
    //连接建立时长
    NSString *connectDuration = [NSString stringWithFormat:@"%.f", [metric.connectEndDate timeIntervalSinceDate:metric.connectStartDate] * 1000];
    NSLog(@"connectDuration = %@ms", connectDuration);
    //https ssl验证时长
    NSString *sslDuration = [NSString stringWithFormat:@"%.f", [metric.secureConnectionEndDate timeIntervalSinceDate:metric.secureConnectionStartDate] * 1000];
    NSLog(@"sslDuration = %@ms", sslDuration);
    //从客户端发送HTTP请求到服务器所耗费时长
    NSString *sendDuration = [NSString stringWithFormat:@"%.f", [metric.requestEndDate timeIntervalSinceDate:metric.requestStartDate] * 1000];
    NSLog(@"sendDuration = %@ms", sendDuration);
    //响应报文首字节到达时长
    NSString *waitDuration = [NSString stringWithFormat:@"%.f", [metric.responseStartDate timeIntervalSinceDate:metric.requestEndDate] * 1000];
    NSLog(@"waitDuration = %@ms", waitDuration);
    //客户端从开始接收数据到接收完所有数据时长
    NSString *receiveDuration = [NSString stringWithFormat:@"%.f", [metric.responseEndDate timeIntervalSinceDate:metric.responseStartDate] * 1000];
    NSLog(@"receiveDuration = %@ms", receiveDuration);
    //请求结束时间
    NSString *endResponseTime = [NSString stringWithFormat:@"%.f", [metric.responseEndDate timeIntervalSince1970] * 1000];
    NSLog(@"endResponseTime = %@ms", endResponseTime);
    //网络请求总时长
    NSString *totalDuration = [NSString stringWithFormat:@"%.f", [metrics.taskInterval duration] * 1000];
    NSLog(@"totalDuration = %@ms", totalDuration);
}

+ (NSArray<NSString *> *)links {
    NSArray *imageLinks = @[
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8oeUYYsI1bna0kPb_B0bVyQH1ZKdusZyfTRoNwKcMOB8ffgAyBg",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVZpiZClGnYHJKZJ5vZYNJAuAryhSKzAcXE9hFj6e5-sSo0W03",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMaL_bwIbirU4Yx3KneeiqTPeVyKztRfKJROVYK4LttLfDb3wYnw",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2jbMPqmNkAJX1Drpe31jPiYnUyHcaE6Lu28Xwz0bsbns_C7oLoQ",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTj3XZ8aB-fmT80WsFnKFo0xk9Mc_0pqs02CAd5Ux29ki7FFYfqwQ",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6o9gQUhGxxKKuQBleye_ibGBuV-mo1duupUN8Zn3XC34h0Ugd7A",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSERuXJX0ANc3UfC40nnONxSNvCv3EKRtYC0G7wKjbvpNzh_EBDvw",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQp7LiLz-xPxjN3jPqS0qQEgQHQ-10aEJwyQKb9n31dx4Ywg_e8",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTv73N30PMip5sGzboasjF0F4WdTqjvupfP_Uiv8KTLNFC3XG1E",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgG9RqlI1mu9wTzYwhuyf608zbQFdQOc5aPQH8IXVbzpkJSA7c",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSB8F3L36wOsGEU7ua3_uef0KucLgV96n4HK7UFKunC211laFWSkw",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4MSNr9P29sqLb80wUNPW6PoDiSqp0Dwth9e-JX3lgmeqbTLI9SQ",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb8fiuVUaHEoLMzJjXEHlYUkjLyyP-akpg0IIOQXrQsSuA0iLYcA",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStpKkrvGte8EgZ6Izosi3SOkLfmSBcu60-PuvA3_A3eUMXrMU1",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBH8NzPx_9GzIThDPjkiBRN4OcCtfBclueMYgb2bTNzeY4KHgjDA",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUljZ-_Lj1MJybD_hlcZ3EX17U-FhB10eG3S74h0Ide3zB86FG1A",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhnYvffH6b9n4JUIUQBbXJOqrhIYWe0fyOGCyynzAaz2uxdoIbA",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3e6WHIK-QQf9d9W2gvlnzKnKGVhhOEMfeI1XZpvigm_tEIye59A",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThqVqF2J2cH9jk5sJjvFpwNhv0IWfTM2_O7AXkya69g1N1UXdmZw",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpLO1XwS7OUrAHzQjROQltOCnrst8lGI9s95hBnJaEqXct_L4n",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnj79hGArvvKgp5nkDA1KaH8aH6KB5urIb70PuhQMvM4CUS2kK",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQV5DnL_6GJso3GCKUKKn5G4NzHl5i95reCamjDMDnRHbwhLBw-",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrq_H-f0MFyBR03lu38ghVxSXi-xxHHhhu3DtbePJZ2bp15UP2",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmpLOGOIrATovtsprYJWTPZlS5tAsM9ujafAiETp-Gnb0Obpn0",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQt8qf9dr4js51S1jKDR4eU_sw94nQnWo6wc-Qg4hlOpmzWk8L9",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdg-3vrifQILpxjwuytFnp5xtVPsNhQzqGh5H69yRsJlEGaiUU",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9_JWAFA_Q8kQitjXBwRtNUw5xOSKC_SF_rbZOTriNOMncfrM0Ww",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeJxCCcxTQ3cMftoy1RGZAhK94w-rWF0xfGs61ZIxan4-thgfd",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTh7RRsMGQNm0ZzsNg7f-DTY7hAV9GLcUTRcPbWWwzexYxEgrN-bQ",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRM4Y_m6SbMztUGALvkh5HQ5lMzuxVPY4Bu6YGmsL8PrV9i8_gDIw",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ64fC2teA56dAVqvnWjAoGQswS8wSYrIOrvoPUiQUi-AOXM7SK",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlUiyrmhTXFppqk4aYzqTOU9nimCQsYibukwAV8rstsDkAVQT-mA",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT4JggLLWa1MLkk1mDql-7WQYIrhsqb1_YKCaEd0Vh8efx7aMe",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRC0JN9rbNcndXEW6kGgzy8W7yYjO6FDhsPMCj5kNuPhGeYC-_FsQ",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxd4yBDko4CujLuHVNN-jjjCPnuPApiqNJhDWtkdETE3klTA_QKA",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCMxRpOMIOkadfNytGYg52y0hNN9Jkp2d5r2OAt-jK1X5b-06Tug",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThRpoCD3o11kYsQEB3Te21wjsSpSG71BvDWNOM82_xnb9vpbW5vw",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPZus9W1U2loB-ikZmcyG7xAwtIeEUxGGHkCRrPcEeF_Ou3-5j",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ130whIfPajAnFj117D7oBkljxVcrVL4g9mwBwHmcDFXisFrGs",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjLK_-WuC1KOJU43cLECOt9KcrNfmjbbNAr8xYB65_mTsoRbdH",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6CgVGg5OjY7d64jvpXLs4MsWpykLmzOa_I6ClH2zLvycZ5J2c4g",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvowRG4PoNwRWECBlAMljLxQlxFQPTQExHLkzGR-Kg_n4pos-I3Q",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuyhDNz_ucGzC60IA5a6_mM4pKPYUHYL7sDKid5C-Jkyo0B6Ia",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFwFaTk5hkuQAO89Oy0P8Jk9GSLXpwb9b4vgO6WZ-d3iRNW3KE",
        @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWA3IV-BW1OwolT3DMly8FkQ3VjtObHrBXb2L1srmR1nYt8utm",
    ];
    return imageLinks;
}

@end
