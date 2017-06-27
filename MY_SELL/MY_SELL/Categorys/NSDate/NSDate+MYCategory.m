//
//  NSDate+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/23.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "NSDate+MYCategory.h"

@implementation NSDate (MYCategory)


- (NSInteger)myFirstWeekdayInThisMonth {
    
    //日历类 获取当前用户的逻辑日历
    NSCalendar * calendar = [NSCalendar currentCalendar];
    /*
     //设定每周的第一天从星期几开始
     value = 1，从星期日开始，1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
     */
    [calendar setFirstWeekday:1];
    NSDateComponents * comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    [comp setDay:1];
    NSDate * firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (NSInteger)myDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return [components day];
}

- (NSInteger)myGetDateWeekday {
    NSInteger weekDay = [self myFirstWeekdayInThisMonth];
    NSInteger day = [self myDay];
    
    NSInteger currentWeekNum = (day + weekDay -1) % 7;
    if (currentWeekNum == 0) {
        currentWeekNum = 7;
    }
    return currentWeekNum;
}

- (NSString *) myWeekDays {
    switch (self.myGetDateWeekday) {
        case 1:{
            return ccLocalize(@"_MY_MON_", "一");
        }break;
        case 2:{
            return ccLocalize(@"_MY_TUE_", "二");
        }break;
        case 3:{
            return ccLocalize(@"_MY_WEN_", "三");
        }break;
        case 4:{
            return ccLocalize(@"_MY_THUR_", "四");
        }break;
        case 5:{
            return ccLocalize(@"_MY_FRI_", "五");
        }break;
        case 6:{
            return ccLocalize(@"_MY_SAT_", "六");
        }break;
        case 7:{
            return ccLocalize(@"_MY_SUN_", "七");
        }break;
            
        default:{
            return ccLocalize(@"_MY_MON_", "一");
        }break;
    }
}

NSString * ccLocalize(NSString *stringLocalKey , char *c) {
    return NSLocalizedStringFromTableInBundle(stringLocalKey, @"LocalizableMain", [NSBundle mainBundle], nil);
}

@end
