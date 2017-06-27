//
//  NSNumber+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/15.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "NSNumber+MYCategory.h"

@implementation NSNumber (MYCategory)

- (NSDecimalNumber *) myDecimalValue {
    return [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", self]];
}

@end
