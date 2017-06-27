//
//  UIButton+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/26.
//  Copyright © 2017年 yanma. All rights reserved.
//


#import "UIButton+MYCategory.h"
#import "MYCommonDefine.h"

#import <objc/runtime.h>

const char * _MY_BUTTON_ASSOCIATE_KEY_;
const char * _MY_BUTTON_CLICK_ASSOCIATE_KEY;

@implementation UIButton (MYCategory)

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame {
    return [self myButtonWithFrame:rectFrame
                        withTarget:nil
                      withSelector:nil];
}

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                          withType : (UIButtonType) type
                   withNormalTitle : (NSString *) stringTitleNormal
                 withSelectedTitle : (NSString *) stringSelectedTitle
                   withNormalImage : (NSString *) stringImage
                 withSelectedImage : (NSString *) stringSelectedImage {
    UIButton *button = [UIButton buttonWithType:type];
    button.frame = rectFrame;
    button.titleLabel.font = [UIFont systemFontOfSize:_MY_DEFAULT_FONT_SIZE_];
    if (stringTitleNormal) {
        [button setTitle:stringTitleNormal
                forState:UIControlStateNormal];
    }
    if (stringSelectedTitle) {
        [button setTitle:stringSelectedTitle
                forState:UIControlStateSelected];
    }
    if (stringImage) {
        [button setImage:myImage(stringImage, YES)
                forState:UIControlStateNormal];
    }
    if (stringSelectedImage) {
        [button setImage:myImage(stringSelectedImage, YES)
                forState:UIControlStateSelected];
    }
    button.backgroundColor = [UIColor clearColor];
    return button;
}

