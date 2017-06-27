//
//  MYTableViewDelegateDataSource.h
//  MY_SELL
//
//  Created by yanma on 2017/6/5.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface MYTableViewDelegagte : NSObject <UITableViewDelegate>

- (id <UITableViewDelegate>) initWithDefaultSettings;

@property (nonatomic, copy) CGFloat (^blockCellHeight)(UITableView * tableView, NSIndexPath * indexPath);
@property (nonatomic, copy) CGFloat (^blockSectionHeaderHeight)(UITableView * tableView, NSInteger integerSection);
@property (nonatomic, copy) UIView * (^blockSectionHeader)(UITableView * tableView, NSInteger integerSection);
@property (nonatomic, copy) BOOL (^blockDidSelect)(UITableView * tableView, NSIndexPath * indexPath);

@end

@interface MYTableViewDataSource : NSObject <UITableViewDataSource>

- (id <UITableViewDataSource>) initWithDefaultSettings;

@property (nonatomic, copy) NSInteger (^blockSections)(UITableView * tableView);
@property (nonatomic, copy) NSInteger (^blockRowsInSections)(UITableView * tableView, NSInteger integerSection);
@property (nonatomic, copy) NSString * (^blockCellIndentifier)(UITableView * tableView, NSIndexPath * indexPath);
@property (nonatomic, copy) UITableViewCell * (^blockConfigCell)(UITableView * tableView, UITableViewCell * cellConfig, NSIndexPath * indexPath);

@end
