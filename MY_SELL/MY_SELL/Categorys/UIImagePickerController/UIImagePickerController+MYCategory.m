//
//  UIImagePickerController+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/6.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "UIImagePickerController+MYCategory.h"

#import "MYCommonDefine.h"
#import "MYCommonTools.h"

#import <objc/runtime.h>

const char * _MY_IMAGE_PICKER_BLOCK_COMPLETE_HANDLER_KEY_;
const char * _MY_IMAGE_PICKER_BLOCK_CANCEL_KEY;
const char * _MY_IMAGE_PICKER_BLOCK_SAVE_;

@implementation UIImagePickerController (MYCategory)

- (instancetype)myImagePickWithTYPE:(MYImagePickerPresentType)typePresent withCompleteHandler:(BlockCompleteHandler)blockComplete withCancel:(BlockCancelPick)blockCancel withSaveError:(BlockSaveError)blockError {
    NSArray * arraSupport = self.mySupportType;
    if ([arraSupport containsObject:@(MYImagePickerSupportTypeNone)]) {
        _MY_Safe_UI_Block(blockComplete, ^{
            blockComplete(nil, nil, CGRectNull, arraSupport);
        });
        return nil;
    }
    BOOL isSupportAll = [arraSupport containsObject:@(MYImagePickerSupportTypeAll)];
    MYImagePickerSupportType typeUnsupport = -1;

    switch (typePresent) {
        case MYImagePickerPresentTypeNone:{
            return nil;
        }break;
        case MYImagePickerPresentTypeCamera:{
            if (isSupportAll || [arraSupport containsObject:@(MYImagePickerPresentTypeCamera)]) {
                self.sourceType = UIImagePickerControllerSourceTypeCamera;
                self.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
                self.showsCameraControls = YES;
            }else {
                typeUnsupport = MYImagePickerSupportTypeCamera;
            }
        }break;
        case MYImagePickerPresentTypePhotoAlbum:{
            if (isSupportAll || [arraSupport containsObject:@(MYImagePickerPresentTypePhotoAlbum)]) {
                self.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }else {
                typeUnsupport = MYImagePickerSupportTypePhotosAlbum;
            }
        }break;
        case MYImagePickerPresentTypePhotoLibrary: {
            if (isSupportAll || [arraSupport containsObject:@(MYImagePickerPresentTypePhotoLibrary)]) {
                self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }else typeUnsupport = MYImagePickerSupportTypePhotoLibrary;
        }break;
        default:{
            return nil;
        }break;
    }
    if ((NSInteger) typeUnsupport > 0) {
        _MY_Safe_UI_Block(blockComplete, ^{
            blockComplete(nil, nil, CGRectNull, @[@(typeUnsupport)]);
        });
        return nil;
    }
    
    self.delegate = self;
    self.allowsEditing = YES;
    self.blockCompleteHandler = [blockComplete copy];
    self.blockCancelPick = [blockCancel copy];
    self.blockSaveError = [blockError copy];
    return self;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    myWeakSelf;
    _MY_Safe_UI_Block(self.blockCompleteHandler, ^{
        NSArray * arraySupport = pSelf.mySupportType;
        MYImageSaveType typeSave = pSelf.blockCompleteHandler(info[@"UIImagePickerControllerOriginalImage"], info[@"UIImagePickerControllerEditedImage"], [info[@"UIImagePickerControllerCropRect"] CGRectValue], arraySupport);
        switch (typeSave) {
            case MYImageSaveTypeNone:
                return;
                break;
            case MYImageSaveTypeOriginalImage: {
                UIImageWriteToSavedPhotosAlbum(info[@"UIImagePickerControllerOriginalImage"], self, @selector(image: didFinishSavingWithError: contextInfo:), nil);
            }break;
            default:
                break;
        }
    });
    
}


@end

















