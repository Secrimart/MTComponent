//
//  MTTComContainerVM.h
//  MTComponent
//
//  Created by Jason Li on 2018/3/13.
//

@import MTBaseObjects;

@class MTComponent;
@interface MTTComContainerVM : MTBaseViewModel

@property (nonatomic, strong) NSArray<MTComponent *> *arrayComponents; // 组件数据 组数

@property (nonatomic, strong) NSArray *arrayServiceData; // 存储组件的业务数据

/**
 通过组件名称获取组件在 TableView容器中的 indexPath位置

 @param name 组件名称
 @return 组件位置
 */
- (NSIndexPath *)indexPathOfComponentWithName:(NSString *)name;

/**
 通过组件位置获取组件配置数据对象

 @param indexPath 组件位置
 @return 组件配置数据对象
 */
- (MTComponent *)compontAtIndexPath:(NSIndexPath *)indexPath;

/**
 通过组件位置获取组件的业务数据

 @param indexPath 组件位置
 @return 组件业务数据，可能为nil
 */
- (NSDictionary *)componentServiceDataAtIndexPath:(NSIndexPath *)indexPath;

@end
