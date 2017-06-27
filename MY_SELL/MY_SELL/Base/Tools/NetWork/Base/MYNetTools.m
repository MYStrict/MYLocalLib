//
//  MYNetTools.m
//  MY_SELL
//
//  Created by yanma on 2017/5/31.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYNetTools.h"

#import <AFNetworking/AFNetworking.h>

static MYNetTools * _tools = nil;

NSString * const _MY_DATA_KEY_ = @"data";
NSString * const _MY_ERROR_KEY_ = @"error";
NSString * const _MY_STATE_KEY_ = @"state";
NSString * const _MY_TYPE_KEY_ = @"type";
NSString * const _MY_EXTRA_KEY_ = @"extra";
NSString * const _MY_GOODS_KEY_ = @"goods";
NSString * const _MY_PPT_KEY_ = @"ppt";
NSString * const _MY_VALUE_KEY_ = @"value";
NSString * const _MY_MEMBER_KEY_ = @"member";
NSString * const _MY_KEY_ = @"key";

NSString * const _MY_LOGOUT_KICKED_NOTIFICATION_ = @"MY_LOGOUT_KICKED_NOTIFICATION";
NSString * const _MY_UPLOAD_MIME_TYPE_IMAGE_PNG_ = @"image/png";
NSString * const _MY_UPLOAD_MIME_TYPE_IMAGE_JPEG_ = @"image/jpeg";

@interface MYNetTools ()

@property (nonatomic, assign) MYLinkType type;
@property (nonatomic, strong, readonly) NSString * stringBaseURL;
@property (nonatomic, strong) NSURL * urlBase;

- (BOOL) myNeedLogout: (id) responseObject;

@end

@implementation MYNetTools

+ (instancetype)sharedMYNetTools {
    return [self sharedMYNetToolsIfDebug:MYLinkTypeOptmize];
}

+ (instancetype)sharedMYNetToolsIfDebug:(MYLinkType)type {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tools = [[MYNetTools alloc] init];
        _tools.type = type;
    });
    return _tools;
}

- (NSString *)myFullURLWithPath:(NSString *)stringPath {
    return [self myFullURLWithPath:stringPath withIsSecure:YES];
}

- (NSString *)myFullURLWithPath:(NSString *)stringPath withIsSecure:(BOOL)isSecure {
    if (!stringPath || !stringPath.length) {
        stringPath = @"";
    }
    if ([stringPath rangeOfString:@"://"].location != NSNotFound) {
        return stringPath;
    }
    NSString * stringHTTP = myMergeObject(@"hppt://", self.stringBaseURL, stringPath);
    NSString * stringHTTPS = myMergeObject(@"https://", self.stringBaseURL, stringPath);
    
    switch (_type) {
        case MYLinkTypeNone:{
#if _MY_DEBUG_MODE_
            return stringHTTP;
#else
            return stringHTTPS;
#endif
        } break;
        case MYLinkTypeOptmize:{
            return stringHTTPS;
        }break;
        case MYLinkTypeDebug:{
            return stringHTTP;
        }break;
            
        default:{
            return stringHTTPS;
        }
            break;
    }
}

