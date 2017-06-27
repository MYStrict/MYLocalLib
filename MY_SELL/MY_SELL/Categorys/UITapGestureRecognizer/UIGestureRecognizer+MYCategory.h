//
//  UIGestureRecognizer+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/5.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (MYCategory)

@property (nonatomic, copy) dispatch_block_t blockClick;

- (void) myGestureAction: (UITapGestureRecognizer *) sender;

@end
