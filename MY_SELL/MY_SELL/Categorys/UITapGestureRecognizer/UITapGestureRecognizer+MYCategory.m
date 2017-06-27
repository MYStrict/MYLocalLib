//
//  UITapGestureRecognizer+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/5.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "UITapGestureRecognizer+MYCategory.h"

#import "UIGestureRecognizer+MYCategory.h"

@implementation UITapGestureRecognizer (MYCategory)

- (instancetype)initWithActionBlock:(dispatch_block_t)blockClick {
    return [self initWithTaps:1 withActionBlock:blockClick];
}

- (instancetype)initWithTaps:(NSInteger)integerTaps withActionBlock:(dispatch_block_t)blockClick {
    if (self = [super init]) {
        self.numberOfTapsRequired = integerTaps;
        self.blockClick = [blockClick copy];
        [self addTarget:self action:@selector(myGestureAction:)];
    }
    return self;
}

@end
