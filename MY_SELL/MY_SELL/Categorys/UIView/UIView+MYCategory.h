//
//  UIView+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/5.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MYCategory)

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign, readonly) CGFloat inCenterX;
@property (nonatomic, assign, readonly) CGFloat inCenterY;
@property (nonatomic, assign, readonly) CGPoint inCenter;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

+ (instancetype) myViewFromXib;

- (void) myAddTapGesture: (dispatch_block_t) block;
- (void) myAddTapGesture: (NSInteger) integerTaps
         withActionBlock: (dispatch_block_t) block;




@end












