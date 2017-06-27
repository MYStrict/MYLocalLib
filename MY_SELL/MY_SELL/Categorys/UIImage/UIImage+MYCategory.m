//
//  UIImage+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/8.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "UIImage+MYCategory.h"

#import <Accelerate/Accelerate.h>

@implementation UIImage (MYCategory)

+ (instancetype)myGenerateImageWithColor:(UIColor *)color {
    return [self myGenerateImageWithColor:color withSize:.0f];
}

+ (instancetype)myGenerateImageWithColor:(UIColor *)color withSize:(CGFloat)floatSize {
    if (floatSize <= .0f) {
        floatSize = 1.f;
    }
    
    CGRect rect = CGRectMake(0.0f, 0.0f, floatSize, floatSize);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage * imageGenerate = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageGenerate;
}

- (instancetype)myGaussianImage {
    return [self myGaussianImage:_MY_GAUSSIAN_BLUR_VALUE_ withCompleteBlock:nil];
}

- (instancetype)myGaussianImage:(CGFloat)floatValue withCompleteBlock:(void (^)(UIImage *, UIImage *))block {
    __block UIImage * image = [self copy];
    if (!image) {
        return self;
    }
    __block CGFloat floatRadius = floatValue;
    myWeakSelf;
    dispatch_async(dispatch_queue_create("queue_Background", DISPATCH_QUEUE_CONCURRENT), ^{
        if (floatRadius < .0f || floatRadius > 1.f) {
            floatRadius = 0.5f;
        }
        int boxSize = (int)(floatRadius * 40);
        boxSize = boxSize - (boxSize % 2) + 1;
        CGImageRef img = image.CGImage;
        
        vImage_Buffer inBuffer, outBuffer;
        vImage_Error error;
        void * pixelBuffer = NULL;
        
        CGDataProviderRef inProvider = CGImageGetDataProvider(img);
        CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
        
        inBuffer.width = CGImageGetWidth(img);
        inBuffer.height = CGImageGetHeight(img);
        
        inBuffer.data = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
        
        if (pixelBuffer == NULL) {
            MYLog(@"No pixelbuffer");
        }
        outBuffer.data = pixelBuffer;
        outBuffer.width = CGImageGetWidth(img);
        outBuffer.height = CGImageGetHeight(img);
        outBuffer.rowBytes = CGImageGetBytesPerRow(img);
        
        error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        
        if (error) {
            MYLog(@"error from convolution %ld", error);
        }
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef ctx = CGBitmapContextCreate(
                                                 outBuffer.data,
                                                 outBuffer.width,
                                                 outBuffer.height,
                                                 8,
                                                 outBuffer.rowBytes,
                                                 colorSpace,
                                                 kCGImageAlphaNoneSkipLast);
        CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
        UIImage * imageProcessed = [UIImage imageWithCGImage:imageRef];
        
        //clean up
        CGContextRelease(ctx);
        CGColorSpaceRelease(colorSpace);
        
        free(pixelBuffer);
        CFRelease(inBitmapData);
        
        CGColorSpaceRelease(colorSpace);
        CGImageRelease(imageRef);
        
        _MY_Safe_UI_Block(block, ^{
            block(pSelf, imageProcessed);
        });
        
    });
    return self;
}

+ (instancetype)myImageNamed:(NSString *)stringImageName {
    return [self myImageNamed:stringImageName withIsFile:false];
}

+ (instancetype)myImageNamed:(NSString *)stringImageName withIsFile:(BOOL)isFile {
    return [self myImageNamed:stringImageName withIsFile:isFile withRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)myImageNamed:(NSString *)stringImageName withIsFile:(BOOL)isFile withRenderingMode:(UIImageRenderingMode)mode {
    UIImage * image = isFile ? [UIImage imageWithContentsOfFile:stringImageName] : [UIImage imageNamed:stringImageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)myImageNamed:(NSString *)stringImageName withIsFile:(BOOL)isFile withRenderingMode:(UIImageRenderingMode)mode withResizableCapInsets:(UIEdgeInsets)insets {
    UIImage * image = [self myImageNamed:stringImageName withIsFile:isFile withRenderingMode:mode];
    return [image resizableImageWithCapInsets:insets];
}

- (NSData *)myImageDataStreamWithBlock:(void (^)(UIImageType, NSData *))block {
    NSData * data = nil;
    if (self && [self isKindOfClass:[UIImage class]]) {
        if ((data = UIImagePNGRepresentation(self))) {
            _MY_Safe_Block_(block, ^{
                block(UIImageTypePNG, data);
            });
        }else if ((data = UIImageJPEGRepresentation(self, _MY_IMAGE_JPEG_COMPRESSION_QUALITY_))) {
            _MY_Safe_Block_(block, ^{
                block(UIImageTypeJPEG, data);
            });
        }else {
            _MY_Safe_Block_(block, ^{
                block(UIImageTypeUnknow, data);
            });
        }
    }
    return data;
}

- (UIImageType)myImageType {
    NSData * dataImage = [self myImageDataStreamWithBlock:nil];
    if (dataImage.length > 4) {
        const unsigned char * bytes = [dataImage bytes];
        if (bytes[0] == 0xff && bytes[1] == 0xd8 && bytes[2] == 0xff) {
            return UIImageTypeJPEG;
        }
        if (bytes[0] == 0x89 && bytes[1] == 0x50 && bytes[2] == 0x4e && bytes[3] == 0x47) {
            return UIImageTypePNG;
        }
    }
    return UIImageTypeUnknow;
}

- (NSData *)myCompressQuality {
    return [self myCompressQuality: _MY_IMAGE_JPEG_COMPRESSION_QUALITY_SIZE_];
}

- (NSData *)myCompressQuality:(CGFloat)floatQuality {
    NSData * dataOrigin = [self myImageDataStreamWithBlock:nil];
    if (!dataOrigin) {
        return nil;
    }
    NSData * dataCompress = dataOrigin;
    NSData * dataResult = dataOrigin;
    
    long long lengthData = dataCompress.length;
    NSInteger i = 0;
    for (NSInteger j = 0; j < 10 ; j++) {
        if (lengthData/1034.f > 300.f) {
            ++i;
            NSData * dataTemp = UIImageJPEGRepresentation(self, 1.f - (++ i) * .1f);
            dataResult = dataTemp;
            lengthData = dataResult.length;
            continue;
            break;
        }
    }
    return dataResult;
}

- (BOOL)myIsOverLimit_3M {
    return [self myIsOverLimit:2.9f];
}

- (BOOL)myIsOverLimit:(CGFloat)floatMBytes {
    NSData * data = [self myImageDataStreamWithBlock:nil];
    return [data length] / pow(1024, 2) > floatMBytes;
}



@end

















