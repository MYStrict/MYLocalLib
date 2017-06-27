//
//  UITableView+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/1.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "UITableView+MYCategory.h"

#import "MYCustomHeader.h"
#import "MYCustomFooter.h"

#import "MYCommonDefine.h"

@implementation UITableView (MYCategory)

+ (instancetype)myInitWithFrame:(CGRect)reactFrame {
    return [self myInitWithFrame:reactFrame
          withDelegateDataSource:nil];
}

+ (instancetype)myInitWithFrame:(CGRect)reactFrame
         withDelegateDataSource:(id)delegateDataSource {
    return [self myInitWithFrame:reactFrame
                       withStyle:UITableViewStylePlain
          withDelegateDataSource:delegateDataSource];
}

+ (instancetype)myInitWithFrame:(CGRect)reactFrame
                   withDelegate:(id)delegate
                 withDataSource:(id)dataSource {
    return [self myInitWithFrame:reactFrame
                       withStyle:UITableViewStylePlain
                    withDelegate: delegate
                  withDataSource:dataSource];
}

+ (instancetype)myInitWithFrame:(CGRect)reactFrame
                      withStyle:(UITableViewStyle)style
         withDelegateDataSource:(id)delegateDataSource {
    return [self myInitWithFrame:reactFrame
                       withStyle:style
                    withDelegate:delegateDataSource
                  withDataSource:delegateDataSource];
}

+ (instancetype)myInitWithFrame:(CGRect)reactFrame withStyle:(UITableViewStyle)style withDelegate:(id)delegate withDataSource:(id)dataSource {
    UITableView * tableView = [[UITableView alloc] initWithFrame:reactFrame style:style];
    if (delegate) {
        tableView.delegate = delegate;
    }
    if (dataSource) {
        tableView.dataSource = dataSource;
    }
    tableView.showsVerticalScrollIndicator = false;
    tableView.showsHorizontalScrollIndicator = false;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.bounces = YES;
    return tableView;
}

- (void)myRegisterNib:(NSString *)stringNib {
    [self registerNib:[UINib nibWithNibName:stringNib bundle:[NSBundle mainBundle]] forCellReuseIdentifier: stringNib];
}

- (void)myRegisterClass:(NSString *)stringClazz {
    [self registerClass:NSClassFromString(stringClazz) forCellReuseIdentifier:stringClazz];
}

- (void)myHeaderRefreshing:(MYTableViewEndLoadType (^)())blockRefresh withFooterLoadMore:(MYTableViewEndLoadType (^)())blockLoadMore {
    myWeakSelf;
    _MY_Safe_UI_Block(blockRefresh, ^{
        MYCustomHeader * header = [MYCustomHeader headerWithRefreshingBlock:^{
            if (blockRefresh() != MYTableViewEndLoadTypeManualEnd) {
                [pSelf.mj_header endRefreshing];
            }
        }];
        pSelf.mj_header = header;
    });
    
    _MY_Safe_Block_(blockLoadMore, ^{
        MYCustomFooter * footer = [MYCustomFooter footerWithRefreshingBlock:^{
            switch (blockLoadMore()) {
                case MYTableViewEndLoadTypeEnd: {
                    [pSelf.mj_footer endRefreshing];
                }break;
                case MYTableViewEndLoadTypeNoMoreData: {
                    [pSelf.mj_footer endRefreshingWithNoMoreData];
                }break;
                case MYTableViewEndLoadTypeManualEnd: {
                    
                }break;
#warning MYMARK - mj_footer
                default:{
                    [pSelf.mj_header endRefreshing];
                }break;
            }
        }];
        pSelf.mj_footer = footer;
    });
    
}

- (void)myUpdateing:(dispatch_block_t)block {
    [self beginUpdates];
    if (block) {
        block();
    }
    [self endUpdates];
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
        MJRefreshAutoGifFooter * footer = (MJRefreshAutoGifFooter *) self.mj_footer;
        footer.stateLabel.hidden = false;
    }
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)myResetLoadMoreStatus {
    if ([self.mj_footer isKindOfClass:[MJRefreshAutoGifFooter class]]) {
        MJRefreshAutoGifFooter * footer = (MJRefreshAutoGifFooter *) self.mj_footer;
        footer.stateLabel.hidden = NO;
    }
    [self.mj_footer resetNoMoreData];
}


@end
















