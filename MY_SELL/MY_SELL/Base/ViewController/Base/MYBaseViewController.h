//
//  MYBaseViewController.h
//  MY_SELL
//
//  Created by yanma on 2017/5/31.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "UIViewController+MYCategory.h"
//#import "NSMutableArray+MYCategory.h"

#import "MYNetworkMoniter.h"

@interface MYBaseViewController : UIViewController

- (instancetype)initFromNib;

///返回箭头
- (UIBarButtonItem *) mySetNavigationBackArrow;

///右侧对勾
- (UIBarButtonItem *) mySetNavigationCheckMark: (dispatch_block_t) block;

- (UIBarButtonItem *) mySetNavigationRightItem: (NSString *) stringImageName
                                   withIsRight: (BOOL) isRight
                                withClickBlock: (dispatch_block_t) blockClick;

- (void) myBackAction;

- (void) myAddSubView: (UIView *(^)()) blockAdd;

@property (nonatomic, strong) MYNetworkMoniter * moniter;

@property (nonatomic, assign) NSInteger integerPageCount;

@property (nonatomic, strong) NSMutableArray * arrayRequestTask;

- (void) myNetworkTrigger: (NSInteger) integerStatus;

- (void) myChangeNationTrigger: (NSNotification *) sender;
- (void) myLogoutTrigger: (NSNotification *) sender;
- (void) myNotificationModeChangeStatusAction: (NSNotification *) sender;

- (void) myAddErrorNoDataView;
- (void) myRemoveErrorDataView;
- (void) myRemoveNetworkFailView;

- (void) myScrollToTop: (UIScrollView *) scrollView;

@property (nonatomic, getter = isEnableScrollToTopButton) BOOL enableScrollToTopButton;
@property (nonatomic, assign) BOOL isOffSetNavigate;
@property (nonatomic, assign) CGFloat floatCustomScrollToTopOffset;


@end


