//
//  UIImageView+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/22.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (MYCategory)

+ (instancetype) myCommonSettingsWithFrame: (CGRect) rectFrame;

+ (instancetype) myCommonSettingsWithFrame:(CGRect)rectFrame withImage: (UIImage *) image;

+ (instancetype) myCommonSettingsWithFrame:(CGRect)rectFrame withImage:(UIImage *)image withEnableUserInteract: (BOOL) isEnable;

- (instancetype) myGussianImage;
- (instancetype) myGussianImageWithComplete : (dispatch_block_t) block;
- (instancetype) myViewWithGaussianBlurValue : (CGFloat) floatValue
                           withCompleteBlock : (dispatch_block_t) block; // 高斯模糊, 只在 UIImageView 下起效

@end

@interface NSArray (MYGifExtension)

+ (NSArray *) myRefreshGifImageArray ;

@end
