//
//  NSDate+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/23.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MYCategory)


- (NSInteger) ymFirstWeekdayInThisMonth ;

- (NSInteger) ymDay ;

- (NSInteger) ymGetDateWeekday ;

- (NSString *) ymWeekDays ; // 返回当前是周几

NSString * ccLocalize(NSString *stringLocalKey , char *c);

- (NSInteger) myFirstWeekdayInThisMonth;

- (NSInteger) myDay;

- (NSInteger) myGetDateWeekday;

- (NSString *) myWeekDays;

NSString * ccLocalize(NSString *stringLocalKey, char *c);

@end
