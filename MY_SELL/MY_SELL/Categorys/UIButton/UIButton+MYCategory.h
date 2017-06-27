//
//  UIButton+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/26.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MYCategory)

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame;

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                          withType : (UIButtonType) type
                   withNormalTitle : (NSString *) stringTitleNormal
                 withSelectedTitle : (NSString *) stringSelectedTitle
                   withNormalImage : (NSString *) stringImage
                 withSelectedImage : (NSString *) stringSelectedImage;

#pragma mark - Target - Action
+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                         withTitle : (NSString *) stringtitle
                        withTarget : (id) target
                      withSelector : (SEL) selector ;

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                        withTarget : (id) target
                      withSelector : (SEL) selector ;

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                   withNormalImage : (NSString *) stringImage
                 withSelectedImage : (NSString *) stringSelectedImage
                        withTarget : (id) target
                      withSelector : (SEL) selector ;

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                          withType : (UIButtonType) type
                   withNormalImage : (NSString *) stringImage
                 withSelectedImage : (NSString *) stringSelectedImage
                        withTarget : (id) target
                      withSelector : (SEL) selector ;

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                   withNormalTitle : (NSString *) stringTitleNormal
                 withSelectedTitle : (NSString *) stringSelectedTitle
                        withTarget : (id) target
                      withSelector : (SEL) selector ;

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                          withType : (UIButtonType) type
                   withNormalTitle : (NSString *) stringTitleNormal
                 withSelectedTitle : (NSString *) stringSelectedTitle
                   withNormalImage : (NSString *) stringImage
                 withSelectedImage : (NSString *) stringSelectedImage
                        withTarget : (id) target
                      withSelector : (SEL) selector ;

#pragma mark - Block

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                    withClickblock : (void(^)(UIButton *sender)) blockButton;

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                         withTitle : (NSString *) stringtitle
                    withClickblock : (void(^)(UIButton *sender)) blockButton;

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                    withButtonType : (UIButtonType) type
                         withTitle : (NSString *) stringtitle
                    withClickblock : (void(^)(UIButton *sender)) blockButton;

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                   withNormalImage : (NSString *) stringImage
                 withSelectedImage : (NSString *) stringSelectedImage
                    withClickblock : (void(^)(UIButton *sender)) blockButton;

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                    withButtonType : (UIButtonType) type
                   withNormalImage : (NSString *) stringImage
                    withClickblock : (void(^)(UIButton *sender)) blockButton;

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                    withButtonType : (UIButtonType) type
                   withNormalImage : (NSString *) stringImage
                 withSelectedImage : (NSString *) stringSelectedImage
                    withClickblock : (void(^)(UIButton *sender)) blockButton;

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                   withNormalTitle : (NSString *) stringTitleNormal
                 withSelectedTitle : (NSString *) stringSelectedTitle
                    withClickblock : (void(^)(UIButton *sender)) blockButton;

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                          withType : (UIButtonType) type
                   withNormalTitle : (NSString *) stringTitleNormal
                 withSelectedTitle : (NSString *) stringSelectedTitle
                   withNormalImage : (NSString *) stringImage
                 withSelectedImage : (NSString *) stringSelectedImage
                    withClickblock : (void(^)(UIButton *sender)) blockButton;

@property (nonatomic , copy) void (^blockButton)(UIButton *sender);

@property (nonatomic , copy) void (^blockClick)(UIButton *sender) ;

- (void) myButtonAction : (UIButton *) sender ;

@end

