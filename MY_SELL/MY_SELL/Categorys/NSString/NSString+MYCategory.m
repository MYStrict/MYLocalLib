//
//  NSString+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/5/31.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "NSString+MYCategory.h"


#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MYCategory)

- (NSString *)mySetTrimingString {
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSDecimalNumber *)myDecimalNumber {
    if (self == nil || [self isKindOfClass:[NSNull class]]) {
        return [NSDecimalNumber decimalNumberWithString:@"0.00"];
    }
    return [NSDecimalNumber decimalNumberWithString: self];
}

- (NSString *)myTwoDecimalPlacesString {
    if (self.length == 0 || self == nil || self.floatValue == 0) {
        return @"0.00";
    }
    NSDecimalNumberHandler * roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber * strNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber * transNumber = [strNumber decimalNumberByRoundingAccordingToBehavior:roundUp];
    NSString * result = [NSString stringWithFormat:@"%@", transNumber];
    if ([result rangeOfString:@"."].location == NSNotFound) {
        result = [result stringByAppendingString:@".00"];
    }else  {
        NSRange range = [result rangeOfString:@"."];
        if (result.length - range.location - 1 == 2) {
            
        }else {
            result = [result stringByAppendingString:@"0"];
        }
    }
    return result;
}

- (NSString *)myMD5String {
    if (!self.length) {
        return nil;
    }
    const char * cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG) strlen(cStr), digest );
    NSMutableString *stringOutput = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [stringOutput appendFormat:@"%02x", digest[i]];
    return  stringOutput;
}

- (NSString *)myUUID {
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

- (BOOL) myIsStringValued {
    if (self) {
        if (self.length && ![self isEqualToString:@"(null)"]) {
            return YES;
        }
    }
    return false;
}

- (NSMutableAttributedString *) myMAttributeString {
    if ([self isKindOfClass:[NSString class]])
        if (self.myIsStringValued)
            return [[NSMutableAttributedString alloc] initWithString:self];
    return nil;
}

//- (NSMutableAttributedString *) myColor : (UIColor *) color {
//    return [NSMutableAttributedString myAttributeWithColor:color
//                                                withString:self];
//}

+ (NSString *) ymMergeWithStringArray : (NSArray <NSString *> *) arrayStrings
                    withNeedLineBreak : (BOOL) isNeedBreak // 回车优先级最高 , 高于空格
                      withNeedSpacing : (BOOL) isNeedSpacing {
    __block NSString *stringResult = @"";
    if (isNeedBreak) {
        [arrayStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSString class]]) {
                stringResult = [stringResult stringByAppendingString:(NSString *) obj];
                if (idx != (arrayStrings.count - 1)) {
                    stringResult = [stringResult stringByAppendingString:@"\n"];
                }
            }
        }];
    }
    else if (isNeedSpacing) {
        [arrayStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSString class]]) {
                stringResult = [stringResult stringByAppendingString:(NSString *) obj];
                if (idx != (arrayStrings.count - 1)) {
                    stringResult = [stringResult stringByAppendingString:@""];
                }
            }
        }];
    }
    else {
        for (NSString *tempString in arrayStrings) {
            stringResult = [stringResult stringByAppendingString:tempString];
        }
    }
    return stringResult;
}

@end

















