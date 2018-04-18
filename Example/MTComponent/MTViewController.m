//
//  MTViewController.m
//  MTComponent
//
//  Created by rstx_reg@aliyun.com on 03/13/2018.
//  Copyright (c) 2018 rstx_reg@aliyun.com. All rights reserved.
//

#import "MTViewController.h"
#import "MTComContainerExampleVC.h"

@import MTComponent;

@interface MTViewController ()<MTComponentDataSource>

@property (nonatomic, strong) NSArray *serviceData;

@end

@implementation MTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.serviceData = @[@{@"top":@[@"1",@"2",@"3"],
                        @"Bottom":@[@"1",@"2",@"3"]}];
}

- (NSArray<MTComponent *> *)componentLocalConfigData {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:@(YES) forKey:@"enableComponent"];
    [dict setValue:@"top" forKey:@"dataKey"];
    [dict setValue:@"comp0" forKey:@"componentName"];
    [dict setValue:@"MTComponentVC" forKey:@"componentVCName"];
    [dict setValue:@(0) forKey:@"style"];
    [dict setValue:@(0) forKey:@"section"];
    [dict setValue:@(0) forKey:@"row"];
    
    MTComponent *comp0 = [MTComponent initWithDict:dict];
    
    [dict setValue:@"Middle" forKey:@"dataKey"];
    [dict setValue:@"comp1" forKey:@"componentName"];
    [dict setValue:@(2) forKey:@"row"];
    MTComponent *comp1 = [MTComponent initWithDict:dict];
    
    [dict setValue:@"Bottom" forKey:@"dataKey"];
    [dict setValue:@"comp2" forKey:@"componentName"];
    [dict setValue:@(1) forKey:@"section"];
    [dict setValue:@(0) forKey:@"row"];
    MTComponent *comp2 = [MTComponent initWithDict:dict];
    
    return @[comp0,comp1,comp2];
}

- (NSArray<NSDictionary *> *)componentServiceData {
    return self.serviceData;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ((MTComContainerExampleVC *)segue.destinationViewController).dataSource = self;
    if ([segue.identifier isEqualToString:@"NoServiceData"]) {
        self.serviceData = nil;
    }
}

@end