- (NSURLSessionDataTask *)myGetWithLink:(NSString *)stringLink withParameters:(id)params withProgress:(BlockProgress)blockProgress withSuccess:(BlockSuccess)blockSuccess withFailure:(BlockFailure)blockFailure {
    myWeakSelf;
    NSURLSessionDataTask * dataTask = [_tools.sessionManager GET:stringLink parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        _MY_Safe_Block_(blockProgress, ^{
            blockProgress(downloadProgress);
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _MY_Safe_Block_(blockSuccess, ^{
            blockSuccess(task, [pSelf myNeedLogout:responseObject]? nil: responseObject);
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _MY_Safe_Block_(blockFailure, ^{
            blockFailure(task, error);
        });
    }];
    _sessionDataTaskCurrent = dataTask;
    return dataTask;
}

- (NSURLSessionDataTask *)myPostWithLink:(NSString *)stringLink withParameters:(id)params withProgress:(BlockProgress)blockProgress withSuccess:(BlockSuccess)blockSuccess withFailure:(BlockFailure)blockFailure {
    myWeakSelf;
    NSURLSessionDataTask * dataTask = [_tools.sessionManager POST:stringLink parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        _MY_Safe_Block_(blockProgress, ^{
            blockProgress(uploadProgress);
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _MY_Safe_Block_(blockSuccess, ^{
            blockSuccess(task, [pSelf myNeedLogout:responseObject]? nil: responseObject);
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _MY_Safe_Block_(blockFailure, ^{
            blockFailure(task, error);
        });
    }];
    _sessionDataTaskCurrent = dataTask;
    return dataTask;
}

- (NSURLSessionDataTask *)myUploadFileWithLink:(NSString *)stringLink withParameters:(id)params withMimeType:(NSString *)stringMimeType withDataBlock:(BlockAppendData)blockData withProgress:(BlockProgress)blockProgress withSuccess:(BlockSuccess)blockSuccess withFailure:(BlockFailure)blockFailure {
    myWeakSelf;
    NSURLSessionDataTask * dataTask = [_tools.sessionManager POST:stringLink parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        _MY_Safe_Block_(blockData, ^{
            NSDictionary * dictionary = blockData();
            if (dictionary) {
                if (dictionary.allKeys.count && dictionary.allValues.count) {
                    id stringKey = dictionary.allKeys.firstObject;
                    id dataValue = dictionary.allValues.firstObject;
                    if ([stringKey isKindOfClass:[NSString class]] && [dataValue isKindOfClass:[NSData class]]) {
                        [formData appendPartWithFileData:dataValue name:stringKey fileName:stringKey mimeType:stringMimeType];
                    }
                }
            }
        });
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        _MY_Safe_Block_(blockProgress, ^{
            blockProgress(uploadProgress);
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _MY_Safe_Block_(blockSuccess, ^{
            blockSuccess(task, [pSelf myNeedLogout:responseObject]? nil: responseObject);
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _MY_Safe_Block_(blockFailure, ^{
            blockFailure(task, error);
        });
    }];
    _sessionDataTaskCurrent = dataTask;
    return dataTask;
}

- (void)myCancelAllRequests {
    [self.sessionManager.operationQueue cancelAllOperations];
}

- (BOOL) myNeedLogout: (id) responseObject {
    NSDictionary * dictionary = nil;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        dictionary = (NSDictionary *)responseObject;
    }else if (![dictionary isKindOfClass:[NSNull class]]) {
        if ([NSJSONSerialization isValidJSONObject:responseObject]) {
            NSError * error;
            dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                return false;
            }
        }
    }
    if ([dictionary[_MY_DATA_KEY_] integerValue] < 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:_MY_LOGOUT_KICKED_NOTIFICATION_ object:nil userInfo:nil];
        NSInteger integerValue = [dictionary[_MY_STATE_KEY_] integerValue];
        myWeakSelf;
        _MY_Safe_UI_Block(pSelf.blockLogout, ^{
            if (integerValue == -1) {
                pSelf.blockLogout(MYLogTypeKickedOut);
            }
            if (integerValue == -2) {
                pSelf.blockLogout(MYLogTypeSessionInvalued);
            }
        });
        return YES;
    }
    return false;
}

#pragma mark - Getter
- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.operationQueue.maxConcurrentOperationCount = _MY_REQUEST_MAXIMUN_COUNT_;
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval = _MY_NETWORK_OVER_TIME_INTERVAL_;
        [_sessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        AFJSONResponseSerializer * serializerResponse = [AFJSONResponseSerializer serializer];
        [serializerResponse setReadingOptions:NSJSONReadingAllowFragments];
        _sessionManager.responseSerializer = serializerResponse;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                                     @"application/json",
                                                                     @"text/json",
                                                                     @"text/jsvascript",
                                                                     @"text/plain",
                                                                     @"text/html",
                                                                     @"application/x-www-form-urlencoded",
                                                                     nil];
    }
    return _sessionManager;
}

- (NSString *)stringBaseURL {
    switch (_type) {
        case MYLinkTypeNone:{
#if _MY_DEBUG_MODE_
            return myMergeObject(self.stringBaseDomain, @"/sub/index.php?");
#else
            return myMergeObject(self.stringBaseDomain , @"/index.php?");
#endif
        }break;
        case MYLinkTypeOptmize:{
            return myMergeObject(self.stringBaseDomain, @"/index.php");
        }break;
        case MYLinkTypeDebug:{
            return myMergeObject(self.stringBaseDomain, @"/sub/index.php?");
        }break;
        default:{
            return myMergeObject(self.stringBaseDomain, @"/index.php");
        }
            break;
    }
}

- (NSString *)stringBaseDomain {
    switch (_type) {
        case MYLinkTypeNone:{
#if _MY_DEBUG_MODE_
            return @"tstarapi.ym.ru";
#else
            return @"starapi.ym.ru";
#endif
        } break;
        case MYLinkTypeOptmize: {
            return @"starapi.ym.ru";
        } break;
        case MYLinkTypeDebug: {
            return @"tstarapi.ym.ru";
        } break;
            
        default: {
            return @"starapi.ym.ru";
        } break;
    }
}

- (NSURL *)urlBase {
    return [NSURL URLWithString:self.stringBaseURL];
}

@end
















