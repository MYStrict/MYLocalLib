//
//  UIImageView+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/22.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "UIImageView+MYCategory.h"

@implementation UIImageView (MYCategory)

+ (instancetype)myCommonSettingsWithFrame:(CGRect)rectFrame {
    return [self myCommonSettingsWithFrame:rectFrame withImage:nil];
}

+ (instancetype)myCommonSettingsWithFrame:(CGRect)rectFrame withImage:(UIImage *)image {
    return [self myCommonSettingsWithFrame:rectFrame withImage:image withEnableUserInteract:false];
}

+ (instancetype)myCommonSettingsWithFrame:(CGRect)rectFrame withImage:(UIImage *)image withEnableUserInteract:(BOOL)isEnable {
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:rectFrame];
    if (image) {
        imageView.image = image;
    }
    imageView.userInteractionEnabled = isEnable;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.contentMode = UIViewContentModeScaleAspectFit;//图片等比例拉伸，可能不会填满
    return imageView;
}

- (instancetype)myGussianImage {
    return [self myGussianImageWithComplete:nil];
}

- (instancetype)myGussianImageWithComplete:(dispatch_block_t)block {
    return [self myViewWithGaussianBlurValue:_MY_GAUSSIAN_BLUR_VALUE_ withCompleteBlock:block];
}

- (instancetype)myViewWithGaussianBlurValue:(CGFloat)floatValue withCompleteBlock:(dispatch_block_t)block {
    UIImage * image = self.image;
    if (!image) {
        return self;
    }
    myWeakSelf;
    [self.image myGaussianImage:floatValue withCompleteBlock:^(UIImage *imageOrigin, UIImage *imageProcessed) {
        pSelf.image = imageProcessed;
        _MY_Safe_UI_Block(block, ^{
            block();
        });
    }];
    return self;
}

@end

@implementation NSArray (MYGifExtension)

+ (NSArray *)myRefreshGifImageArray {
    NSMutableArray *array = [NSMutableArray array];
    for (short i = 1 ; i <= 8; i ++) {
        @autoreleasepool {
            //            NSString *stringPath = [[NSBundle mainBundle] pathForResource:ymMergeObject(@"刷新-",@(i), @"(dragged)")
            //                                                                   ofType:@"tiff"];
            NSString *stringImageName = myStringFormat(@"%@",@(i));
            [array myAddObject:[UIImage imageNamed:stringImageName]];
        }
    }
    return array;
}

@end

















