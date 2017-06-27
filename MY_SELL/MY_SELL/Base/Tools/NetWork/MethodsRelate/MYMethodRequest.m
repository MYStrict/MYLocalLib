//
//  MYMethodRequest.m
//  MY_SELL
//
//  Created by yanma on 2017/6/1.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYMethodRequest.h"

#import "MYNetTools.h"
#import "NSString+MYCategory.h"

static MYMethodRequest * _methodRequest = nil;

@interface MYMethodRequest ()

@property (nonatomic, strong) MYNetTools * netTools;

- (void) myDefaultSetings;

- (void) mySerilizeWithObject: (blockResult) blockResult
           withResponseObject: (id) responseObject;

- (MYLinkHintType) myHintUserWithDictionary: (NSDictionary *) dictionary
                                 isNeedHint: (BOOL) isHint;

- (void) mySerilizeCurrencyWithDictionary: (NSDictionary *) dictionary;

- (MYLinkHintType) myTransferError: (NSError *) error;

- (NSArray *) myArrayInterError;
- (NSArray *) myArrayDataError;
- (NSArray *) myArrayUnknowError;
- (NSArray *) myArrayOverTime;
- (NSArray *) myArrayAccountError;

@end

@implementation MYMethodRequest

+ (instancetype)sharedMethodRequest {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _methodRequest = [[MYMethodRequest alloc] init];
    });
    return _methodRequest;
}

#pragma mark - LoginAndRegister

- (NSURLSessionDataTask *)myGetLoginData:(NSString *)urlString
                               withParam:(NSDictionary *)paramDic
                       withCompleteBlock:(blockResult)blockResult {
    myWeakSelf;
    urlString = [self.netTools myFullURLWithPath:urlString withIsSecure:YES];
    return [self.netTools myPostWithLink:urlString withParameters:paramDic withProgress:^(NSProgress *progress) {
        
    } withSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        _MY_Safe_Block_(blockResult, ^{
            [pSelf mySerilizeWithObject:blockResult withResponseObject:responseObject];
        });
    } withFailure:^(NSURLSessionDataTask *task, NSError *error) {
        _MY_Safe_Block_(blockResult, ^{
            blockResult([pSelf myTransferError:error], nil, error);
        });
    }];
}








#pragma mark - System

- (instancetype)init {
    if (self = [super init]) {
        [self myDefaultSetings];
    }
    return self;
}

#pragma mark - Private
- (void) mySerilizeWithObject:(blockResult)blockResult withResponseObject:(id)responseObject {
    NSDictionary * dictionary;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        dictionary = (NSDictionary *)responseObject;
    }else if ([responseObject isKindOfClass:[NSNull class]]) {
        _MY_Safe_Block_(blockResult, ^{
            NSError * error = [NSError errorWithDomain:self.netTools.stringBaseDomain code:-101 userInfo:@{_MY_ERROR_KEY_ : @"DATA IS NULL . ( NSNull )"}];
            blockResult(MYLinkHintTypeUnknow, nil, error);
        });
    }else if ([NSJSONSerialization isValidJSONObject:responseObject]) {
        NSError * error = nil;
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            blockResult(MYLinkHintTypeUnknow, nil, error);
            return;
        }
    }else if (responseObject) {
        _MY_Safe_Block_(blockResult, ^{
            NSError * error = [NSError errorWithDomain:self.netTools.stringBaseDomain
                                                  code:-101
                                              userInfo:@{_MY_ERROR_KEY_: @"UNKNOW DATA . ( UNKNOW )"}];
            blockResult(MYLinkHintTypeUnknow, nil, error);
            return ;
        });
    }
    
    [self mySerilizeCurrencyWithDictionary:dictionary];
    _MY_Safe_Block_(blockResult, ^{
        if (![dictionary[_MY_STATE_KEY_] integerValue]) {
            blockResult(MYLinkHintTypeSucceed, dictionary, nil);
        }else {
            NSError * error = [NSError errorWithDomain:self.netTools.stringBaseDomain
                                                  code:[dictionary[_MY_STATE_KEY_] integerValue]
                                              userInfo:@{_MY_ERROR_KEY_: dictionary[_MY_ERROR_KEY_]}];
            blockResult([self myHintUserWithDictionary:dictionary isNeedHint:false], nil, error);
            [self myHintUserWithDictionary:dictionary isNeedHint:YES];
        }
    });
    
}

