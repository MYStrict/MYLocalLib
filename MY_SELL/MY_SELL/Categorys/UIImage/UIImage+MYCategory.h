//
//  UIImage+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/8.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIImageType ) {
    UIImageTypeUnknow = 0,
    UIImageTypeJPEG,
    UIImageTypePNG
};


@interface UIImage (MYCategory)

+ (instancetype) myGenerateImageWithColor: (UIColor *) color;
+ (instancetype) myGenerateImageWithColor:(UIColor *)color withSize: (CGFloat) floatSize;

- (instancetype) myGaussianImage;
- (instancetype) myGaussianImage: (CGFloat) floatValue withCompleteBlock: (void(^)(UIImage * imageOrigin, UIImage * imageProcessed)) block;

+ (instancetype) myImageNamed: (NSString *) stringImageName;
+ (instancetype) myImageNamed:(NSString *)stringImageName withIsFile: (BOOL) isFile;
+ (instancetype) myImageNamed:(NSString *)stringImageName withIsFile: (BOOL) isFile withRenderingMode: (UIImageRenderingMode) mode;
+ (instancetype) myImageNamed:(NSString *)stringImageName withIsFile:(BOOL)isFile withRenderingMode:(UIImageRenderingMode)mode withResizableCapInsets: (UIEdgeInsets) insets;

- (NSData *) myImageDataStreamWithBlock: (void (^)(UIImageType type, NSData * dataImage)) block;
- (UIImageType) myImageType; //先转换为 NSData 再进行判断，若需要用到 data , 用上面的就行

///只针对UIImage
- (NSData *) myCompressQuality;
- (NSData *) myCompressQuality: (CGFloat) floatQuality; //压缩大小限制，单位kb
- (BOOL) myIsOverLimit_3M; // iOS 是千进制，  所以 3M 限制定在2.9
- (BOOL) myIsOverLimit: (CGFloat) floatMBytes;

@end
