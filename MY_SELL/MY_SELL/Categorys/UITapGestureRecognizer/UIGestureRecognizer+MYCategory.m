//
//  UIGestureRecognizer+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/5.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "UIGestureRecognizer+MYCategory.h"

#import <objc/runtime.h>

const char * _MY_GESTURE_KEY_;

@implementation UIGestureRecognizer (MYCategory)

- (void) myGestureAction:(UITapGestureRecognizer *)sender {
    if (self.blockClick) {
        if ([NSThread isMainThread]) {
            self.blockClick();
        }else {
            myWeakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                pSelf.blockClick();
            });
        }
    }
}

- (void)setBlockClick:(dispatch_block_t)blockClick {
    objc_setAssociatedObject(self, &_MY_GESTURE_KEY_, blockClick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (dispatch_block_t)blockClick {
    return objc_getAssociatedObject(self, &_MY_GESTURE_KEY_);
}


@end
