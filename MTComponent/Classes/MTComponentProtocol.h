//
//  MTComponentProtocol.h
//  MTComponent
//
//  Created by Jason Li on 2018/3/13.
//

#import <Foundation/Foundation.h>

@class MTComponent;
@protocol MTComponentDataSource <NSObject>

@required
/**
 实现该代理方法为组件容器提供组件配置数据

 @return MTComponent对象数组
 */
- (NSArray<MTComponent *> *)componentLocalConfigData;

@optional

/**
 通过该方法为组件容器通过组件的业务数据，不存在业务数据的组件判定为无效组件，组件不加载。如果不为组件容器添加组件业务数据（即，不实现该代理方法），组件容器将以组件配置数据为基准进行组件加载

 @return NSDictionary对象数组
 */
- (NSArray<NSDictionary *> *)componentServiceData;

@end


@protocol MTComponentProtocol <NSObject>

@required
/**
 组件实现该方法刷新自身
 */
- (void)toReloadComponent;

/**
 组件实现该协议方式，指定自身在容器中的大小
 
 @return 组件Size
 */
- (CGSize)componentSize;

@optional

/**
 组件实现该协议方法，存储组件在容器中的位置

 @param indexPath 组件在容器中的位置
 */
- (void)setupComponentIndexPath:(NSIndexPath *)indexPath;

/**
 组件实现该协议方法，存储组件自身的配置数据

 @param comp MTComponent对象
 */
- (void)setupComponent:(MTComponent *)comp;

/**
 组件实现该协议方法，存储组件业务数据

 @param dictData 组件业务数据
 */
- (void)setupComponentServiceData:(NSDictionary *)dictData;


@end
