//
//  MYNetTools.h
//  MY_SELL
//
//  Created by yanma on 2017/5/31.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;

typedef NS_ENUM(NSInteger, MYLinkType) {
    MYLinkTypeNone = 0,
    MYLinkTypeOptmize,
    MYLinkTypeDebug
};

typedef NS_ENUM(NSInteger, MYLogType) {
    MYLogTypeNone = 0,
    MYLogTypeManualLogout,
    MYLogTypeKickedOut,
    MYLogTypeSessionInvalued
};

typedef void(^BlockProgress)(NSProgress * progress);
typedef void(^BlockSuccess)(NSURLSessionDataTask * task, id responseObject);
typedef void(^BlockFailure)(NSURLSessionDataTask * task, NSError * error);
typedef NSDictionary *(^BlockAppendData)();

@interface MYNetTools : NSObject

+ (instancetype) sharedMYNetTools;

+ (instancetype) sharedMYNetToolsIfDebug: (MYLinkType) type;

@property (nonatomic, strong) AFHTTPSessionManager * sessionManager;
@property (nonatomic, strong) NSURLSessionDataTask * sessionDataTaskCurrent; //当前正在进行的网络请求
@property (nonatomic, readonly) NSString * stringBaseDomain;

@property (nonatomic, copy) void (^blockLogout)(MYLogType type);

- (NSString *) myFullURLWithPath: (NSString *) stringPath;
- (NSString *) myFullURLWithPath: (NSString *) stringPath withIsSecure: (BOOL) isSecure;

- (NSURLSessionDataTask *) myGetWithLink: (NSString *) stringLink
                          withParameters: (id) params
                            withProgress: (BlockProgress) blockProgress
                             withSuccess: (BlockSuccess) blockSuccess
                             withFailure: (BlockFailure) blockFailure;

- (NSURLSessionDataTask *) myPostWithLink: (NSString *) stringLink
                          withParameters: (id) params
                            withProgress: (BlockProgress) blockProgress
                             withSuccess: (BlockSuccess) blockSuccess
                             withFailure: (BlockFailure) blockFailure;

- (NSURLSessionDataTask *) myUploadFileWithLink: (NSString *) stringLink
                                 withParameters: (id) params
                                   withMimeType: (NSString *) stringMimeType
                                  withDataBlock: (BlockAppendData) blockData // file 名称为 key , value 为 nsdata 类型
                                   withProgress: (BlockProgress) blockProgress
                                    withSuccess: (BlockSuccess) blockSuccess
                                    withFailure: (BlockFailure) blockFailure;


/**
 清除之前的所有基于AFN的网络请求
 */
- (void) myCancelAllRequests;

//extern外部变量，以供其他类使用
extern NSString * const _MY_DATA_KEY_;
extern NSString * const _MY_ERROR_KEY_;
extern NSString * const _MY_STATE_KEY_;
extern NSString * const _MY_TYPE_KEY_;
extern NSString * const _MY_EXTRA_KEY_;
extern NSString * const _MY_GOODS_KEY_;
extern NSString * const _MY_PPT_KEY_;
extern NSString * const _MY_VALUE_KEY_;
extern NSString * const _MY_MEMBER_KEY_;
extern NSString * const _MY_KEY_;

extern NSString * const _MY_LOGOUT_KICKED_NOTIFICATION_ ;
extern NSString * const _MY_UPLOAD_MIME_TYPE_IMAGE_PNG_ ;
extern NSString * const _MY_UPLOAD_MIME_TYPE_IMAGE_JPEG_ ;

@end











