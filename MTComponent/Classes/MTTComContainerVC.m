//
//  MTTComContainerVC.m
//  MTComponent
//
//  Created by Jason Li on 2018/3/13.
//

#import "MTTComContainerVC.h"

#import "MTTComContainerVM.h"
#import "MTComponent.h"
#import "UIViewController+MTComponent.h"

@interface MTTComContainerVC ()
@property (nonatomic, strong) MTTComContainerVM *containerVM; // 视图模型

@property (nonatomic, strong) NSMutableArray *arrayComponentVCs; // 组件控制器数组

@end

@implementation MTTComContainerVC

- (void)toReloadComponent {
    self.containerVM = nil;
    [self.tableView reloadData];
}

- (CGSize)componentSize {
    return CGSizeZero;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: - Action
- (void)toReloadComponentWithComponentName:(NSString *)name {
    NSIndexPath *indexPath = [self.containerVM indexPathOfComponentWithName:name];
    
    if (indexPath) {
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
    }
    
    // 刷新组件
    UIViewController<MTComponentProtocol> * vc = [self componentViewControllerWithIndexPath:indexPath];
    if ([vc respondsToSelector:@selector(toReloadComponent)]) {
        [vc toReloadComponent];
    }
}

//MARK: - Getter And Setter
- (MTTComContainerVM *)containerVM {
    if (_containerVM) return _containerVM;
    _containerVM = [[MTTComContainerVM alloc] init];
    
    NSAssert([self.dataSource respondsToSelector:@selector(componentLocalConfigData)], @"Please implement -componentLocalConfigData.");
    
    _containerVM.arrayComponents = [self.dataSource componentLocalConfigData];
    
    if ([self.dataSource respondsToSelector:@selector(componentServiceData)]) {
        _containerVM.arrayServiceData = [self.dataSource componentServiceData];
    }
    
    [_containerVM toReloadDataSourceBeforeRequest:nil onFinished:nil onFailed:nil];
    
    return _containerVM;
}

- (NSMutableArray *)arrayComponentVCs {
    if (_arrayComponentVCs) return _arrayComponentVCs;
    _arrayComponentVCs = [NSMutableArray arrayWithCapacity:0];
    
    for (NSArray *array in self.containerVM.dataSource) {
        NSMutableArray *rows = [NSMutableArray arrayWithCapacity:0];
        for (MTComponent *comp in array) {
            UIViewController *compVC = comp.instanceComponentVC;
            compVC.componentContainerViewController = self;
            NSAssert(compVC, @"The %@ Component ViewController instance failed!",comp.componentName);
            [rows addObject:compVC];
            [self addChildController:compVC];
        }
        [_arrayComponentVCs addObject:rows];
    }
    
    return _arrayComponentVCs;
}

- (UIViewController<MTComponentProtocol> *)componentViewControllerWithIndexPath:(NSIndexPath *)indexPath {
    return self.arrayComponentVCs[indexPath.section][indexPath.row];
}

//MARK: Table View Config Cell
- (UITableViewCell *)configComponentCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath rowType:(NSUInteger)rowType {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MTTableComponentContainerIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MTTableComponentContainerIdentifier"];
    }
    // 删除子视图
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    // 添加子视图
    UIViewController<MTComponentProtocol> *viewController = [self componentViewControllerWithIndexPath:indexPath];
    
    if ([viewController respondsToSelector:@selector(setupComponentIndexPath:)]) {
        [viewController setupComponentIndexPath:indexPath];
    }
    
    if ([viewController respondsToSelector:@selector(setupComponentServiceData:)]) {
        [viewController setupComponentServiceData:[self.containerVM componentServiceDataAtIndexPath:indexPath]];
    }
    
    if ([viewController respondsToSelector:@selector(setupComponent:)]) {
        [viewController setupComponent:[self.containerVM compontAtIndexPath:indexPath]];
    }
    
    [cell.contentView addSubview:viewController.view];
    [viewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(cell.contentView);
    }];
    
    return cell;
}

//MARK: Table View DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayComponentVCs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)self.arrayComponentVCs[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self configComponentCell:tableView indexPath:indexPath rowType:0];
}

//MARK: table view Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController<MTComponentProtocol> *viewController = [self componentViewControllerWithIndexPath:indexPath];
    return viewController.componentSize.height;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, CGRectGetWidth(self.view.bounds), 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, CGRectGetWidth(self.view.bounds), 0, 0)];
    }
}

@end
