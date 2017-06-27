//
//  MYLoginView.h
//  MY_SELL
//
//  Created by yanma on 2017/6/8.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MYLoginAlertType) {
    MYLoginAlertTypeNone = 0,
    MYLoginAlertTypeNoEmail,
    MYLoginAlertTypeNoPasspord,
};

@interface MYLoginView : UIView

@property (nonatomic, strong) UIImageView * loginBackView;
@property (nonatomic, strong) UIImageView * logoImageView;

- (instancetype) initWithStatus: (void(^)(MYLoginAlertType type)) blockHintType
                 withLoginBlock: (dispatch_block_t) blockLogin
                  withRegisterBlock: (dispatch_block_t) blockRegister
                    withForgetBlock: (dispatch_block_t) blockForget;

@end
