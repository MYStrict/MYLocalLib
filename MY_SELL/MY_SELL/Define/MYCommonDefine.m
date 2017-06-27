//
//  MYCommonDefine.m
//  MY_SELL
//
//  Created by yanma on 2017/6/1.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYCommonDefine.h"

//#import "NSString+MYCategory.h"

@implementation MYCommonDefine

void _MY_Safe_Block_ (id blockNil, dispatch_block_t block) {
    if (!blockNil || !block) {
        return;
    }
    block();
}
void _MY_Safe_UI_Block (id blockNil, dispatch_block_t block) {
    if (!blockNil || !block) {
        return;
    }
    if ([NSThread isMainThread]) {
        block();
    }else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

void _MY_UI_Operate_Block (dispatch_block_t block) {
    if (!block) {
        return;
    }
    if ([NSThread isMainThread]) {
        block();
    }else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

UIColor * myHexColor(int intValue, float floatAlpha) {
    return [UIColor colorWithRed:((CGFloat)((intValue & 0xFF0000) >> 16)) / 255.0
                           green:((CGFloat)((intValue & 0xFF00) >> 8)) / 255.0
                            blue:((CGFloat)(intValue & 0xFF)) / 255.0
                           alpha:floatAlpha];
}

UIColor * myRGBColor(float floatR, float floatG, float floatB) {
    return myRGBAColor(floatR, floatG, floatB, 1.0f);
}
UIColor * myRGBAColor(float floatR, float floatG, float floatB, float floatA) {
    return [UIColor colorWithRed:floatR / 255.0f
                           green:floatG / 255.0f
                            blue:floatB / 255.0f
                           alpha:floatA];
}

NSURL * myURL(NSString * stringURL, BOOL isLocalFile) {
    return isLocalFile ? [NSURL fileURLWithPath:stringURL] : [NSURL URLWithString:stringURL];
}

#warning MYMARK - image Cache 
UIImage *myImage(NSString *stringName , BOOL isCacheInMemory) {
    return isCacheInMemory ? [UIImage imageNamed:stringName] : [UIImage imageWithContentsOfFile:stringName];
}


NSString * myObjMerge(id obj, ...) {
    NSMutableArray * stringsArray = [[NSMutableArray alloc] init];
    NSString * stringTemp;
    va_list argumentList;
    if (obj) {
        if ([obj isKindOfClass:[NSString class]]) {
            [stringsArray addObject:obj];
        }else {
            [stringsArray addObject:myStringFormat(@"%@", obj)];
        }
        va_start(argumentList, obj);
        while ((stringTemp = va_arg(argumentList, id))) {
            if ([stringTemp isKindOfClass:[NSString class]]) {
                [stringsArray addObject:stringTemp];
            }else {
                [stringsArray addObject:myStringFormat(@"%@", stringTemp)];
            }
            va_end(argumentList);
        }
    }
    return [NSString ymMergeWithStringArray:stringsArray
                          withNeedLineBreak:false
                            withNeedSpacing:false];
}

NSString * myLocalize(NSString * stringLocalKey, NSString * stringCommont) {
    return NSLocalizedString(stringLocalKey, stringCommont);
    //return NSLocalizedStringFromTableInBundle(stringLocalKey, @"LocalizableMain", [NSBundle mainBundle], nil);
}



@end






