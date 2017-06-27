//
//  UITableView+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/1.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MYTableViewEndLoadType) {
    MYTableViewEndLoadTypeEnd = 0,
    MYTableViewEndLoadTypeNoMoreData,
    MYTableViewEndLoadTypeEndRefresh,
    MYTableViewEndLoadTypeManualEnd
};

@interface UITableView (MYCategory)

+ (instancetype) myInitWithFrame: (CGRect) reactFrame;

+ (instancetype) myInitWithFrame: (CGRect) reactFrame
           withDelegateDataSource: (id) delegateDataSource;

+ (instancetype) myInitWithFrame:(CGRect)reactFrame
                    withDelegate: (id) delegate
                  withDataSource: (id) dataSource;

+ (instancetype) myInitWithFrame:(CGRect)reactFrame
                       withStyle: (UITableViewStyle)style
          withDelegateDataSource:(id)delegateDataSource;

+ (instancetype) myInitWithFrame:(CGRect)reactFrame
                       withStyle: (UITableViewStyle)style
                    withDelegate:(id)delegate
                  withDataSource:(id)dataSource;

- (void) myRegisterNib: (NSString *) stringNib;

- (void) myRegisterClass: (NSString *) stringClazz;

- (void) myHeaderRefreshing: (MYTableViewEndLoadType(^)()) blockRefresh
         withFooterLoadMore: (MYTableViewEndLoadType(^)()) blockLoadMore;

- (void) myUpdateing: (dispatch_block_t) block;

- (void) myHeaderEndRefreshing;
- (void) myFooterEndLoadMore;

- (void) myEndLoading;
- (void) myFooterEndLoadMoreWithNoMoreData;
- (void) myResetLoadMoreStatus;

@end
