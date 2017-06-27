//
//  MYScrollToTopView.m
//  MY_SELL
//
//  Created by yanma on 2017/6/22.
//  Copyright © 2017年 yanma. All rights reserved.
//


#import "MYScrollToTopView.h"

#pragma mark - -----------------------------------------------------------------

@interface MYScrollToTopView ()

@property (nonatomic , strong) UIImageView *imageViewScrollToTop ;
@property (nonatomic , assign) CGRect rectBounds ;
@property (nonatomic , assign) BOOL isBottom ;
@property (nonatomic , copy) UIView *(^blockView)() ;

- (void) myDefaultSettings ;

@end

@implementation MYScrollToTopView

- (instancetype) initWithBounds : (CGRect) rectBounds
                   withPosition : (BOOL) isBottom
                   withSubViews : (UIView *(^)()) blockView {
    if (self = [super initWithFrame:(CGRect){CGPointZero , 50 , 50}]) {
        self.rectBounds = rectBounds;
        self.isBottom = isBottom;
        self.blockView = [blockView copy];
        [self myDefaultSettings];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.imageViewScrollToTop];
    self.width = self.imageViewScrollToTop.width;
    self.height = self.imageViewScrollToTop.height;
    self.bottom = self.rectBounds.size.height - ((self.isBottom ? 0 : _MY_TABBAR_HEIGHT_) + MY_DYNAMIC_HEIGHT(22.f));
    self.right = CGRectGetMaxX(self.rectBounds) - MY_DYNAMIC_WIDTH(22.f);
}

- (void) myDefaultSettings {
    
}

#pragma mark - Getter
- (UIImageView *)imageViewScrollToTop {
    if (_imageViewScrollToTop) return _imageViewScrollToTop;
    _imageViewScrollToTop = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageViewScrollToTop.image = myImage(@"_YM_IMAGE_SCROLL_TO_TOP_", YES);
//    _imageViewScrollToTop = [UIImageView myCommonSettingsWithFrame:self.bounds withImage:myImage(@"_YM_IMAGE_SCROLL_TO_TOP_", YES)];
    _imageViewScrollToTop.backgroundColor = [UIColor clearColor];
    [_imageViewScrollToTop sizeToFit];
    
    myWeakSelf;
    void (^blockScrollToTop)(NSArray *arraySubviews) = ^(NSArray *arraySubviews) {
        for (id obj in arraySubviews) {
            if (![obj isKindOfClass:[UIScrollView class]]) continue;
            UIScrollView *scrollView = (UIScrollView *) obj;
            [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x,
                                                     - (pSelf.floatOffSet > 0 ? pSelf.floatOffSet : 0))
                                animated:YES];
            return ;
        }
    };
    [_imageViewScrollToTop myAddTapGesture:^{
        if (pSelf.blockView) {
            if (blockScrollToTop) {
                blockScrollToTop(pSelf.blockView().subviews);
            }
        }
    }];
    
    return _imageViewScrollToTop;
}

_MY_DETECT_DEALLOC_

@end
