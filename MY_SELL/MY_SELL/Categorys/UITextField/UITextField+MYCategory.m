//
//  UITextField+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/8.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "UITextField+MYCategory.h"

@implementation UITextField (MYCategory)

+ (UITextField *)myCommonSettingsWithFrame:(CGRect)reactFrame {
    return [self myCommonSettingsWithFrame:reactFrame withDelegate:nil];
}

+ (UITextField *)myCommonSettingsWithFrame:(CGRect)reactFrame withDelegate:(id)delegate {
    UITextField * textField = [[UITextField alloc] initWithFrame:reactFrame];
    textField.textColor = [UIColor whiteColor];
    textField.clearsOnBeginEditing = YES;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.font = [UIFont systemFontOfSize:_MY_DEFAULT_FONT_SIZE_];
    if (delegate) {
        textField.delegate = delegate;
    }
    return textField;
}

- (void)mySetRightViewWithImageName:(NSString *)stringImageName {
    UIImage * image = [myImage(stringImageName, YES) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView sizeToFit];
    self.rightViewMode = UITextFieldViewModeAlways;
    self.rightView = imageView;
}

- (BOOL)myResignFirstResponder {
    BOOL isCan = [self canResignFirstResponder];
    if (isCan) {
        [self myResignFirstResponder];
    }
    return isCan;
}


@end
