//
//  MYBaseHandler.h
//  MY_SELL
//
//  Created by yanma on 2017/6/1.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MYMethodRequest.h"
#import "MYRequestParams.h"
#import "MYNetTools.h"

@class UIViewController;

typedef NS_ENUM(NSInteger, MYUserHintType) {
    MYUserHintTypeNone = 0,
    MYUserHintTypeAlreadyHinted,  //已经由系统提示过
    MYUserHintTypeBackground, //在后台处理-》不提示
    MYUserHintTypeUnknow,  //未知
    MYUserHintTypeInterError, //内部错误
    MYUserHintTypeOverTime,  //超时
    MYUserHintTypeOffline,  //掉线
    MYUserHintTypeRelogin, //重新登录
    MYUserHintTypeInfoError
};

typedef void(^blockDicCompleteHandler)(MYUserHintType type, NSDictionary * dicData);
typedef void(^blockCompleteHandler)(MYUserHintType type, NSMutableArray * arrayData);
typedef void(^blockCompleteSingleValue)(MYUserHintType type, id value);

@interface MYBaseHandler : NSObject

@property (nonatomic, strong) NSMutableArray * arrayDataRequest;
@property (nonatomic, strong) MYMethodRequest * methodRequest;
@property (nonatomic, copy) dispatch_block_t blockReloadData;

- (void) myAddRequest: (NSURLSessionDataTask *) dataTask;
- (void) myAddRequests: (NSMutableArray <NSURLSessionDataTask *> *) arrayRequests;

- (void) myHintUser: (MYUserHintType) type withCompleteBlock: (void(^)(MYUserHintType type)) block;
- (BOOL) myIsNeedHint: (MYUserHintType) type;

- (MYUserHintType) myTransferWithLinkType: (MYLinkHintType) type;

- (void) myCancel;
- (void) myAdd: (NSURLSessionDataTask *) dataTask;

@end
