//
//  MTCompVM.h
//  MTComponent
//
//  Created by Jason Li on 2018/3/26.
//

#import <Foundation/Foundation.h>
#import "MTCompViewModelProtocol.h"

@import MTBaseObjects;

@interface MTCompVM : MTBaseViewModel<MTCompViewModelProtocol>

@property (nonatomic, strong) NSDictionary *serviceData; // 业务数据

@end
