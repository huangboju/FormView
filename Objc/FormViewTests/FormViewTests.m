//
//  FormViewTests.m
//  FormViewTests
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface FormViewTests : XCTestCase

@end

@implementation FormViewTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testIsEmptyId {
    NSString *text = @"0";
    NSAssert([self isEmptyId:text], @"");
}

- (BOOL)isEmptyId:(NSString *)idStr {
    return !idStr || !idStr.length || [idStr isEqualToString:@"0"];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
