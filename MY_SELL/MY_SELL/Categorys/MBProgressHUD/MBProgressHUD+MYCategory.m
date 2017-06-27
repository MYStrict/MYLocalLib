//
//  MBProgressHUD+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/6.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MBProgressHUD+MYCategory.h"

#import "MYCommonDefine.h"

@implementation MBProgressHUD (MYCategory)

+ (void)myHideAllHud {
    [self myHideAllHud:nil];
}

+ (void)myHideAllHud:(dispatch_block_t)blockComplete {
    [self myHideAllHud:[UIApplication sharedApplication].delegate.window withComplete:blockComplete];
}

+ (void)myHideAllHud:(UIView *)view withComplete:(dispatch_block_t)blockComplete {
    for (id object in view.subviews) {
        if ([object isKindOfClass:[MBProgressHUD class]]) {
            [self myHideSingleHud];
        }
    }
    if (blockComplete) {
        blockComplete();
    }
}

+ (void)myHideSingleHud {
    [self myHideSingleHud:[UIApplication sharedApplication].delegate.window];
}

+ (void)myHideSingleHud:(UIView *)view {
    if ([NSThread isMainThread]) {
        [MBProgressHUD hideHUDForView:view animated:YES];
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:view animated:YES];
        });
    }
}

+ (BOOL)myIsCurrentHasHud {
    return [self myIsCurrentHasHud:[UIApplication sharedApplication].delegate.window];
}

+ (BOOL)myIsCurrentHasHud:(UIView *)view {
    for (id obj in view.subviews) {
        if ([obj isKindOfClass:[self class]]) {
            return YES;
        }
    }
    return false;
}

+ (MBProgressHUD *)myShowMessage:(NSString *)stringMessage {
    return [self myShowTitle:nil
                 withMessage:stringMessage
          withHideAfterDelay:_MY_ALERT_DISMISS_INTERVAL_];
}


+ (MBProgressHUD *)myShowMessage:(NSString *)stringMessage
                        withView:(UIView *)view {
    return [self myShowTitle:nil
                 withMessage: stringMessage
          withHideAfterDelay:_MY_ALERT_DISMISS_INTERVAL_
           withCompleteBlock:nil
               withAlertType:MYWeakAlertTypeDark
                    withView:view];
}

+ (MBProgressHUD *)myShowTitle:(NSString *)stringTitle
                   withMessage:(NSString *)stringMessage
            withHideAfterDelay:(CGFloat)floatDelay {
    return [self myShowTitle:stringTitle
                 withMessage:stringMessage
          withHideAfterDelay:floatDelay
           withCompleteBlock:nil
               withAlertType:MYWeakAlertTypeDark];
}

+ (MBProgressHUD *)myShowTitle:(NSString *)stringTitle
                   withMessage:(NSString *)stringMessage
             withCompleteBlock:(dispatch_block_t)blockComplete {
    return [self myShowTitle:stringTitle
                 withMessage:stringMessage
          withHideAfterDelay:_MY_ALERT_DISMISS_INTERVAL_
           withCompleteBlock:blockComplete
               withAlertType:MYWeakAlertTypeDark];
}

+ (MBProgressHUD *) myShowTitle : (NSString *) stringTitle
                    withMessage : (NSString *) stringMessage
             withHideAfterDelay : (CGFloat) floatDelay
              withCompleteBlock : (dispatch_block_t) blockComplete {
    return [self myShowTitle : stringTitle
                 withMessage : stringMessage
          withHideAfterDelay : floatDelay
           withCompleteBlock : blockComplete
               withAlertType : MYWeakAlertTypeDark];
}

#pragma mark - WITH TYPE
+ (MBProgressHUD *)myShowMessage:(NSString *)stringMessage
                   withAlertType:(MYWeakAlertType)type {
    return [self myShowTitle:nil
                 withMessage:stringMessage
          withHideAfterDelay:_MY_ALERT_DISMISS_INTERVAL_
               withAlertType:type];
}

+ (MBProgressHUD *)myShowTitle:(NSString *)stringTitle
                   withMessage:(NSString *)stringMessage
            withHideAfterDelay:(CGFloat)floatDelay
                 withAlertType:(MYWeakAlertType)type {
    return [self myShowTitle:stringTitle
                 withMessage:stringMessage
          withHideAfterDelay:floatDelay
           withCompleteBlock:nil
               withAlertType:type];
}

