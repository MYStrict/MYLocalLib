//
//  MYMethodRequest.h
//  MY_SELL
//
//  Created by yanma on 2017/6/1.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MYNetTools.h"

typedef NS_ENUM(NSInteger, MYLinkHintType) {
    MYLinkHintTypeSucceed = 0,
    MYLinkHintTypeServerHint,  //服务器提示
    MYLinkHintTypeUnknow,  //未知错误
    MYLinkHintTypeFail,  //失败
    MYLinkHintTypeOverTime,   //超时
    MYLinkHintTypeOffline,   //
    MYLinkHintTypeInterError,  //服务器内部错误
    MYLinkHintTypeRelogin,   //重新上线（单点登录）
    MYLinkHintTypeInfoError   //信息错误
};

typedef NS_ENUM(NSInteger, MYLinkEndType) {
    MYLinkEndTypeOperate = 0, //用户手动进行了刷新或者上拉操作
    MYLinkEndTypeRefresh,   //下拉刷新， 结束
    MYLinkEndTypeLoadMore,  //上拉加载更多， 结束
    MYLinkEndTypeErrorEnd   //出现错误，结束请求
};

typedef void(^blockResult)(MYLinkHintType type, NSDictionary * dictionary, NSError * error);// dictionary 和 error 之间为互斥 , 只有一个有值

typedef NSDictionary * (^blockUpload)();

@interface MYMethodRequest : NSObject

+ (instancetype) sharedMethodRequest;

#pragma mark - LoginAndRegister
//login
- (NSURLSessionDataTask *) myGetLoginData: (NSString *) urlString
                                withParam: (NSDictionary *) paramDic
                        withCompleteBlock: (blockResult) blockResult;

@end










