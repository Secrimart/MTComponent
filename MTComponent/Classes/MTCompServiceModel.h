//
//  MTCompServiceModel.h
//  MTComponent
//
//  Created by Jason Li on 2018/3/26.
//

#import <Foundation/Foundation.h>
#import "MTComponentProtocol.h"

@import MTBaseObjects;
@interface MTCompServiceModel : MTBaseModel

+ (instancetype)initWithDict:(NSDictionary *)dict;

@property (nonatomic) BOOL isNativeLanding; // 是否使用原生着陆页 Default No

@property (nonatomic, strong) NSString *landingVCName; // 原生VC对象名称

@property (nonatomic) UITableViewStyle style; // TableViewController 初始化时使用的style

@property (nonatomic, strong) NSString *landingURL; // 页面详情地址

/**
 实例化着陆页试图控制器
 
 @return 原生VC对象
 */
- (UIViewController<MTComponentProtocol> *)instanceLandingVC;

/**
 将着陆页地址转换为NSURL
 
 @return 着陆页地址链接
 */
- (NSURL *)pageLandingURL;

/**
 将着陆页地址转换为 Request请求对象
 
 @return 请求对象
 */
- (NSURLRequest *)requestPageLandingURl;

@end
