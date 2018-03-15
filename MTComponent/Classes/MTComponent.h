//
//  MTComponent.h
//  MTComponent
//
//  Created by Jason Li on 2018/3/13.
//

#import <Foundation/Foundation.h>
#import "MTComponentProtocol.h"

NS_ASSUME_NONNULL_BEGIN
@interface MTComponent : NSObject

+ (instancetype)initWithDict:(NSDictionary *)dict;

@property (nonatomic) BOOL enableComponent; // 是否启用组件

@property (nonatomic, strong) NSString *dataKey; // Json格式组件数据中，该组件的Key值

@property (nonatomic, strong) NSString *componentName; // 组件名称

@property (nonatomic, strong) NSString *componentVCName; // 组件对应的控制器类名

@property (nonatomic) UITableViewStyle style; // TableViewController 初始化时使用的style

@property (nonatomic) NSInteger section; // 布局所在section

@property (nonatomic) NSInteger row; // 布局所在row

- (UIViewController<MTComponentProtocol> *)instanceComponentVC;

@end
NS_ASSUME_NONNULL_END
