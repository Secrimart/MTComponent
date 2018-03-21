//
//  UIViewController+MTComponent.m
//  MTComponent
//
//  Created by Jason Li on 2018/3/14.
//

#import "UIViewController+MTComponent.h"
#import <objc/runtime.h>

@import JLFramework;

@implementation UIViewController (MTComponent)
- (MTComponent *)comp {
    return objc_getAssociatedObject(self, @selector(comp));
}

- (void)setComp:(MTComponent *)comp {
    objc_setAssociatedObject(self, @selector(comp), comp, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)compBussData {
    return objc_getAssociatedObject(self, @selector(compBussData));
}

- (void)setCompBussData:(NSDictionary *)compBussData {
    objc_setAssociatedObject(self, @selector(compBussData), compBussData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self componentDidChangedBussData];
}

- (void)componentDidChangedBussData {
    
}

- (NSIndexPath *)compIndexPath {
    return objc_getAssociatedObject(self, @selector(compIndexPath));
}

- (void)setCompIndexPath:(NSIndexPath *)compIndexPath {
    objc_setAssociatedObject(self, @selector(compIndexPath), compIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

- (void)setupComponentBussData:(NSDictionary *)dictData {
    self.compBussData = dictData;
}

@end
