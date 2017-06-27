//
//  NSMutableAttributedString+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/26.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "NSMutableAttributedString+MYCategory.h"


@implementation NSMutableAttributedString (MYCategory)


+ (instancetype) myAttributeWithColor : (UIColor *) color
                           withString : (NSString *) string {
    if ([string isKindOfClass:[NSString class]])
        if (string.myIsStringValued) {
            NSMutableAttributedString *stringResult = [[NSMutableAttributedString alloc] initWithString:string
                                                                                             attributes:@{NSForegroundColorAttributeName : color}];
            return stringResult;
        }
    return nil;
}

- (instancetype) myAppend : (NSMutableAttributedString *) attributeString {
    if ([attributeString isKindOfClass:[NSMutableAttributedString class]])
        if (attributeString.length) {
            [self appendAttributedString:attributeString];
            return self;
        }
    return self;
}


@end
