//
//  UITextField+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/8.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (MYCategory)

+ (UITextField *) myCommonSettingsWithFrame: (CGRect) reactFrame;
+ (UITextField *) myCommonSettingsWithFrame:(CGRect)reactFrame withDelegate: (id) delegate;

- (void) mySetRightViewWithImageName: (NSString *) stringImageName;
- (BOOL) myResignFirstResponder;

@end
