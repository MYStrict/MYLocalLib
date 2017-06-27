//
//  MYBaseViewController.m
//  MY_SELL
//
//  Created by yanma on 2017/5/31.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYBaseViewController.h"
#import "MYNetTools.h"
#import "MBProgressHUD+MYCategory.h"

#import "MYErrorHolderView.h"
#import "MYScrollToTopView.h"

@interface MYBaseViewController () <UIGestureRecognizerDelegate>

- (void) myDefaultDataSettings;

- (void) mySetDefaultColor;

- (void) myNavigationBackAction: (UIBarButtonItem *) sender;

@property (nonatomic, copy) dispatch_block_t block;
@property (nonatomic, copy) dispatch_block_t blockClick;

- (void) myNavigationCheckAction: (UIBarButtonItem *) sender;
- (void) mynavigationAction: (UIBarButtonItem *) sender;

- (void) myNotificationAction: (NSNotification *) sender;
- (void) myNotificationModeChangeStatusAction:(NSNotification *)sender;

@property (nonatomic, assign, readonly) BOOL isNeedErrorView;
@property (nonatomic, strong) MYErrorHolderView * viewErrorHolder;

- (void) myDetectAndErrorView;

@property (nonatomic, strong) MYScrollToTopView * viewScrollToTop;

@end

@implementation MYBaseViewController

@synthesize enableScrollToTopButton = _enableScrollToTopButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self mySetDefaultColor];
    [self myDefaultDataSettings];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self myDetectAndErrorView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.arrayRequestTask myRemoveAllObject:^BOOL(BOOL isClass, id object) {
        if (isClass) {
            NSURLSessionDataTask * dataTask = (NSURLSessionDataTask *) object;
            if (dataTask.state != NSURLSessionTaskStateCompleted) {
                [dataTask cancel];
            }
        }
        return isClass;
    } withClass:[NSURLSessionDataTask class]];
    
    [self.arrayRequestTask removeAllObjects];
    [self.viewErrorHolder removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)mySetDefaultColor {
    self.navigationController.navigationBar.barTintColor = _MY_MAIN_COLOR_;
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    [dictionary setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dictionary.copy;
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //ios7.0 屏幕左侧 滑动返回，但是自定义返回按钮后会失效
    /*
     解决方法找到两种
     1.重新设置手势的delegate
     self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
     2.当然你也可以自己响应这个手势的事件
     [self.navigationController.interactivePopGestureRecognizer addTarget:self action:@selector(handleGesture:)];
     */
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)myDefaultDataSettings {
    self.integerPageCount = 1;
    self.moniter = [MYNetworkMoniter sharedNetworkMoniter];
    NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(myNotificationAction:)
                               name:_MY_NETWORK_STATUS_CHANGE_NOTIFICATION_
                             object:nil];
//    [notificationCenter addObserver:self
//                           selector:@selector(myNotificationModeChangeStatusAction:)
//                               name:_MY_CHANGE_MODEL_BROAD_CAST_KEY_
//                             object:nil];
//    [notificationCenter addObserver:self
//                           selector:@selector(myChangeNationTrigger:)
//                               name:_MY_NATION_CHANGE_NOTIFICATION_
//                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(myLogoutTrigger:)
                               name:_MY_LOGOUT_KICKED_NOTIFICATION_
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(myReloginTrigger:)
                               name:_MY_USER_RELOGIN_NOTIFICATION_KEY_
                             object:nil];
}


