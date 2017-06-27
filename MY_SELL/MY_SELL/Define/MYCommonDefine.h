//
//  MYCommonDefine.h
//  MY_SELL
//
//  Created by yanma on 2017/6/1.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MYMethodDef.h"

@class UIColor;
@class UIImage;

@interface MYCommonDefine : NSObject

#if DEBUG
    #define _MY_DEBUG_MODE_ 1
#else 
    #define _MY_DEBUG_MODE_ 0
#endif

#if TARGET_IPHONE_SIMULATOR
    #define _MY_IS_SIMULATOR_ 1
#else
    #define _MY_IS_SIMULATOR_ 0
#endif

#if 1
#if _MY_DEBUG_MODE_
#define MYLog(fmt , ...) NSLog((@"\n\n_MY_LOG_\n\n_YM_FILE_  %s\n_MY_METHOND_  %s\n_MY_LINE_  %d\n" fmt),__FILE__,__func__,__LINE__,##__VA_ARGS__)
#else
    #define MYLog(fmt , ...) /* */
    #endif
#else
    #define MYLog(fmt , ...) /* */
#endif

#define _MY_DETECT_DEALLOC_ \
- (void)dealloc { \
MYLog(@"_MY_%@_DEALLOC_", NSStringFromClass([self class]));\
} \

#define myWeakSelf __weak typeof(&*self) pSelf = self

#define iOS(version) ([UIDevice currentDevice].systemVersion.doubleValue >= (version))

// 字符串格式化
#define myStringFormat(...) [NSString stringWithFormat:__VA_ARGS__]
// 字符串融合 , 干掉 nil , 不能使用集合类 .
#define myMergeObject(...) myObjMerge(__VA_ARGS__ , nil)
// 字符串转化
#define myStringTransfer(...) myStringFormat(@"%@",myMergeObject(__VA_ARGS__))
// 便捷 LOG
#define _MY_Log(...) MYLog(@"%@",myStringTransfer(__VA_ARGS__))
/// 判断非空
#define myIsNull(VALUE) (!VALUE || [VALUE isKindOfClass:[NSNull class]])


void _MY_Safe_Block_ (id blockNil, dispatch_block_t block);
void _MY_Safe_UI_Block (id blockNil, dispatch_block_t block);
void _MY_UI_Operate_Block (dispatch_block_t block);


UIColor * myHexColor(int intValue, float floatAlpha);

UIColor * myRGBColor(float floatR, float floatG, float floatB);
UIColor * myRGBAColor(float floatR, float floatG, float floatB, float floatA);

NSURL * myURL(NSString * stringURL, BOOL isLocalFile);

UIImage *myImage(NSString *stringName , BOOL isCacheInMemory);

NSString * myObjMerge(id obj, ...);

NSString * myLocalize(NSString * stringLocalKey, NSString * stringCommont);


@end























