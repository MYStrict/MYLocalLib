//
//  MYSubTableViewController.h
//  MY_SELL
//
//  Created by yanma on 2017/6/15.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYBaseViewController.h"

#import "MYCommonViewTools.h"

@interface MYSubTableViewController : MYBaseViewController

- (instancetype) initWithTableViewFrame: (CGRect) rectFrame;

@property (nonatomic, strong) UITableView * tableViewPlain;

@property (nonatomic, strong) UITableView * tableViewGrouped;

@property (nonatomic, strong) NSMutableArray * arrayData;

@property (nonatomic, copy) UITableViewCell * (^blockConfigCell)(id cellConfig, NSIndexPath * indexPath, NSMutableArray * arrayData);

@property (nonatomic, copy) CGFloat (^blockCellHeight)(NSIndexPath * indexPath);

@property (nonatomic, copy) void (^blockDidSelected)(NSIndexPath * indexPath);

//必须实现
@property (nonatomic, copy) NSString *(^blockReuserIndetifier)();

- (void) myAddTalbeViewPlain;
- (void) myAddTableViewGrouped;

- (void) myReloadWithIsSection: (BOOL) isReloadSection;

@end
