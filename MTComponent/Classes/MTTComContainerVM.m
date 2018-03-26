//
//  MTTComContainerVM.m
//  MTComponent
//
//  Created by Jason Li on 2018/3/13.
//

#import "MTTComContainerVM.h"
#import "MTComponent.h"

@implementation MTTComContainerVM

- (void)toReloadDataSourceBeforeRequest:(VoidBlock)before onFinished:(DataSourceStatusBlock)finished onFailed:(VoidBlock)failed {
    if (before) before();
    NSMutableArray *arraySection = [NSMutableArray arrayWithCapacity:0];
    
    // 有效组件数据筛选 && 获取最大section
    NSInteger maxSection = 0;
    NSMutableArray *validComp = [NSMutableArray arrayWithCapacity:0];
    for (MTComponent *comp in self.arrayComponents) {
        // 无效组件不进行处理
        if (!comp.enableComponent) continue;
        
        // 存在业务数据时，没有业务数据节点的组件按照无效组件处理
        BOOL isValidComponent = YES;
        if (self.arrayServiceData) {
            isValidComponent = NO;
            for (NSDictionary *dict in self.arrayServiceData) {
                if ([[dict allKeys] containsObject:comp.dataKey]) {
                    isValidComponent = YES;
                    break;
                }
            }
        }
        if (!isValidComponent) continue;
        
        [validComp addObject:comp];
        
        // 获取有效组件中的最大section
        if (maxSection < comp.section) {
            maxSection = comp.section;
        }
    }
    
    // 按照TableView的两层结构组织数据
    for (NSInteger section = 0; section <= maxSection; section++) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"section = %@ And enableComponent = %@",@(section),@(YES)];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"row" ascending:YES];
        
        NSArray *subArray = [validComp filteredArrayUsingPredicate:predicate];
        if (subArray.count > 0) {
            [arraySection addObject:[NSArray arrayWithArray:[subArray sortedArrayUsingDescriptors:@[sort]]]];
        }
    }
    
    self.dataSource = [NSMutableArray arrayWithArray:arraySection];
    if (self.dataSource.count > 0) {
        if (finished) finished(DataSourceStatusNormal);
    } else {
        if (failed) failed();
    }
    
}

- (NSIndexPath *)indexPathOfComponentWithName:(NSString *)name {
    NSInteger section = 0;
    NSInteger row = 0;
    BOOL isContains = NO;
    
    for (NSArray *rows in self.dataSource) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"componentName = %@",name];
        NSArray *results = [rows filteredArrayUsingPredicate:predicate];
        if (results.count == 0) continue;
        
        isContains = YES;
        section = [self.dataSource indexOfObject:rows];
        row = [rows indexOfObject:results.firstObject];
    }
    
    if (isContains) {
        return [NSIndexPath indexPathForRow:row inSection:section];
    }
    
    return nil;
}

- (MTComponent *)compontAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataSource[indexPath.section][indexPath.row];
}

- (NSDictionary *)componentServiceDataAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.arrayServiceData) return nil;
    
    NSString *dataKey = [self compontAtIndexPath:indexPath].dataKey;
    
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithCapacity:0];
    for (id obj in self.arrayServiceData) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = (NSDictionary *)obj;
            if ([[dict allKeys] containsObject:dataKey]) {
                [resultDict setObject:dict[dataKey] forKey:dataKey];
                break;
            }
        }
    }
    
    if (resultDict.count == 0) return nil;
    
    return resultDict;
}



@end