#pragma mark - Public
- (instancetype)initFromNib {
    return [self initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

- (UIBarButtonItem *)mySetNavigationBackArrow {
    UIImage * imageBackArrow = [[[UIImage imageNamed:@"_YM_IMAGE_NAV_BACK_ARROW_"]
                                 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)]
                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * itemBack = [[UIBarButtonItem alloc] initWithImage:imageBackArrow style:UIBarButtonItemStylePlain target:self action:@selector(myNavigationBackAction:)];
    self.navigationItem.leftBarButtonItem = itemBack;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;// 必须实现
    return itemBack;
}

- (UIBarButtonItem *)mySetNavigationCheckMark:(dispatch_block_t)block {
    UIImage * imageCheckMark = [[[UIImage imageNamed:@"_YM_IMAGE_NAV_CHECK_"]
                                 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)]
                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *itemCheck = [[UIBarButtonItem alloc] initWithImage:imageCheckMark
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(myNavigationCheckAction:)];
    self.navigationItem.rightBarButtonItem = itemCheck;
    itemCheck.enabled = !!block;
    _block = [block copy];
    return itemCheck;

}
- (UIBarButtonItem *) mySetNavigationRightItem: (NSString *) stringImageName
                                   withIsRight: (BOOL) isRight
                                withClickBlock: (dispatch_block_t) blockClick {
    UIImage *image = [[[UIImage imageNamed:stringImageName]
                       resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)]
                      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(mynavigationAction:)];
    if (isRight) {
        self.navigationItem.rightBarButtonItem = item;
    } else self.navigationItem.leftBarButtonItem = item;
    _blockClick = [blockClick copy];
    return item ;
}

- (void)myDetectAndErrorView {
    if (self.isNeedErrorView) {
        NSInteger integerKey = [[[NSUserDefaults standardUserDefaults] valueForKey:_MY_NETWORK_STATUS_KEY_NEW_] integerValue];
        if (integerKey <= 0) {
            self.viewErrorHolder.typeError = MYErrorViewTypeNetworkFail;
            if (self.navigationController) {
                [self.navigationController.view insertSubview:self.viewErrorHolder atIndex:1];
            }
        }
    }
}

- (void)myNavigationBackAction:(UIBarButtonItem *)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if (self.presentationController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)myNavigationCheckAction:(UIBarButtonItem *)sender {
    myWeakSelf;
    _MY_Safe_UI_Block(_block, ^{
        pSelf.block();
    });
}

- (void)mynavigationAction:(UIBarButtonItem *)sender {
    myWeakSelf;
    _MY_Safe_UI_Block(self.blockClick, ^{
        pSelf.blockClick();
    });
}

- (void) myAddErrorNoDataView {
    if (self.isNeedErrorView) {
        self.viewErrorHolder.typeError = MYErrorViewTypeNoData;
        if (self.navigationController) {
            [self.navigationController.view insertSubview:self.viewErrorHolder
                                                  atIndex:1]; // Above transition view
        }
    }
}

- (void) myRemoveErrorDataView {
    if (self.viewErrorHolder.superview) {
        [self.viewErrorHolder removeFromSuperview];
        self.viewErrorHolder = nil;
    }
}

- (void) myRemoveNetworkFailView {
    if (self.viewErrorHolder.superview && (self.viewErrorHolder.typeError == MYErrorViewTypeNetworkFail)) {
        [self.viewErrorHolder removeFromSuperview];
        self.viewErrorHolder = nil;
    }
}

- (void) myNotificationAction: (NSNotification *) sender {
    NSDictionary * dictionary = sender.userInfo;
    NSInteger integerStatusNew = [dictionary[_MY_NETWORK_STATUS_KEY_NEW_] integerValue];
    NSInteger integerStatusOld = [dictionary[_MY_NETWORK_STATUS_KEY_OLD_] integerValue];
    if (integerStatusNew > 0 && integerStatusOld < 0) {
        switch (integerStatusNew) {
            case -1:{
                
            } break;
            case 0:{
                [MBProgressHUD myShowMessage:myLocalize(@"no_networking", @"当前无网络连接")];
            } break;
            case 1: {
            
            } break;
            case 2: {
            
            } break;
            case 3: {
            
            } break;
            case 4: {
                [MBProgressHUD myShowMessage:myLocalize(@"_MY_HINT_USER_WEAK_CURRENT_NETWORK_PATIENT_", @"当前网络较弱，请耐心等待")];
            } break;
            case 5: {
            
            } break;
            default:
                break;
        }
        [self myNetworkTrigger:_integerPageCount];
    }
}

- (void) myNotificationModeChangeStatusAction:(NSNotification *)sender {

}

- (void) myChangeNationTrigger:(NSNotification *)sender {

}

- (void)myLogoutTrigger:(NSNotification *)sender {

}

- (void) myReloginTrigger: (NSNotification *) sender {

}

- (void)myNetworkTrigger:(NSInteger)integerStatus {

}

- (void)myAddSubView:(UIView *(^)())blockAdd {
    myWeakSelf;
    _MY_Safe_UI_Block(blockAdd, ^{
        [pSelf.view addSubview:blockAdd()];
    });
}

- (void)myBackAction {
    [self myNavigationBackAction:nil];
}

#pragma mark - Getter
- (NSMutableArray *)arrayRequestTask {
    if (_arrayRequestTask) return _arrayRequestTask;
    _arrayRequestTask = [NSMutableArray array];
    return _arrayRequestTask;
}
- (BOOL)isNeedErrorView {
    BOOL isNeed = !([self isKindOfClass:NSClassFromString(@"MYMainViewController")] ||
                    [self isKindOfClass:NSClassFromString(@"MYDynamicViewController")] ||
                    [self isKindOfClass:NSClassFromString(@"UserCenterViewController")] ||
                    [self isKindOfClass:NSClassFromString(@"MYShopViewController")] ||
                    [self isKindOfClass:NSClassFromString(@"MYLoginViewController")] ||
                    [self isKindOfClass:NSClassFromString(@"MYSplashViewController")] ||
                    [self isKindOfClass:NSClassFromString(@"MYInviteCodeViewController")]) ;
    
    BOOL isHadErrorView = false;
    for (UIView *tempView in self.navigationController.view.subviews)
        if ([tempView isKindOfClass:[MYErrorHolderView class]])
            isHadErrorView = YES;
    
    return isNeed && !isHadErrorView;
}

- (MYErrorHolderView *)viewErrorHolder {
    if (_viewErrorHolder) return _viewErrorHolder;
    _viewErrorHolder = [[MYErrorHolderView alloc] initWithErrorType:MYErrorViewTypeNone];
    return _viewErrorHolder;
}

#pragma mark - Scroll To Top
- (MYScrollToTopView *)viewScrollToTop {
    if (_viewScrollToTop) return _viewScrollToTop;
    myWeakSelf;
    _viewScrollToTop = [[MYScrollToTopView alloc] initWithBounds:self.view.bounds
                                                    withPosition:self.hidesBottomBarWhenPushed
                                                    withSubViews:^UIView *{
                                                        return pSelf.view;
                                                    }];
    _viewScrollToTop.floatOffSet = .0f;
    _viewScrollToTop.alpha = .0f;
    return _viewScrollToTop;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self myScrollToTop:scrollView];
}

