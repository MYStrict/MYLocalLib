//
//  MYLoginView.m
//  MY_SELL
//
//  Created by yanma on 2017/6/8.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYLoginView.h"

#import "MYLoginElementView.h"
#import "MYTextfieldView.h"

NSString * _YM_EMAIL_KEY_ = @"_YM_EMAIL_KEY_";
NSString * _YM_PASSWORD_KEY_ = @"_YM_PASSWORD_KEY_";

@interface MYLoginView()

@property (nonatomic, strong) MYTextfieldView * emailView;
@property (nonatomic, strong) MYTextfieldView * passwordView;

@property (nonatomic, strong) NSMutableDictionary * dictionaryValues;

@property (nonatomic, copy) void(^blockHintType)(MYLoginAlertType typeAlert);
@property (nonatomic, copy) dispatch_block_t blockLogin;
@property (nonatomic, copy) dispatch_block_t blockRegister;
@property (nonatomic, copy) dispatch_block_t blockForget;

- (void) myDefaultSettings;

@end

@implementation MYLoginView

- (instancetype) initWithStatus: (void(^)(MYLoginAlertType type)) blockHintType
                 withLoginBlock: (dispatch_block_t) blockLogin
                  withRegisterBlock: (dispatch_block_t) blockRegister
                    withForgetBlock: (dispatch_block_t) blockForget {
    if (self = [super initWithFrame:(CGRect){CGPointZero, SCREEN_WIDTH, SCREEN_HEIGHT}]) {
        _blockHintType = [blockHintType copy];
        _blockLogin = [blockLogin copy];
        _blockForget = [blockForget copy];
        _blockRegister = [blockRegister copy];
        
        [self myDefaultSettings];
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
        
    }
    return self;
}

- (void)myDefaultSettings {
    [self myAddTapGesture:^{
        [self endEditing:YES];
    }];
}

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    [self addSubview:self.loginBackView];
    [self.loginBackView addSubview:self.logoImageView];
    myWeakSelf;
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(pSelf);
        make.top.equalTo(pSelf).offset(SCALE_HEIGHT(120));
        make.width.equalTo(@(pSelf.width/2));
        make.height.equalTo(@(pSelf.width/2 * 3/7));
    }];
    
//    [self addSubview:self.emailView];
//    [self.emailView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(pSelf);
//        make.top.equalTo(pSelf.logoImageView).offset(20);
//        make.width.equalTo(@(pSelf.width*2/3));
//        make.height.equalTo(@(50));
//    }];
//    
//    [self addSubview: self.passwordView];
//    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(pSelf);
//        make.top.equalTo(pSelf.emailView).offset(20);
//        make.width.equalTo(pSelf.emailView);
//        make.height.equalTo(pSelf.emailView);
//    }];
    
}

- (UIImageView *)loginBackView {
    if (!_loginBackView) {
        _loginBackView = [UIImageView myCommonSettingsWithFrame:self.frame withImage:[UIImage myImageNamed:@"_YM_LOGIN_BACK_IMAGE_"] withEnableUserInteract:YES];
    }
    return _loginBackView;
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [UIImageView myCommonSettingsWithFrame:CGRectZero withImage:myImage(@"_YM_LOGO_WHITE_", YES) withEnableUserInteract:YES];
//        _logoImageView.backgroundColor = [UIColor whiteColor];
    }
    return _logoImageView;
}

- (NSMutableDictionary *)dictionaryValues {
    if (!_dictionaryValues) {
        _dictionaryValues = [NSMutableDictionary dictionary];
    }
    return _dictionaryValues;
}

- (MYTextfieldView *)emailView {
    if (!_emailView) {
        _emailView = [[MYTextfieldView alloc] initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH - 40, 50) withType:MYEditElementTypeEmail];
        myWeakSelf;
        _emailView.BlockDidInput = ^(NSString *stringText, MYEditElementType type) {
            [pSelf.dictionaryValues setObject:stringText forKey:_YM_EMAIL_KEY_];
        };
    }
    return _emailView;
}

- (MYTextfieldView *)passwordView {
    if (!_passwordView) {
        _passwordView = [[MYTextfieldView alloc] initWithFrame:CGRectMake(20, self.emailView.bottom + 10, SCREEN_WIDTH - 40, 50) withType:MYEditElementTypeEmail];
        myWeakSelf;
        _passwordView.BlockDidInput = ^(NSString *stringText, MYEditElementType type) {
            [pSelf.dictionaryValues setObject:stringText forKey:_YM_PASSWORD_KEY_];
        };
    }
    return _passwordView;
}

@end