- (MYLinkHintType)myHintUserWithDictionary:(NSDictionary *)dictionary isNeedHint:(BOOL)isHint {
    if ([dictionary[_MY_TYPE_KEY_] integerValue] == 1 && [dictionary[_MY_TYPE_KEY_] integerValue] != 0) {
        if (isHint) {
            if (![dictionary[_MY_ERROR_KEY_] isKindOfClass:[NSNull class]]) {
                _MY_UI_Operate_Block(^{
                    
                });
            }
        }
        return MYLinkHintTypeServerHint;
    }
    if ([dictionary[_MY_STATE_KEY_] integerValue] !=0) {
        NSString * stringErrorCode = myStringFormat(@"%@",dictionary[_MY_STATE_KEY_]);
        if ([self.myArrayInterError containsObject:stringErrorCode]) {
            return MYLinkHintTypeInterError;
        }
        if ([self.myArrayDataError containsObject:stringErrorCode]) {
            return MYLinkHintTypeInfoError;
        }
        if ([self.myArrayUnknowError containsObject:stringErrorCode]) {
            return MYLinkHintTypeUnknow;
        }
        if ([self.myArrayOverTime containsObject:stringErrorCode]) {
            return MYLinkHintTypeOverTime;
        }
        if ([self.myArrayAccountError containsObject:stringErrorCode]) {
            return MYLinkHintTypeInfoError;
        }
        return MYLinkHintTypeUnknow;
    }
    return MYLinkHintTypeSucceed;
}

- (MYLinkHintType)myTransferError:(NSError *)error {
    if (error.code == -999) {
        return MYLinkHintTypeServerHint;
    }
    if (error.code == -1001) {
        return MYLinkHintTypeOverTime;
    }
    if (error.code == -1009) {
        return MYLinkHintTypeOffline;
    }
    /*
     int abs(int a)  整数的绝对值
     double fabs(double a)  浮点数的绝对值
     */

    if (ABS(error.code) >= 3000 && ABS(error.code) < 4000) {
        return MYLinkHintTypeInterError;
    }
    return MYLinkHintTypeUnknow;
}

- (void)mySerilizeCurrencyWithDictionary:(NSDictionary *)dictionary {
    NSArray * array = dictionary[_MY_EXTRA_KEY_];
    if (![array isKindOfClass:[NSArray class]]) return;
    
}

- (void)myDefaultSetings {
    
}

#pragma mark - Getter
- (MYNetTools *)netTools {
    if (!_netTools) {
        _netTools = [MYNetTools sharedMYNetTools];
    }
    return _netTools;
}

- (NSArray *) myArrayInterError {
    return @[@"10001", @"10002" , @"10003" , @"10005" , @"10006" ,
             @"50004"] ;
}
- (NSArray *) myArrayDataError {
    return @[@"20000" , @"20001" , @"20004" ,
             @"30000" , @"30001" , @"30002" , @"30007" , @"30008" , @"30009"];
}
- (NSArray *) myArrayUnknowError {
    return @[@"40000" , @"40001" , @"40002" , @"40003" ,
             @"50001" , @"50002" , @"50003"];
}
- (NSArray *) myArrayOverTime {
    return @[@"50000"];
}
- (NSArray *) myArrayAccountError {
    return @[ @"10007" ,
              @"20002" , @"20003" ,
              @"30003" , @"30004" , @"30005" , @"30006"];
}

@end
