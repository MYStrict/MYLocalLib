//
//  MYLoginElementView.h
//  MY_SELL
//
//  Created by yanma on 2017/6/8.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MYLoginElemetViewInputType) {
    MYLoginElemetViewInputTypeNone = 0,
    MYLoginElemetViewInputTypeEmail,
    MYLoginElemetViewInputTypePassword,
    MYLoginElemetViewInputTypeRePassword,
};

@interface MYLoginElementView : UIView

- (instancetype) initWithType: (MYLoginElemetViewInputType) type;

@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, assign) CGFloat floatHeight;
@property (nonatomic, copy) void(^blockDidInput)(NSString * stringText, MYLoginElemetViewInputType type);

@end
