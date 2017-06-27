//
//  UILabel+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/5/31.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MYCategory)


/**
 给定label宽度，高度自适应

 @param width UILabel宽度
 @param title 文本内容
 @param font 文本大小
 @return label的高度
 */
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;


/**
 根据文本内容，宽度自适应

 @param title label标题文本
 @param font label字体大小
 @return label自适应宽度
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;


- (CGFloat) mySetEntityAutoHeight ;

- (CGFloat) mySetEntityAutoHeight : (NSString *) stringValue
                        withWidth : (CGFloat) floatWidth;

+ (UILabel *) myLabelCommonSettings : (CGRect) rectFrame;

@end
