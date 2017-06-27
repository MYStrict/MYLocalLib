//
//  MYTableViewDelegateDataSource.m
//  MY_SELL
//
//  Created by yanma on 2017/6/5.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYTableViewDelegateDataSource.h"

#import "MYCommonDefine.h"

@implementation MYTableViewDelegagte

- (id<UITableViewDelegate>)initWithDefaultSettings {
    if (self = [super init]) {
        
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.blockCellHeight ? self.blockCellHeight(tableView, indexPath) : 45.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.blockSectionHeaderHeight ? self.blockSectionHeaderHeight(tableView, section) : .0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.blockSectionHeader ? self.blockSectionHeader(tableView, section) : nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.blockDidSelect) {
        if (self.blockDidSelect(tableView, indexPath)) {
            [tableView deselectRowAtIndexPath:indexPath animated:false];
        }
    }
}

_MY_DETECT_DEALLOC_

@end

@interface MYTableViewDataSource ()

@end

@implementation MYTableViewDataSource

- (id<UITableViewDataSource>)initWithDefaultSettings {
    if (self = [super init]) {
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.blockSections ? self.blockSections(tableView) : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.blockRowsInSections ? self.blockRowsInSections(tableView, section) : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * stringCellIndentifer = self.blockCellIndentifier ? self.blockCellIndentifier(tableView, indexPath) : @"CELL";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:stringCellIndentifer forIndexPath:indexPath];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringCellIndentifer];
    }
    return self.blockConfigCell ? self.blockConfigCell(tableView, cell, indexPath) : cell;
}


@end










