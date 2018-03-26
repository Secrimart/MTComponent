//
//  MTCompViewModelProtocol.h
//  MTComponent
//
//  Created by Jason Li on 2018/3/26.
//

@import MTBaseObjects;

@protocol MTCompViewModelProtocol <MTBaseVMProtocol>

@required

- (void)toReloadDataSourceWithServiceData:(NSDictionary *)serviceData;

- (void)toConstructionDataSource;

@end
