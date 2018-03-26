//
//  MTCompVM.m
//  MTComponent
//
//  Created by Jason Li on 2018/3/26.
//

#import "MTCompVM.h"

@implementation MTCompVM

- (void)toReloadDataSourceWithServiceData:(NSDictionary *)serviceData {
    self.serviceData = serviceData;
    self.dataSource = nil;
    [self toReloadDataSourceBeforeRequest:nil onFinished:nil onFailed:nil];
}

- (void)toReloadDataSourceBeforeRequest:(VoidBlock)before onFinished:(DataSourceStatusBlock)finished onFailed:(VoidBlock)failed {
    if (before) before();
    
    if (self.serviceData.count == 0) {
        if (failed) failed();
        return;
    }
    
    [self toConstructionDataSource];
    
    if (finished) finished(DataSourceStatusNormal);
}

- (void)toConstructionDataSource {
    
}

@end
