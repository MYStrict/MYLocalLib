//
//  MYLoginElementView.m
//  MY_SELL
//
//  Created by yanma on 2017/6/8.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYLoginElementView.h"

//#import "UIView+MYCategory.h"
//#import "MBProgressHUD+MYCategory.h"
//#import "UITextField+MYCategory.h"

@interface MYLoginElementView () <UITextFieldDelegate>

@property (nonatomic, assign) MYLoginElemetViewInputType type;
- (void) myDefaultSettigs;

@end

@implementation MYLoginElementView

- (instancetype)initWithType:(MYLoginElemetViewInputType)type {
    if (self = [super initWithFrame:(CGRect){CGPointMake(SCREEN_WIDTH/2, SCREEN_WIDTH/2), SCREEN_WIDTH, MY_DYNAMIC_HEIGHT(84.f)}]) {
        self.type = type;
        [self myDefaultSettigs];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat floatSpace = MY_DYNAMIC_WIDTH(37.f);
    UIView * viewLine = [[UIView alloc] initWithFrame:CGRectMake(floatSpace, 0, self.width - 2 * floatSpace, 1.f)];
    viewLine.bottom = self.height;
    viewLine.backgroundColor = myHexColor(0xDDDDDD, 1.f);
    [self addSubview:self.textField];
}

#pragma mark - Private
- (void)myDefaultSettigs {

}

#pragma mark - Setter
- (void)setFloatHeight:(CGFloat)floatHeight {
    _floatHeight = floatHeight;
    self.height = _floatHeight;
    
}

#pragma mark - Getter
- (UITextField *)textField {
    if (!_textField) {
        CGFloat floatSpace = MY_DYNAMIC_WIDTH(37.f);
        _textField = [UITextField myCommonSettingsWithFrame:CGRectMake(floatSpace, 0, self.width - 2 * floatSpace, self.height - 1.f)];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeyNext;
        _textField.textColor = [UIColor blackColor];
        
        switch (self.type) {
            case MYLoginElemetViewInputTypeEmail: {
                _textField.placeholder =  myLocalize(@"", @"请输入邮箱");
            }   break;
            case MYLoginElemetViewInputTypePassword: {
            _textField.placeholder = myLocalize(@"", @"请输入密码");
            }   break;
            case MYLoginElemetViewInputTypeRePassword: {
            _textField.placeholder = myLocalize(@"", @"请再次输入密码");
            }   break;
            default:
                return  _textField;
                break;
        }
    }
    return _textField;
}



@end
















