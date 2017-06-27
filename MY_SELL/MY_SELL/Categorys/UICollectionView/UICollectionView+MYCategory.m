//
//  UICollectionView+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/1.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "UICollectionView+MYCategory.h"

#import "MYCommonDefine.h"

#import "MYCustomHeader.h"
#import "MYCustomFooter.h"

#import <objc/runtime.h>

@implementation UICollectionView (MYCategory)

+ (instancetype)myInitWithFrame:(CGRect)reactFrame withLayout:(UICollectionViewFlowLayout *)layout withDelegateDataSource:(id)delegateDataSource {
    return [self myInitWithFrame:reactFrame withLayout:layout withDelegate:delegateDataSource withDataSource:delegateDataSource];
}

+ (instancetype)myInitWithFrame:(CGRect)reactFrame withLayout:(UICollectionViewFlowLayout *)layout withDelegate:(id)delegate withDataSource:(id)dataSource {
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:reactFrame collectionViewLayout:layout];
    if (delegate) {
        collectionView.delegate = delegate;
    }
    if (dataSource) {
        collectionView.dataSource = dataSource;
    }
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsVerticalScrollIndicator = false;
    collectionView.showsHorizontalScrollIndicator = false;
    return collectionView;
}

- (void)myRegisterNib:(NSString *)stringNib {
    [self registerNib:[UINib nibWithNibName:stringNib bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:stringNib];
}

- (void)myRegisterClass:(NSString *)stringClazz {
    [self registerClass:NSClassFromString(stringClazz) forCellWithReuseIdentifier:stringClazz];
}

- (void)myHeaderRefreshing:(MYCollectionViewEndLoadType (^)())blockRefresh withFooterLoadMore:(MYCollectionViewEndLoadType (^)())blockLoadMore {
    myWeakSelf;
    _MY_Safe_UI_Block(blockRefresh, ^{
        MYCustomHeader * header = [MYCustomHeader headerWithRefreshingBlock:^{
            if (blockRefresh() != MYCollectionViewEndLoadTypeManualEnd) {
                [pSelf.mj_header endRefreshing];
            }
        }];
        pSelf.mj_header = header;
    });
    
    _MY_Safe_UI_Block(blockLoadMore, ^{
        MYCustomFooter * footer = [MYCustomFooter footerWithRefreshingBlock:^{
            switch (blockLoadMore()) {
                case MYCollectionViewEndLoadTypeEnd:
                    [pSelf.mj_footer endRefreshing];
                    break;
                case MYCollectionViewEndLoadTypeNoMoreData: {
                    [pSelf.mj_footer endRefreshingWithNoMoreData];
                }break;
                case MYCollectionViewEndLoadTypeManualEnd:{
                    
                }break;
#warning MYMARK - mj_footer
                default:{
                    [pSelf.mj_footer endRefreshing];
                }
                    break;
            }
        }];
        pSelf.mj_footer = footer;
    });
}

- (void)myHeaderEndRefreshing {
    [self.mj_header endRefreshing];
}

- (void)myFooterEndLoadMore {
    [self.mj_footer endRefreshing];
}

- (void)myEndLoading {
    [self myHeaderEndRefreshing];
    [self myFooterEndLoadMore];
}

- (void)myFooterEndLoadMoreWithNoMoreData {
    [self myHeaderEndRefreshing];
    if ([self.mj_footer isKindOfClass:[MJRefreshAutoGifFooter class]]) {
        MJRefreshAutoGifFooter * footer = (MJRefreshAutoGifFooter *)self.mj_footer;
        footer.stateLabel.hidden = false;
    }
    [self.mj_footer resetNoMoreData];
}

- (void)myResetLoadMoreStatus {
    if ([self.mj_footer isKindOfClass:[MJRefreshAutoGifFooter class]]) {
        MJRefreshAutoGifFooter * footer = (MJRefreshAutoGifFooter *) self.mj_footer;
        footer.stateLabel.hidden = false;
    }
    [self.mj_footer resetNoMoreData];
}

- (void)myReloadData {
    _MY_UI_Operate_Block(^{
        myWeakSelf;
        [UIView setAnimationsEnabled:false];
        [self performBatchUpdates:^{
            [pSelf reloadSections:[NSIndexSet indexSetWithIndex:0]];
        } completion:^(BOOL finished) {
            [UIView setAnimationsEnabled:YES];
        }];
    });
}


@end



















