//
//  MYTextfieldView.m
//  MY_SELL
//
//  Created by yanma on 2017/6/26.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYTextfieldView.h"

@interface MYTextfieldView ()<UITextFieldDelegate>


@property (nonatomic, assign) MYEditElementType type;

- (void) myDefaultSettings;

@end

@implementation MYTextfieldView

- (instancetype)initWithFrame:(CGRect)frame withType:(MYEditElementType)type {
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        [self myDefaultSettings];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.imageView];
    [self addSubview:self.textField];
}

#pragma mark - Private
- (void)myDefaultSettings {
    self.space = self.height * 1/6;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
}

#pragma mark - Setter
- (void)setFloatHeight:(CGFloat)floatHeight {
    _floatHeight = floatHeight;
}

#pragma mark - Getter
- (UIImageView *)imageView {
    if (!_imageView) {
        CGFloat floatSpace = self.height * 1/4;
        _imageView = [UIImageView myCommonSettingsWithFrame:CGRectMake(5, floatSpace, self.height - 2*floatSpace, self.height - 2*floatSpace) withImage:myImage(@"", false)];
        _imageView.backgroundColor = [UIColor cyanColor];
    }
    return _imageView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField myCommonSettingsWithFrame:CGRectMake(self.imageView.right + 5, 0, self.width - self.imageView.width - 10, self.height)];
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeyNext;
        _textField.textColor = [UIColor whiteColor];
        switch (self.type) {
            case MYEditElementTypeEmail: {
                _textField.placeholder =  myLocalize(@"please_input_email", @"请输入邮箱");
            }   break;
            case MYEditElementTypePassword: {
                _textField.placeholder = myLocalize(@"please_input_password", @"请输入密码");
            }   break;
            case MYEditElementTypeRePassword: {
                _textField.placeholder = myLocalize(@"please_input_password_again", @"请再次输入密码");
            }   break;
            default:
                return  _textField;
                break;
        }
    }
    return _textField;
}

@end
