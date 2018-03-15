//
//  UIViewController+MTComponent.h
//  MTComponent
//
//  Created by Jason Li on 2018/3/14.
//

#import <UIKit/UIKit.h>
#import "MTComponentProtocol.h"
#import "MTComponent.h"

@interface UIViewController (MTComponent)<MTComponentProtocol>
@property (nonatomic, strong) MTComponent *comp; // 组件配置数据

@property (nonatomic, strong) NSDictionary *compBussData; // 组件业务数据

@property (nonatomic, strong) NSIndexPath *compIndexPath; // 组件在容器中的位置

@end
