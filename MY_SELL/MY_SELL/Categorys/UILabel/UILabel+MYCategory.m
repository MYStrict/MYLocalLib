//
//  UILabel+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/5/31.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "UILabel+MYCategory.h"

@implementation UILabel (MYCategory)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}


- (CGFloat) mySetEntityAutoHeight {
    return [self mySetEntityAutoHeight:self.text
                             withWidth:self.frame.size.width];
}

- (CGFloat) mySetEntityAutoHeight : (NSString *) stringValue
                        withWidth : (CGFloat) floatWidth {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:self.lineBreakMode];
    NSDictionary *dictionaryAttributes = @{ NSFontAttributeName : self.font,
                                            NSParagraphStyleAttributeName : style };
    
    return [stringValue boundingRectWithSize:CGSizeMake(floatWidth,
                                                        [[UIScreen mainScreen] bounds].size.height)
                                     options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:dictionaryAttributes
                                     context:nil].size.height;
}

+ (UILabel *) myLabelCommonSettings : (CGRect) rectFrame {
    UILabel *label = [[UILabel alloc] initWithFrame:rectFrame];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:_MY_DEFAULT_FONT_SIZE_];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;
}

@end
