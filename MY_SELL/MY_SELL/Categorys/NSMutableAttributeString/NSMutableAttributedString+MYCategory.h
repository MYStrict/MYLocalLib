//
//  NSMutableAttributedString+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/26.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (MYCategory)

+ (instancetype) myAttributeWithColor: (UIColor *) color withString: (NSString *) string;

- (instancetype) myAppend: (NSMutableAttributedString *) attributeString;

@end
