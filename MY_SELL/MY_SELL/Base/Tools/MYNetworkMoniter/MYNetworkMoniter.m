//
//  MYNetworkMoniter.m
//  MY_SELL
//
//  Created by yanma on 2017/6/15.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYNetworkMoniter.h"

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>

#import <CoreTelephony/CTTelephonyNetworkInfo.h>

static MYNetworkMoniter * _moniter = nil;

NSString * const _MY_NETWORK_STATUS_CHANGE_NOTIFICATION_ = @"MY_NETWORK_STATUS_CHANGE_NOTIFICATION";
NSString * const _MY_NETWORK_STATUS_KEY_NEW_ = @"MY_NETWORK_STATUS_KEY_NEW";
NSString * const _MY_NETWORK_STATUS_KEY_OLD_ = @"MY_NETWORK_STATUS_KEY_OLD";

@interface MYNetworkMoniter ()

@property (nonatomic, strong) AFNetworkActivityIndicatorManager * activityManager;
@property (nonatomic, strong) AFNetworkReachabilityManager * reachabilityManager;
@property (nonatomic, strong) CTTelephonyNetworkInfo * networkInfo;

@property (nonatomic, strong, readonly) NSArray * arrayString_2G;
@property (nonatomic, strong, readonly) NSArray * arrayString_3G;
@property (nonatomic, strong, readonly) NSArray * arrayString_4G;

- (void) myReachabilityMoniter;

- (MYNetworkEnvironment) myCaptureCurrentEnvironmentWithStatus: (AFNetworkReachabilityStatus) status;


@end

@implementation MYNetworkMoniter

+ (instancetype) sharedNetworkMoniter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _moniter = [[MYNetworkMoniter alloc] init];
        [_moniter myReachabilityMoniter];
    });
    return _moniter;
}

- (void) myReachabilityMoniter {
    self.activityManager = [AFNetworkActivityIndicatorManager sharedManager];
    self.activityManager.enabled = YES;
    [[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:_MY_NETWORK_STATUS_KEY_OLD_];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _moniter.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    __weak typeof(self) pSelf = self;
    [_moniter.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [pSelf myCaptureCurrentEnvironmentWithStatus:status];
    }];
    [_moniter.reachabilityManager startMonitoring];
}

- (MYNetworkEnvironment) myCaptureCurrentEnvironmentWithStatus:(AFNetworkReachabilityStatus)status {
    NSString * stringAccess = self.networkInfo.currentRadioAccessTechnology;
    MYNetworkEnvironment environment = MYNetworkEnvironmentUnknow;
    if ([[UIDevice currentDevice] systemVersion].floatValue > 7.f) {
        if ([self.arrayString_4G containsObject:stringAccess]) {
            environment = MYNetworkEnvironment4G;
        }else if ([self.arrayString_3G containsObject:stringAccess]) {
            environment = MYNetworkEnvironment3G;
        }else if ([self.arrayString_2G containsObject:stringAccess]) {
            environment = MYNetworkEnvironment2G;
        }
    }else environment = (MYNetworkEnvironment) status;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:_MY_NETWORK_STATUS_CHANGE_NOTIFICATION_ object:nil userInfo:@{_MY_NETWORK_STATUS_KEY_NEW_ : @(status), _MY_NETWORK_STATUS_KEY_OLD_ : @([[NSUserDefaults standardUserDefaults] integerForKey:_MY_NETWORK_STATUS_KEY_OLD_])}];
    
    [[NSUserDefaults standardUserDefaults] setInteger:status forKey:_MY_NETWORK_STATUS_KEY_NEW_];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return environment;
}

- (MYNetworkEnvironmentType) myEnvironmentType {
    NSInteger integerStatus = [[NSUserDefaults standardUserDefaults] integerForKey:_MY_NETWORK_STATUS_KEY_NEW_];
    if (integerStatus <= 0) {
        return MYNetworkEnvironmentTypeNotConnected;
    }
    if (integerStatus == 1 || integerStatus == 3 || integerStatus ==4) {
        return MYNetworkEnvironmentTypeWeak;
    }
    if (integerStatus == 2 || integerStatus == 5) {
        return MYNetworkEnvironmentTypeStrong;
    }
    return MYNetworkEnvironmentTypeStrong;
}

#pragma mark - Getter
- (CTTelephonyNetworkInfo *)networkInfo {
    if (!_networkInfo) {
        _networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    }
    return _networkInfo;
}

- (NSArray *)arrayString_2G {
    return @[CTRadioAccessTechnologyEdge,
             CTRadioAccessTechnologyGPRS,
             CTRadioAccessTechnologyCDMA1x];
}

- (NSArray *)arrayString_3G {
    return @[CTRadioAccessTechnologyHSDPA,
             CTRadioAccessTechnologyWCDMA,
             CTRadioAccessTechnologyHSUPA,
             CTRadioAccessTechnologyCDMAEVDORev0,
             CTRadioAccessTechnologyCDMAEVDORevA,
             CTRadioAccessTechnologyCDMAEVDORevB,
             CTRadioAccessTechnologyeHRPD];
}
- (NSArray *)arrayString_4G {
    return @[CTRadioAccessTechnologyLTE];
}

@end
