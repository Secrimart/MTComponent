//
//  MTTComContainerVMTest.m
//  MTComponent_Tests
//
//  Created by Jason Li on 2018/3/14.
//  Copyright © 2018年 rstx_reg@aliyun.com. All rights reserved.
//

#import <XCTest/XCTest.h>

@import MTComponent;

@interface MTTComContainerVMTest : XCTestCase
@property (nonatomic, strong) NSMutableArray *components; // 组件对象数组
@property (nonatomic, strong) NSArray *data; // 组件对象数组

@end

@implementation MTTComContainerVMTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.components = [NSMutableArray arrayWithCapacity:0];
    
    for (NSInteger section = 0; section <= 6; section++) {
        NSInteger maxRow = 6 - section;
        for (NSInteger row = 0; row <= maxRow; row ++) {
            NSMutableDictionary *dictDataSource = [NSMutableDictionary dictionaryWithCapacity:0];
            
            BOOL enableComp = YES;
            if (row == 4) {
                enableComp = NO;
            }
            [dictDataSource setValue:@(enableComp) forKey:@"enableComponent"];
            [dictDataSource setValue:[NSString stringWithFormat:@"top%ld%ld",(long)section,(long)row] forKey:@"dataKey"];
            [dictDataSource setValue:[NSString stringWithFormat:@"name%ld%ld",(long)section,(long)row] forKey:@"componentName"];
            [dictDataSource setValue:@"UIViewController" forKey:@"componentVCName"];
            [dictDataSource setValue:@(0) forKey:@"style"];
            [dictDataSource setValue:@(section) forKey:@"section"];
            [dictDataSource setValue:@(row) forKey:@"row"];
            
            MTComponent *comp = [MTComponent initWithDict:dictDataSource];
            [self.components addObject:comp];
        }
    }
    
//    self.data = @[@{@"top00":@[@"1",@"2",@"3"]},
//                  @{@"top04":@[@"1",@"2",@"3"]},
//                  @{@"top60":@[@"1",@"2",@"3"]}];
    
    self.data = @[@{@"top00":@[@"1",@"2",@"3"],
                    @"top04":@[@"1",@"2",@"3"],
                    @"top60":@[@"1",@"2",@"3"]
                    }];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testtoReloadDataSource_NoServiceData {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    MTTComContainerVM *vm = [[MTTComContainerVM alloc] init];
    vm.arrayComponents = self.components;
    
    [vm toReloadDataSourceBeforeRequest:nil onFinished:nil onFailed:nil];
    
    XCTAssertEqual(vm.dataSource.count, 7);
    XCTAssertEqual(((NSArray *)vm.dataSource[0]).count, 6);
    XCTAssertEqual(((NSArray *)vm.dataSource.lastObject).count, 1);
    XCTAssertEqual(((MTComponent *)vm.dataSource[0][0]).row, 0);
    XCTAssertEqual(((MTComponent *)vm.dataSource[0][5]).row, 6);
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"enableComponent = %@",@(YES)];
    NSInteger validComp = [self.components filteredArrayUsingPredicate:pre].count;
    
    NSInteger validCount = 0;
    for (NSArray *rowArray in vm.dataSource) {
        validCount += rowArray.count;
    }
    XCTAssertEqual(validComp, validCount);
}

- (void)testToReloadDataSource_ServiceData {
    MTTComContainerVM *vm = [[MTTComContainerVM alloc] init];
    vm.arrayComponents = self.components;
    vm.arrayServiceData = self.data;
    
    [vm toReloadDataSourceBeforeRequest:nil onFinished:nil onFailed:nil];
    
    XCTAssertEqual(vm.dataSource.count, 2);
    XCTAssertEqual(((NSArray *)vm.dataSource[0]).count, 1);
    XCTAssertEqual(((NSArray *)vm.dataSource.lastObject).count, 1);
    
    NSInteger validCount = 0;
    for (NSArray *rowArray in vm.dataSource) {
        validCount += rowArray.count;
    }
    XCTAssertEqual(2, validCount);
}

- (void)testIndexPathOfComponentWithName {
    MTTComContainerVM *vm = [[MTTComContainerVM alloc] init];
    vm.arrayComponents = self.components;
    
    [vm toReloadDataSourceBeforeRequest:nil onFinished:nil onFailed:nil];
    
    NSIndexPath *index = [vm indexPathOfComponentWithName:@"name00"];
    XCTAssert(index);
    XCTAssertEqual(index.section, 0);
    XCTAssertEqual(index.row, 0);
    index = [vm indexPathOfComponentWithName:@"name15"];
    XCTAssert(index);
    XCTAssertEqual(index.section, 1);
    XCTAssertEqual(index.row, 4);
    index = [vm indexPathOfComponentWithName:@"name32"];
    XCTAssert(index);
    XCTAssertEqual(index.section, 3);
    XCTAssertEqual(index.row, 2);
    index = [vm indexPathOfComponentWithName:@"name60"];
    XCTAssert(index);
    XCTAssertEqual(index.section, 6);
    XCTAssertEqual(index.row, 0);
}

- (void)testCompontAtIndexPath {
    MTTComContainerVM *vm = [[MTTComContainerVM alloc] init];
    vm.arrayComponents = self.components;
    
    [vm toReloadDataSourceBeforeRequest:nil onFinished:nil onFailed:nil];
    
    NSIndexPath *index = [vm indexPathOfComponentWithName:@"name15"];
    
    XCTAssert(index);
    MTComponent *comp = [vm compontAtIndexPath:index];
    XCTAssert(comp);
    XCTAssert([comp.dataKey isEqualToString:@"top15"]);
}

- (void)testComponentServiceDataAtIndexPath {
    MTTComContainerVM *vm = [[MTTComContainerVM alloc] init];
    vm.arrayComponents = self.components;
    vm.arrayServiceData = self.data;
    
    [vm toReloadDataSourceBeforeRequest:nil onFinished:nil onFailed:nil];
    
    NSIndexPath *index = [vm indexPathOfComponentWithName:@"name60"];
    
    XCTAssert(index);
    NSDictionary *dict = [vm componentServiceDataAtIndexPath:index];
    XCTAssert(dict);
    XCTAssert([[dict allKeys].firstObject isEqualToString:@"top60"]);
    XCTAssertEqual(((NSArray *)dict[@"top60"]).count, 3);
    XCTAssert([((NSArray *)dict[@"top60"]).lastObject isEqualToString:@"3"]);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
