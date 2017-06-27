//
//  MYAppDelegate+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/5/31.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYAppDelegate.h"

@class MYMainViewController;

@class MYBaseNavigationController;
@class MYMainTabBarViewController;

@interface MYAppDelegate (MYCategory)

@property (nonatomic, strong) MYMainViewController  * mainVC;

@property (nonatomic, strong) MYMainTabBarViewController * tabVC;

- (UIViewController *) myGetMainViewController;


@end