#pragma mark - Target - Action

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                        withTarget : (id) target
                      withSelector : (SEL) selector {
    return [self myButtonWithFrame:rectFrame
                          withType:UIButtonTypeSystem
                   withNormalTitle:nil
                 withSelectedTitle:nil
                   withNormalImage:nil
                 withSelectedImage:nil
                        withTarget:target
                      withSelector:selector];
}

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                         withTitle : (NSString *) stringtitle
                        withTarget : (id) target
                      withSelector : (SEL) selector {
    return [self myButtonWithFrame:rectFrame
                          withType:UIButtonTypeSystem
                   withNormalTitle:stringtitle
                 withSelectedTitle:nil
                   withNormalImage:nil
                 withSelectedImage:nil
                        withTarget:target
                      withSelector:selector];
}

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                   withNormalImage : (NSString *) stringImage
                 withSelectedImage : (NSString *) stringSelectedImage
                        withTarget : (id) target
                      withSelector : (SEL) selector {
    return [self myButtonWithFrame:rectFrame
                          withType:UIButtonTypeSystem
                   withNormalTitle:nil
                 withSelectedTitle:nil
                   withNormalImage:stringImage
                 withSelectedImage:stringSelectedImage
                        withTarget:target
                      withSelector:selector];
}

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                          withType : (UIButtonType) type
                   withNormalImage : (NSString *) stringImage
                 withSelectedImage : (NSString *) stringSelectedImage
                        withTarget : (id) target
                      withSelector : (SEL) selector {
    return [self myButtonWithFrame:rectFrame
                          withType:type
                   withNormalTitle:nil
                 withSelectedTitle:nil
                   withNormalImage:stringImage
                 withSelectedImage:stringSelectedImage
                        withTarget:target
                      withSelector:selector];
}

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                   withNormalTitle : (NSString *) stringTitleNormal
                 withSelectedTitle : (NSString *) stringSelectedTitle
                        withTarget : (id) target
                      withSelector : (SEL) selector {
    return [self myButtonWithFrame:rectFrame
                          withType:UIButtonTypeSystem
                   withNormalTitle:stringTitleNormal
                 withSelectedTitle:stringSelectedTitle
                   withNormalImage:nil
                 withSelectedImage:nil
                        withTarget:target
                      withSelector:selector];
}

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                          withType : (UIButtonType) type
                   withNormalTitle : (NSString *) stringTitleNormal
                 withSelectedTitle : (NSString *) stringSelectedTitle
                   withNormalImage : (NSString *) stringImage
                 withSelectedImage : (NSString *) stringSelectedImage
                        withTarget : (id) target
                      withSelector : (SEL) selector {
    UIButton *button = [UIButton myButtonWithFrame:rectFrame
                                          withType:type
                                   withNormalTitle:stringTitleNormal
                                 withSelectedTitle:stringSelectedTitle
                                   withNormalImage:stringImage
                                 withSelectedImage:stringSelectedImage];
    
    if ([target respondsToSelector:selector]) {
        [button addTarget:target
                   action:selector
         forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

#pragma mark - Block

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                    withClickblock : (void(^)(UIButton *sender)) blockButton {
    return [self myButtonWithFrame:rectFrame
                   withNormalImage:nil
                 withSelectedImage:nil
                    withClickblock:blockButton];
}

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                         withTitle : (NSString *) stringtitle
                    withClickblock : (void(^)(UIButton *sender)) blockButton {
    return [self myButtonWithFrame:rectFrame
                   withNormalTitle:stringtitle
                 withSelectedTitle:nil
                    withClickblock:blockButton];
}

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                    withButtonType : (UIButtonType) type
                         withTitle : (NSString *) stringtitle
                    withClickblock : (void(^)(UIButton *sender)) blockButton {
    return [self myButtonWithFrame:rectFrame
                          withType:type
                   withNormalTitle:stringtitle
                 withSelectedTitle:nil
                   withNormalImage:nil
                 withSelectedImage:nil
                    withClickblock:blockButton];
}

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                   withNormalImage : (NSString *) stringImage
                 withSelectedImage : (NSString *) stringSelectedImage
                    withClickblock : (void(^)(UIButton *sender)) blockButton{
    return [self myButtonWithFrame:rectFrame
                          withType:UIButtonTypeSystem
                   withNormalTitle:nil
                 withSelectedTitle:nil
                   withNormalImage:stringImage
                 withSelectedImage:stringSelectedImage
                    withClickblock:blockButton];
}

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                    withButtonType : (UIButtonType) type
                   withNormalImage : (NSString *) stringImage
                    withClickblock : (void(^)(UIButton *sender)) blockButton {
    return [self myButtonWithFrame:rectFrame
                    withButtonType:type
                   withNormalImage:stringImage
                 withSelectedImage:nil
                    withClickblock:blockButton];
}

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                    withButtonType : (UIButtonType) type
                   withNormalImage : (NSString *) stringImage
                 withSelectedImage : (NSString *) stringSelectedImage
                    withClickblock : (void(^)(UIButton *sender)) blockButton{
    return [self myButtonWithFrame:rectFrame
                          withType:type
                   withNormalTitle:nil
                 withSelectedTitle:nil
                   withNormalImage:stringImage
                 withSelectedImage:stringSelectedImage
                    withClickblock:blockButton];
}

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                   withNormalTitle : (NSString *) stringTitleNormal
                 withSelectedTitle : (NSString *) stringSelectedTitle
                    withClickblock : (void(^)(UIButton *sender)) blockButton{
    return [self myButtonWithFrame:rectFrame
                          withType:UIButtonTypeSystem
                   withNormalTitle:stringTitleNormal
                 withSelectedTitle:stringSelectedTitle
                   withNormalImage:nil
                 withSelectedImage:nil
                    withClickblock:blockButton];
}

+ (instancetype) myButtonWithFrame : (CGRect) rectFrame
                          withType : (UIButtonType) type
                   withNormalTitle : (NSString *) stringTitleNormal
                 withSelectedTitle : (NSString *) stringSelectedTitle
                   withNormalImage : (NSString *) stringImage
                 withSelectedImage : (NSString *) stringSelectedImage
                    withClickblock : (void(^)(UIButton *sender)) blockButton{
    UIButton *button = [UIButton myButtonWithFrame:rectFrame
                                          withType:type
                                   withNormalTitle:stringTitleNormal
                                 withSelectedTitle:stringSelectedTitle
                                   withNormalImage:stringImage
                                 withSelectedImage:stringSelectedImage];
    if (blockButton) {
        button.blockButton = [blockButton copy];
    }
    if ([button respondsToSelector:@selector(myButtonAction:)]) {
        [button addTarget:button
                   action:@selector(myButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

#pragma mark - Setter
- (void)setBlockButton:(void (^)(UIButton *))blockButton {
    objc_setAssociatedObject(self, &_MY_BUTTON_ASSOCIATE_KEY_, blockButton, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)setBlockClick:(void (^)(UIButton *))blockClick {
    if (self) {
        [self addTarget:self
                 action:@selector(myButtonAction:)
       forControlEvents:UIControlEventTouchUpInside];
    }
    objc_setAssociatedObject(self, &_MY_BUTTON_CLICK_ASSOCIATE_KEY, blockClick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - Getter
- (void (^)(UIButton *))blockButton {
    return objc_getAssociatedObject(self, &_MY_BUTTON_ASSOCIATE_KEY_);
}
- (void (^)(UIButton *))blockClick {
    return objc_getAssociatedObject(self, &_MY_BUTTON_CLICK_ASSOCIATE_KEY);
}

- (void) myButtonAction : (UIButton *) sender {
    myWeakSelf;
    _MY_Safe_Block_(self.blockButton, ^{
        pSelf.blockButton(sender);
    });
    _MY_Safe_Block_(self.blockClick, ^{
        pSelf.blockClick(sender);
    });
}

@end
