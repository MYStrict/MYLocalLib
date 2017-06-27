//
//  NSDecimalNumber+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/23.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <Foundation/Foundation.h>

#define _MY_DECIMAL_POINT_POSITION_ 2

@interface NSDecimalNumber (MYCategory)

- (NSString *) myRounding; //保留小数点后几位

- (NSString *) myRoundingAfterPoint: (NSInteger)position;


- (NSString *) myRoundingAfterPoint:(NSInteger)position withRoundMode: (NSRoundingMode) mode;

- (NSString *) ymRoundingAfterPoint : (NSInteger) position
                      withRoundMode : (NSRoundingMode) mode ; // 是否向上取整 , 只入不舍

- (instancetype) ymRoundingDecimal ; // 保留小数后几位

- (instancetype) ymRoundingDecimalAfterPoint : (NSInteger)position ; // 保留小数后几位

- (instancetype) ymRoundingDecimalAfterPoint : (NSInteger) position
                               withRoundMode : (NSRoundingMode) mode  ;

- (NSString *) ymTransferToString ;

- (instancetype) ymMuti : (NSDecimalNumber *) decimalNumber ; // 乘

- (instancetype) ymDivide : (NSDecimalNumber *) decimalNumber ; // 除

- (BOOL) ymIsDecimalValued ;


@end
