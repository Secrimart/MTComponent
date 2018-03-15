//
//  MTComponentTest.m
//  MTComponent_Tests
//
//  Created by Jason Li on 2018/3/14.
//  Copyright © 2018年 rstx_reg@aliyun.com. All rights reserved.
//

#import <XCTest/XCTest.h>

@import MTComponent;

@interface MTComponentTest : XCTestCase

@property (nonatomic, strong) NSMutableDictionary *dictDataSource; // 字典数据源

@end

@implementation MTComponentTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.dictDataSource = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [self.dictDataSource setValue:@(YES) forKey:@"enableComponent"];
    [self.dictDataSource setValue:@"top" forKey:@"dataKey"];
    [self.dictDataSource setValue:@"controller" forKey:@"componentName"];
    [self.dictDataSource setValue:@"" forKey:@"componentVCName"];
    [self.dictDataSource setValue:@(0) forKey:@"style"];
    [self.dictDataSource setValue:@(0) forKey:@"section"];
    [self.dictDataSource setValue:@(2) forKey:@"row"];
    
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testinitWithDict {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    MTComponent *comp = [MTComponent initWithDict:self.dictDataSource];
    
    XCTAssert(comp.enableComponent);
    XCTAssertEqual(comp.dataKey, @"top");
    XCTAssertEqual(comp.componentName, @"controller");
    XCTAssertEqual(comp.style, 0);
    XCTAssertEqual(comp.section, 0);
    XCTAssertEqual(comp.row, 2);
}

- (void)testInstanceComponentVC {
    MTComponent *comp = [MTComponent initWithDict:self.dictDataSource];
    
    UIViewController *vc = [comp instanceComponentVC];
    if (comp.componentVCName.length > 0) {
        XCTAssert(vc);
        XCTAssertEqual([vc class], [UITableViewController class]);
    } else {
        XCTAssert(!vc);
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
