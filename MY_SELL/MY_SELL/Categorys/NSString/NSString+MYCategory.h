//
//  NSString+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/5/31.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (MYCategory)

///去掉首尾空格
- (NSString *) mySetTrimingString;


///转为高精度计算number，只针对数字字符串
- (NSDecimalNumber *) myDecimalNumber;

/**
 高精度计算，保留两位小数
 
 @return NSString字符串
 */
- (NSString *) myTwoDecimalPlacesString;

///字符串的MD5加密
- (NSString *) myMD5String;

///获取设备uuid
- (NSString *) myUUID;

- (BOOL) myIsStringValued ;

- (NSMutableAttributedString *) myMAttributeString ;

- (NSMutableAttributedString *) myColor : (UIColor *) color ;

+ (NSString *) ymMergeWithStringArray : (NSArray <NSString *> *) arrayStrings
                    withNeedLineBreak : (BOOL) isNeedBreak // 回车优先级最高 , 高于空格
                      withNeedSpacing : (BOOL) isNeedSpacing ;


@end



