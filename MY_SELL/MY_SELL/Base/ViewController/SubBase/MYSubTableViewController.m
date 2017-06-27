//
//  MYSubTableViewController.m
//  MY_SELL
//
//  Created by yanma on 2017/6/15.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYSubTableViewController.h"

@interface MYSubTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) CGRect rectFrame;

- (void) myDefaultSettings;

@end

@implementation MYSubTableViewController

/*
 property声明方法： 头文件中声明setter和getter方法
 synthesize 定义方法： m文件中实现getter和setter方法
 */
@synthesize arrayData = _arrayData; //在.m文件中同时实现getter和setter时候需要写

- (instancetype)initWithTableViewFrame:(CGRect)rectFrame {
    if (self = [super init]) {
        _rectFrame = rectFrame;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)myDefaultSettings {
    
}

- (void)myAddTalbeViewPlain {
    [self.view addSubview:self.tableViewPlain];
    self.isOffSetNavigate = YES;
}


@end














