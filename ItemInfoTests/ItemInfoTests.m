//
//  ItemInfoTests.m
//  ItemInfoTests
//
//  Created by Juhi Gautam on 07/03/18.
//  Copyright © 2018 Juhi Gautam. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ItemInfoTests : XCTestCase

@end

@implementation ItemInfoTests
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}
- (void)testJsonFetch
{
    NSURL *url = [[NSURL alloc] initWithString:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"];
    NSError *error;
    NSString *string = [NSString stringWithContentsOfURL:url encoding:NSISOLatin1StringEncoding error:&error];
    
    NSData *resData = [string dataUsingEncoding:NSUTF8StringEncoding];
    XCTAssertNotNil(resData, "data should not be nil");
}
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
