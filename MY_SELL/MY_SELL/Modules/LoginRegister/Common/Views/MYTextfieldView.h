//
//  MYTextfieldView.h
//  MY_SELL
//
//  Created by yanma on 2017/6/26.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MYEditElementType) {
    MYEditElementTypeNone = 0,
    MYEditElementTypeEmail,
    MYEditElementTypePassword,
    MYEditElementTypeRePassword
};

@interface MYTextfieldView : UIView

- (instancetype) initWithFrame:(CGRect)frame
                      withType: (MYEditElementType) type;

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, assign) CGFloat floatHeight;
@property (nonatomic, assign) CGFloat space;
@property (nonatomic, copy) void(^BlockDidInput)(NSString * stringText, MYEditElementType type);

@end
