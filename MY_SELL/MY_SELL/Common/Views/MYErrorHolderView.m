//
//  MYErrorHolderView.m
//  MY_SELL
//
//  Created by yanma on 2017/6/22.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYErrorHolderView.h"

@interface MYErrorHolderView ()

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UIActivityIndicatorView * indicatorView;

@end

@implementation MYErrorHolderView

- (instancetype) initWithErrorType:(MYErrorViewType)type {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.typeError = type;
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = myHexColor(0xeeeeee, 1.f);
    self.imageView.hidden = false;
    
    switch (self.typeError) {
        case MYErrorViewTypeNone:{
            return;
        }break;
        case MYErrorViewTypeNoData:{
            self.imageView.image = myImage(@"_YM_IMAGE_HAS_NO_ITEMS_", YES);
            self.label.text = myLocalize(@"_YM_HAS_NO_MORE_ITEMS_", @"没有更多商品了");
        }break;
        case MYErrorViewTypeNetworkFail:{
            self.imageView.image = myImage(@"_YM_NET_WORK_FAIL_", YES);
            self.label.text = myLocalize(@"_YM_HINT_USER_ERROR_DISABLE_NETWORK_", @"当前无网络链接");
        }break;
        case MYErrorViewTypeNotFunctional:{
            self.imageView.image = myImage(@"_YM_IMAGE_HAS_NO_ITEMS_", YES);
            self.label.text = myLocalize(@"_YM_TO_BE_CONTINUE_", @"功能暂未开放 , 敬请期待");
        }break;
        case MYErrorViewTypeLoading:{
            self.imageView.hidden = YES;
            [self.indicatorView startAnimating];
            self.label.text = myLocalize(@"loading...", @"加载中"); // d82121
        }break;
        case MYErrorViewTypeHasNoDataCommon:{
            self.imageView.image = myImage(@"_YM_IMAGE_HAS_NO_ITEMS_", YES);
            self.label.text = myLocalize(@"_YM_HAS_NO_DATA_COMMON_", @"功能暂未开放 , 敬请期待");
        }break;
            
        default:{
            return;
        }break;
    }
    
    [self.imageView sizeToFit];
    self.label.width = self.width - MY_DYNAMIC_WIDTH(22.f);
    self.label.height = self.label.mySetEntityAutoHeight;
    
    [self addSubview:self.imageView];
    
    if (self.typeError == MYErrorViewTypeLoading) {
        self.indicatorView.center = self.imageView.center;
        [self addSubview:self.indicatorView];
    }
    
    self.label.centerX = self.inCenterX;
    self.label.top = self.imageView.bottom + MY_DYNAMIC_HEIGHT(44.f);
    [self addSubview:self.label];
}

- (void) myStopAnimation:(MYErrorViewType)type {
    if (self.indicatorView.isAnimating) {
        [self.indicatorView stopAnimating];
    }
    
    [self layoutSubviews];
}

#pragma mark - Setter
- (void)setTypeError:(MYErrorViewType)typeError {
    _typeError = typeError;
    [self layoutSubviews];
}

#pragma mark - Getter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.image = myImage(@"_YM_IMAGE_HAS_NO_ITEMS_", YES);
//        _imageView = [UIImageView myCommonSettingsWithFrame:CGRectZero withImage:myImage(@"_YM_IMAGE_HAS_NO_ITEMS_", YES)];
        _imageView.top = MY_DYNAMIC_HEIGHT(343.f);
    }
    return _imageView;
}

- (UILabel *)label {
    if (_label) return _label;
    _label = [UILabel myLabelCommonSettings:CGRectZero];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = myHexColor(0x979797, 1.f);
    return _label;
}
- (UIActivityIndicatorView *)indicatorView {
    if (_indicatorView) return _indicatorView;
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicatorView.hidesWhenStopped = YES;
    _indicatorView.color = myHexColor(0xD82121, 1.f);
    return _indicatorView;
}


@end
