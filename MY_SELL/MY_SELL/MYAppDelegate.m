//
//  MYAppDelegate.m
//  MY_SELL
//
//  Created by yanma on 2017/5/31.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYAppDelegate.h"

#import "MYMainViewController.h"
#import "MYLoginViewController.h"

@implementation MYAppDelegate

///应用程序启动入口，只执行一次
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%@", NSHomeDirectory());

    self.window.rootViewController = [[MYLoginViewController alloc] init];
    return YES;
}



#pragma mark - Getter
- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] init];
        [_window makeKeyAndVisible];
        _window.frame = [UIScreen mainScreen].bounds;
        _window.backgroundColor = [UIColor whiteColor];
    }
    return _window;
}

@end
