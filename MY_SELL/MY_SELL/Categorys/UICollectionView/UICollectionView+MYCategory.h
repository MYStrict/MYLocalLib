//
//  UICollectionView+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/1.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MYCollectionViewEndLoadType) {
    MYCollectionViewEndLoadTypeEnd = 0,
    MYCollectionViewEndLoadTypeNoMoreData,
    MYCollectionViewEndLoadTypeEndRefresh,
    MYCollectionViewEndLoadTypeManualEnd
};

@interface UICollectionView (MYCategory)

+ (instancetype) myInitWithFrame: (CGRect) reactFrame
                      withLayout: (UICollectionViewFlowLayout *) layout
          withDelegateDataSource: (id) delegateDataSource;

+ (instancetype) myInitWithFrame:(CGRect)reactFrame
                      withLayout:(UICollectionViewFlowLayout *)layout
                    withDelegate: (id) delegate
                  withDataSource: (id) dataSource;

- (void) myRegisterNib: (NSString *) stringNib;
- (void) myRegisterClass: (NSString *) stringClazz;

- (void) myHeaderRefreshing: (MYCollectionViewEndLoadType(^)()) blockRefresh withFooterLoadMore: (MYCollectionViewEndLoadType(^)()) blockLoadMore;

- (void) myHeaderEndRefreshing;
- (void) myFooterEndLoadMore;

- (void) myEndLoading;
- (void) myFooterEndLoadMoreWithNoMoreData;
- (void) myResetLoadMoreStatus;

- (void) myReloadData; //


@end
