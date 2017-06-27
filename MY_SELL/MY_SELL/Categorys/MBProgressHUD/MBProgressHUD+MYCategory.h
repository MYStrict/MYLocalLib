//
//  MBProgressHUD+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/6.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSInteger, MYWeakAlertType) {
    MYWeakAlertTypeLight = 0,
    MYWeakAlertTypeDark
};

@interface MBProgressHUD (MYCategory)

+ (void) myHideAllHud;

+ (void) myHideAllHud: (dispatch_block_t) blockComplete;
+ (void) myHideAllHud: (UIView *) view withComplete: (dispatch_block_t) blockComplete;

+ (void) myHideSingleHud;
+ (void) myHideSingleHud: (UIView *) view;
+ (BOOL) myIsCurrentHasHud;
+ (BOOL) myIsCurrentHasHud: (UIView *) view;

+ (MBProgressHUD *) myShowMessage: (NSString *) stringMessage;
+ (MBProgressHUD *) myShowMessage:(NSString *)stringMessage
                    withAlertType: (MYWeakAlertType) type;
+ (MBProgressHUD *) myShowMessage:(NSString *)stringMessage
                         withView: (UIView *) view;

+ (MBProgressHUD *) myShowTitle: (NSString *) stringTitle
                    withMessage: (NSString *) stringMessage
             withHideAfterDelay: (CGFloat) floatDelay;
+ (MBProgressHUD *) myShowTitle:(NSString *)stringTitle
                    withMessage:(NSString *)stringMessage
             withHideAfterDelay: (CGFloat) floatDelay
                  withAlertType: (MYWeakAlertType) type;

+ (MBProgressHUD *) myShowTitle:(NSString *)stringTitle
                    withMessage:(NSString *)stringMessage
              withCompleteBlock: (dispatch_block_t) blockComplete;
+ (MBProgressHUD *) myShowTitle:(NSString *)stringTitle
                    withMessage:(NSString *)stringMessage
              withCompleteBlock:(dispatch_block_t)blockComplete
                  withAlertType: (MYWeakAlertType) type;

+ (MBProgressHUD *) myShowTitle:(NSString *)stringTitle
                    withMessage:(NSString *)stringMessage
             withHideAfterDelay:(CGFloat)floatDelay
                   withCompleteBlock: (dispatch_block_t) blockComplete;
+ (MBProgressHUD *) myShowTitle:(NSString *)stringTitle
                    withMessage:(NSString *)stringMessage
             withHideAfterDelay:(CGFloat)floatDelay
                   withCompleteBlock: (dispatch_block_t) blockComplete
                  withAlertType: (MYWeakAlertType) type;
+ (MBProgressHUD *) myShowTitle:(NSString *)stringTitle
                    withMessage:(NSString *)stringMessage
             withHideAfterDelay:(CGFloat)floatDelay
              withCompleteBlock: (dispatch_block_t) blockComplete
                  withAlertType:(MYWeakAlertType)type
                       withView: (UIView *) view;

+ (MBProgressHUD *) myDefaultSettingsWithAlertType: (MYWeakAlertType) type;
+ (MBProgressHUD *) myDefaultSettingsWithAlertType:(MYWeakAlertType)type
                                          withView: (UIView *) view;

+ (MBProgressHUD *) myShowIndicatorWithHideAfterDelay:(CGFloat) floatDelay;
+ (MBProgressHUD *) myShowIndicatorWithHideAfterDelay:(CGFloat)floatDelay
                                        withView: (UIView *) view;
+ (MBProgressHUD *) myShowIndicatorWithHideAfterDelay:(CGFloat)floatDelay
                                          withMessage: (NSString *) stringMessage;
+ (MBProgressHUD *) myShowIndicatorWithHideAfterDelay:(CGFloat)floatDelay
                                             withView: (UIView *) view
                                          withMessage: (NSString *) stringMessage;

@end


