- (void) myScrollToTop : (UIScrollView *) scrollView {
    if (self.isEnableScrollToTopButton) {
        CGFloat floatOffset = self.view.height > scrollView.contentOffset.y ?
        scrollView.contentOffset.y : self.view.height;
        self.viewScrollToTop.alpha = floatOffset / self.view.height ;
    }
}

- (void)setEnableScrollToTopButton:(BOOL)enableScrollToTopButton {
    _enableScrollToTopButton = enableScrollToTopButton;
    self.viewScrollToTop.hidden = !enableScrollToTopButton;
    myWeakSelf;
    [self myAddSubView:^UIView *{
        return pSelf.viewScrollToTop;
    }];
}

- (void)setFloatCustomScrollToTopOffset:(CGFloat)floatCustomScrollToTopOffset {
    _floatCustomScrollToTopOffset = floatCustomScrollToTopOffset;
    self.enableScrollToTopButton = YES;
    self.viewScrollToTop.floatOffSet = floatCustomScrollToTopOffset;
}
- (void)setIsOffSetNavigate:(BOOL)isOffSetNavigate {
    _isOffSetNavigate = isOffSetNavigate;
    self.enableScrollToTopButton = YES;
    self.viewScrollToTop.floatOffSet = _MY_NAVIGATION_Y_;
}

- (BOOL)isEnableScrollToTopButton {
    return _enableScrollToTopButton;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (void)dealloc {
    MYLog(@"_MY_%@_DEALLOC_", NSStringFromClass([self class]));
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self
                                  name:_MY_NETWORK_STATUS_CHANGE_NOTIFICATION_
                                object:nil];
//    [notificationCenter removeObserver:self
//                                  name:_MY_CHANGE_MODEL_BROAD_CAST_KEY_
//                                object:nil];
//    [notificationCenter removeObserver:self
//                                  name:_MY_NATION_CHANGE_NOTIFICATION_
//                                object:nil];
    [notificationCenter removeObserver:self
                                  name:_MY_LOGOUT_KICKED_NOTIFICATION_
                                object:nil];
    [notificationCenter removeObserver:self
                                  name:_MY_USER_RELOGIN_NOTIFICATION_KEY_
                                object:nil];
}

@end









