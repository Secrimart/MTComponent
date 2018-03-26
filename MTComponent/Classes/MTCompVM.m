//
//  MTCompVM.m
//  MTComponent
//
//  Created by Jason Li on 2018/3/26.
//

#import "MTCompVM.h"

@implementation MTCompVM

- (void)toReloadDataSourceWithBussData:(NSDictionary *)bussData {
    self.bussData = bussData;
    self.dataSource = nil;
    [self toReloadDataSourceBeforeRequest:nil onFinished:nil onFailed:nil];
}

- (void)toReloadDataSourceBeforeRequest:(VoidBlock)before onFinished:(DataSourceStatusBlock)finished onFailed:(VoidBlock)failed {
    if (before) before();
    
    if (self.bussData.count == 0) {
        if (failed) failed();
        return;
    }
    
    [self toConstructionDataSource];
    
    if (finished) finished(DataSourceStatusNormal);
}

- (void)toConstructionDataSource {
    
}

@end
