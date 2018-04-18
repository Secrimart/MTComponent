//
//  MTTComContainerVC.h
//  MTComponent
//
//  Created by Jason Li on 2018/3/13.
//

#import "MTComponentProtocol.h"

@import MTBaseObjects;
@import MTFramework;

@interface MTTComContainerVC : MTBaseTableViewController<MTComponentProtocol>

@property (nonatomic, weak) id <MTComponentDataSource> dataSource; // 数据源

- (void)toReloadComponentWithComponentName:(NSString *)name;

@end
