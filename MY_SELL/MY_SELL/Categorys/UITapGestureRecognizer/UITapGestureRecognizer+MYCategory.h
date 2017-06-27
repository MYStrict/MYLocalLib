//
//  UITapGestureRecognizer+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/5.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITapGestureRecognizer (MYCategory)

- (instancetype)initWithActionBlock: (dispatch_block_t) blockClick;

- (instancetype)initWithTaps: (NSInteger) integerTaps withActionBlock: (dispatch_block_t) blockClick;

@end