+ (MBProgressHUD *)myShowTitle:(NSString *)stringTitle
                   withMessage:(NSString *)stringMessage
            withCompleteBlock:(dispatch_block_t)blockComplete
                 withAlertType:(MYWeakAlertType)type {
    return [self myShowTitle:stringTitle
                 withMessage:stringMessage
          withHideAfterDelay:_MY_ALERT_DISMISS_INTERVAL_
           withCompleteBlock:blockComplete
               withAlertType:type];
}

+ (MBProgressHUD *)myShowTitle:(NSString *)stringTitle
                   withMessage:(NSString *)stringMessage
            withHideAfterDelay:(CGFloat)floatDelay
             withCompleteBlock:(dispatch_block_t)blockComplete
                 withAlertType:(MYWeakAlertType)type {
    MBProgressHUD * progressHud = [self myDefaultSettingsWithAlertType:type];
    progressHud.label.text = stringTitle;
    progressHud.detailsLabel.text = stringMessage;
    
    if (floatDelay > 0) {
        [progressHud hideAnimated:YES afterDelay:floatDelay];
    }
    
    _MY_Safe_UI_Block(blockComplete, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(floatDelay + 0.1f) * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self myHideAllHud];
        });
        blockComplete();
    });
    
    return progressHud;
}

+ (MBProgressHUD *)myShowTitle:(NSString *)stringTitle
                   withMessage:(NSString *)stringMessage
            withHideAfterDelay:(CGFloat)floatDelay
             withCompleteBlock:(dispatch_block_t)blockComplete
                 withAlertType:(MYWeakAlertType)type
                      withView:(UIView *)view{
    MBProgressHUD * progressHud = [self myDefaultSettingsWithAlertType:type withView: view];
    progressHud.label.text = stringTitle;
    progressHud.detailsLabel.text = stringMessage;
    if (floatDelay > 0) {
        [progressHud hideAnimated:YES afterDelay:floatDelay];
    }
    
    _MY_Safe_UI_Block(blockComplete, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((floatDelay + 0.1f)* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self myHideAllHud];
        });
        blockComplete();
    });
    return progressHud;
}


+ (MBProgressHUD *)myDefaultSettingsWithAlertType:(MYWeakAlertType)type {
    return [self myDefaultSettingsWithAlertType:type withView:[UIApplication sharedApplication].delegate.window];
}

+ (MBProgressHUD *)myDefaultSettingsWithAlertType:(MYWeakAlertType)type withView:(UIView *)view {
    MBProgressHUD * progressHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (type == MYWeakAlertTypeLight) {
        progressHud.contentColor = [UIColor blackColor];
    }else {
        progressHud.contentColor = [UIColor whiteColor];
        progressHud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        progressHud.bezelView.backgroundColor = [UIColor blackColor];
    }
    progressHud.mode = MBProgressHUDModeText;
    progressHud.userInteractionEnabled = false;
    
    return progressHud;
}

+ (MBProgressHUD *)myShowIndicatorWithHideAfterDelay:(CGFloat)floatDelay {
    return [self myShowIndicatorWithHideAfterDelay:floatDelay
                                       withMessage:nil];
}

+ (MBProgressHUD *)myShowIndicatorWithHideAfterDelay:(CGFloat)floatDelay
                                            withView:(UIView *)view {
    return [self myShowIndicatorWithHideAfterDelay:floatDelay
                                          withView:view
                                       withMessage:nil];
}

+ (MBProgressHUD *)myShowIndicatorWithHideAfterDelay:(CGFloat)floatDelay
                                         withMessage:(NSString *)stringMessage {
    return [self myShowIndicatorWithHideAfterDelay:floatDelay
                                          withView:[UIApplication sharedApplication].delegate.window withMessage:stringMessage];
}

+ (MBProgressHUD *)myShowIndicatorWithHideAfterDelay:(CGFloat)floatDelay withView:(UIView *)view withMessage:(NSString *)stringMessage {
    MBProgressHUD * progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    progressHUD.userInteractionEnabled = false;
    if (stringMessage) {
        progressHUD.detailsLabel.text = stringMessage;
    }
    if (floatDelay > 0) {
        [progressHUD hideAnimated:YES afterDelay:floatDelay];
    }
    return progressHUD;
}




@end












