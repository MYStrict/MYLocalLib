//
//  UIImagePickerController+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/6.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MYImagePickerSupportType) {
    MYImagePickerSupportTypeNone = 0, //用户锁定访问权限
    MYImagePickerSupportTypeAll, // 所有
    MYImagePickerSupportTypePhotoLibrary,  //图库
    MYImagePickerSupportTypeCamera,  //相机
    MYImagePickerSupportTypePhotosAlbum  //相册（保存图片）
};

typedef NS_ENUM(NSInteger, MYImagePickerPresentType) {
    MYImagePickerPresentTypeNone = 0,  //无操作
    MYImagePickerPresentTypeCamera,  //弹出相机
    MYImagePickerPresentTypePhotoLibrary,  //弹出图库
    MYImagePickerPresentTypePhotoAlbum //弹出相册
};

typedef NS_ENUM(NSInteger, MYImageSaveType) {
    MYImageSaveTypeNone = 0,
    MYImageSaveTypeOriginalImage,
    MYImageSaveTypeEditedImage,
    MYImageSaveTypeAll
};

//image存在， arrayTypes 是支持类型集合，不存在即不支持类型集合
typedef void(^BlockSaveError)(NSError * error);
typedef MYImageSaveType(^BlockCompleteHandler)(UIImage * imageOrigin, UIImage * imageEdited, CGRect rectCrop, NSArray<NSNumber *> * arrayTypes);  //YES 保存到相册
typedef void(^BlockCancelPick)();

@interface UIImagePickerController (MYCategory) <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (instancetype) myImagePickWithTYPE: (MYImagePickerPresentType) typePresent withCompleteHandler: (BlockCompleteHandler) blockComplete withCancel: (BlockCancelPick) blockCancel withSaveError: (BlockSaveError) blockError;

- (NSArray *) mySupportType;

@property (nonatomic, copy) BlockCompleteHandler blockCompleteHandler;
@property (nonatomic, copy) BlockCancelPick blockCancelPick;
@property (nonatomic, copy) BlockSaveError blockSaveError;

@end



