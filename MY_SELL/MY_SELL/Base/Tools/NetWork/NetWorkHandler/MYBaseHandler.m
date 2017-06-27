//
//  MYBaseHandler.m
//  MY_SELL
//
//  Created by yanma on 2017/6/1.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYBaseHandler.h"

#import "NSMutableArray+MYCategory.h"
#import "MBProgressHUD+MYCategory.h"

@implementation MYBaseHandler

- (void)myAddRequest:(NSURLSessionDataTask *)dataTask {
    [self.arrayDataRequest myAddObject:dataTask withClass:[NSURLSessionDataTask class]];
}

- (void)myAddRequests:(NSMutableArray<NSURLSessionDataTask *> *)arrayRequests {
    [self.arrayDataRequest myAddObjects:arrayRequests withClass:[NSURLSessionDataTask class]];
}

- (void)myHintUser:(MYUserHintType)type withCompleteBlock:(void (^)(MYUserHintType))block {
    NSString * stringTitle = myLocalize(@"prompt", @"提示");
    NSString * stringMessage = nil;
    switch (type) {
        case MYUserHintTypeNone:
            return;
            break;
        case MYUserHintTypeUnknow: {
            stringMessage = myLocalize(@"_YM_HINT_USER_ERROR_UNKNOW_NETWORK_", @"未知网络错误");
        }break;
        case MYUserHintTypeInterError: {
            stringMessage = myLocalize(@"", @"网络数据异常");
        }break;
        case MYUserHintTypeOverTime: {
            stringMessage = myLocalize(@"", @"网络请求超时 , 请检查当前网络环境");
        }break;
        case MYUserHintTypeRelogin: {
            stringMessage = myLocalize(@"", @"您长时间未登录 , 请重新登录");
        }break;
        case MYUserHintTypeInfoError: {
            stringMessage = myLocalize(@"", @"账户信息有误");
        }break;
        case MYUserHintTypeAlreadyHinted: {
            _MY_Safe_UI_Block(block, ^{
                block(type);
            });
            return;
        }break;
            
        default:
            return;
            break;
    }
    
    [MBProgressHUD myShowTitle:stringTitle withMessage:stringMessage withCompleteBlock:^{
        _MY_Safe_UI_Block(block, ^{
            block(type);
        });
    }];
    
}

- (BOOL)myIsNeedHint:(MYUserHintType)type {
    return (type != MYUserHintTypeNone && type != MYUserHintTypeBackground && type != MYUserHintTypeOffline);
}

- (MYUserHintType)myTransferWithLinkType:(MYLinkHintType)type {
    switch (type) {
        case MYLinkHintTypeSucceed: {
            return MYUserHintTypeNone;
        }break;
        case MYLinkHintTypeServerHint:{
            return MYUserHintTypeAlreadyHinted;
        }break;
        case MYLinkHintTypeUnknow:{
            return MYUserHintTypeUnknow;
        }break;
        case MYLinkHintTypeFail:{
            return MYUserHintTypeUnknow;
        }break;
        case MYLinkHintTypeOverTime:{
            return MYUserHintTypeOverTime;
        }break;
        case MYLinkHintTypeOffline:{
            return MYUserHintTypeOffline;
        }break;
        case MYLinkHintTypeRelogin:{
            return MYUserHintTypeRelogin;
        }break;
        case MYLinkHintTypeInterError:{
            return MYUserHintTypeInterError;
        }break;
        case MYLinkHintTypeInfoError:{
            return MYUserHintTypeInfoError;
        }break;
        default:{
            return MYUserHintTypeUnknow;
        }break;
    }
}

- (void)myCancel {
    if (!self.arrayDataRequest || !self.arrayDataRequest.count) {
        return;
    }
    id object = [self.arrayDataRequest lastObject];
    if ([object isKindOfClass:[NSURLSessionDataTask class]]) {
        NSURLSessionDataTask * dataTask = (NSURLSessionDataTask *)object;
        if (dataTask.state != NSURLSessionTaskStateCompleted) {
            [dataTask cancel];
            [self.arrayDataRequest removeLastObject];
        }
    }
}

- (void)myAdd:(NSURLSessionDataTask *)dataTask {
    [self.arrayDataRequest myAddObject:dataTask withClass:[NSURLSessionDataTask class]];
}

#pragma mark - Getter
- (NSMutableArray *)arrayDataRequest {
    if (!_arrayDataRequest) {
        _arrayDataRequest = [NSMutableArray array];
    }
    return _arrayDataRequest;
}

- (MYMethodRequest *)methodRequest {
    if (!_methodRequest) {
        _methodRequest = [MYMethodRequest sharedMethodRequest];
    }
    return _methodRequest;
}


@end












