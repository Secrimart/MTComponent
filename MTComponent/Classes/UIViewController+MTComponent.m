//
//  UIViewController+MTComponent.m
//  MTComponent
//
//  Created by Jason Li on 2018/3/14.
//

#import "UIViewController+MTComponent.h"
#import <objc/runtime.h>

@import MTFramework;

@implementation UIViewController (MTComponent)
- (MTComponent *)comp {
    return objc_getAssociatedObject(self, @selector(comp));
}

- (void)setComp:(MTComponent *)comp {
    objc_setAssociatedObject(self, @selector(comp), comp, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)compServiceData {
    return objc_getAssociatedObject(self, @selector(compServiceData));
}

- (void)setCompServiceData:(NSDictionary *)compServiceData {
    objc_setAssociatedObject(self, @selector(compServiceData), compServiceData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self componentDidChangedServiceData];
}

- (void)componentDidChangedServiceData {
    
}

- (NSIndexPath *)compIndexPath {
    return objc_getAssociatedObject(self, @selector(compIndexPath));
}

- (void)setCompIndexPath:(NSIndexPath *)compIndexPath {
    objc_setAssociatedObject(self, @selector(compIndexPath), compIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController<MTComponentProtocol> *)componentContainerViewController {
    return objc_getAssociatedObject(self, @selector(componentContainerViewController));
}

- (void)setComponentContainerViewController:(UIViewController<MTComponentProtocol> *)componentContainerViewController {
    objc_setAssociatedObject(self, @selector(componentContainerViewController), componentContainerViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)toReloadComponent {
    
}

- (CGSize)componentSize {
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), self.rowHeight);
}

- (void)setupComponent:(MTComponent *)comp {
    self.comp = comp;
}

- (void)setupComponentIndexPath:(NSIndexPath *)indexPath {
    self.compIndexPath = indexPath;
}

- (void)setupComponentServiceData:(NSDictionary *)dictData {
    self.compServiceData = dictData;
}

@end
