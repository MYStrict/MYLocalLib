//
//  MYAppDelegate+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/5/31.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYAppDelegate+MYCategory.h"

#import "MYMainTabBarViewController.h"
#import "MYMainNavigationController.h"
//#import "MYHomeViewController.h"
#import "MYMainViewController.h"

#import <objc/runtime.h>

@implementation MYAppDelegate (MYCategory)

- (UIViewController *)myGetMainViewController {
//    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if (self.tabVC) {
        return self.tabVC;
    }
    self.tabVC = [[MYMainTabBarViewController alloc] init];
    self.tabVC.viewControllers = @[self.mainVC];
    self.tabVC.selectedIndex = 1;
    return self.tabVC;
    
}

/*
 objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
 id object                     :表示关联者，是一个对象，变量名理所当然也是object
 const void *key               :获取被关联者的索引key
 id value                      :被关联者，这里是一个block
 objc_AssociationPolicy policy : 关联时采用的协议，有assign，retain，copy等协议，一般使用OBJC_ASSOCIATION_RETAIN_NONATOMIC
 */
#pragma mark - Setter
//- (void)setHomeVC:(MYHomeViewController *)HomeVC {
//    objc_setAssociatedObject(self, @selector(HomeVC), HomeVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
- (void)setMainVC:(MYMainViewController *)mainVC {
    objc_setAssociatedObject(self, @selector(mainVC), mainVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setTabVC:(MYMainTabBarViewController *)tabVC {
    objc_setAssociatedObject(self, @selector(tabVC), tabVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//_cmd在Objective-C的方法中表示当前方法的selector，正如同self表示当前方法调用的对象实例。

#pragma mark - Getter
- (MYMainViewController *)mainVC {
    //通过key获取被关联对象
    /*
        用法二：_cmd是在编译的时候就已经确定的值，可以直接使用，由于objc_getAssociatedObject 和 objc_setAssociatedObject 第二个参数需要传入一个属性的键名，是 const void * 类型的，而使用_cmd 可以直接使用该@selector的名称，即homeVC，并且能保证名称不重复
     */
    return objc_getAssociatedObject(self, _cmd);
}

- (MYMainTabBarViewController *)tabVC {
    return objc_getAssociatedObject(self, _cmd);
}


@end











