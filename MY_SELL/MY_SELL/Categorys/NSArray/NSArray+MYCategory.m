//
//  NSArray+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/2.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "NSArray+MYCategory.h"

@implementation NSArray (MYCategory)

- (BOOL)myIsArrayValued {
    if ([self isKindOfClass:[NSArray class]]) {
        if (self.count) {
            return YES;
        }
    }
    return false;
}

- (id) myValue: (NSInteger) integerIndex {
    if (self) {
        if ([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSMutableArray class]]) {
            if (self.count > integerIndex) {
                return self[integerIndex];
            }
        }
    }
    return nil;
}

@end
