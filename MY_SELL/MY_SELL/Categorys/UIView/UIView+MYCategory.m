//
//  UIView+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/5.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "UIView+MYCategory.h"

#import "UITapGestureRecognizer+MYCategory.h"

@implementation UIView (MYCategory)

#pragma mark - Setter
- (void) setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

#pragma mark - Getter
- (CGSize)size {
    return self.frame.size;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (CGFloat)inCenterX {
    return self.frame.size.width * 0.5;
}

- (CGFloat)inCenterY {
    return self.frame.size.height * 0.5;
}

- (CGPoint)inCenter {
    return CGPointMake(self.inCenterX, self.inCenterY);
}

- (CGFloat)top {
    return self.frame.origin.y;
}
- (CGFloat)left {
    return self.frame.origin.x;
}
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

#pragma mark - Methods
+ (instancetype)myViewFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)myAddTapGesture:(dispatch_block_t)block {
    return [self myAddTapGesture:1 withActionBlock:block];
}

- (void)myAddTapGesture:(NSInteger)integerTaps withActionBlock:(dispatch_block_t)block {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] initWithTaps:integerTaps withActionBlock:^{
        if (block) {
            if ([NSThread isMainThread]) {
                block();
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block();
                });
            }
        }
    }];
    [self addGestureRecognizer:tapGR];
}

@end










