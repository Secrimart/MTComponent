//
//  MTComponent.m
//  MTComponent
//
//  Created by Jason Li on 2018/3/13.
//

#import "MTComponent.h"

@import MJExtension;

@implementation MTComponent

+ (instancetype)initWithDict:(NSDictionary *)dict {
    return [MTComponent mj_objectWithKeyValues:dict];
}

- (instancetype)instanceComponentVC {
    id comp = [[NSClassFromString(self.componentVCName) alloc] init];
    if ([comp isKindOfClass:[UITableViewController class]]) {
        comp = [[NSClassFromString(self.componentVCName) alloc] initWithStyle:self.style];
    }
    
    return comp;
}

@end
