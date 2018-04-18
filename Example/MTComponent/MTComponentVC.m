//
//  MTComponentVC.m
//  MTComponent_Example
//
//  Created by Jason Li on 2018/3/15.
//  Copyright © 2018年 rstx_reg@aliyun.com. All rights reserved.
//

#import "MTComponentVC.h"

@import Masonry;
@import MTFramework;

@interface MTComponentVC ()
@property (nonatomic, strong) UILabel *labShowData;

@end

@implementation MTComponentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.labShowData = [[UILabel alloc] initWithFrame:CGRectZero];
    self.labShowData.numberOfLines = 0;
    
    [self.view addSubview:self.labShowData];
    
    __weak typeof(self) weakSelf = self;
    [self.labShowData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.compIndexPath.row % 2 == 0) {
        self.labShowData.backgroundColor = [UIColor redColor];
    } else {
        self.labShowData.backgroundColor = [UIColor blueColor];
    }
    
    self.labShowData.text = [self.compServiceData JSONString];
}

- (CGSize)componentSize {
    CGFloat height = 2 * self.rowHeight;
    if ([self.comp.componentName isEqualToString:@"comp2"]) {
        height = 3 * self.rowHeight;
    }
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), height);
}

@end
