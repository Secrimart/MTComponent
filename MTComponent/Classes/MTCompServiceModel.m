//
//  MTCompServiceModel.m
//  MTComponent
//
//  Created by Jason Li on 2018/3/26.
//

#import "MTCompServiceModel.h"

@import MJExtension;

@implementation MTCompServiceModel

+ (instancetype)initWithDict:(NSDictionary *)dict {
    return [MTCompServiceModel mj_objectWithKeyValues:dict];
}

- (NSURL *)pageLandingURL {
    if (self.landingURL.length == 0) return nil;
    return [NSURL URLWithString:self.landingURL];
}

- (NSURLRequest *)requestPageLandingURl {
    if (![self pageLandingURL]) return nil;
    return [NSURLRequest requestWithURL:[self pageLandingURL]];
}

- (UIViewController<MTComponentProtocol> *)instanceLandingVC {
    if (self.landingVCName.length == 0) return nil;
    
    id comp = [[NSClassFromString(self.landingVCName) alloc] init];
    if ([comp isKindOfClass:[UITableViewController class]]) {
        comp = [[NSClassFromString(self.landingVCName) alloc] initWithStyle:self.style];
    }
    
    return comp;
}

@end
