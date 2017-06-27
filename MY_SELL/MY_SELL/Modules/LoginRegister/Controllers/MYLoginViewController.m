//
//  MYLoginViewController.m
//  MY_SELL
//
//  Created by yanma on 2017/6/5.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYLoginViewController.h"

#import "MYLoginView.h"
#import "MBProgressHUD+MYCategory.h"

@interface MYLoginViewController ()

@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UIImageView * logoImageView;
@property (nonatomic, strong) MYLoginView * loginView;

- (void) myDefaultSettings;
- (void) mySetStaticUI;


@end

@implementation MYLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self mySetStaticUI];
    [self myDefaultSettings];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UI界面
- (void) mySetStaticUI {
    [self.view addSubview:self.loginView];

}

- (void) myDefaultSettings {
    
}

- (MYLoginView *)loginView {
    myWeakSelf;
    if (!_loginView) {
        _loginView = [[MYLoginView alloc] initWithStatus:^(MYLoginAlertType type) {
            NSString * stringAlert = nil;
            switch (type) {
                case MYLoginAlertTypeNoEmail: {
                    stringAlert = myLocalize(@"", @"请输入邮箱");
                } break;
                case MYLoginAlertTypeNoPasspord: {
                    stringAlert = myLocalize(@"请输入密码", @"");
                } break;
                default: {
                    return ;
                } break;
            }
            
            [MBProgressHUD myShowMessage:stringAlert];
            [pSelf.loginView endEditing:YES];

        }  withLoginBlock:^{
            [pSelf toLogin];
        } withRegisterBlock:^{
            [pSelf toRegisterPage];
        } withForgetBlock:^{
            [pSelf toForgetPage];
        }];

    }
    return _loginView;
}

//登录请求
- (void) toLogin {

}

//找回密码界面跳转
- (void) toForgetPage {

}

//注册界面跳转
- (void) toRegisterPage {

}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [UIImageView myCommonSettingsWithFrame:self.view.frame withImage:myImage(@"_YM_LOGIN_BACK_IMAGE_", false)];
    }
    return _backImageView;
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [UIImageView myCommonSettingsWithFrame:CGRectZero withImage:myImage(@"_YM_LOGO_WHITE_", false)];
    }
    return _logoImageView;
}

@end


