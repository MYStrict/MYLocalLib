//
//  MYNetworkMoniter.h
//  MY_SELL
//
//  Created by yanma on 2017/6/15.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MYNetworkEnvironment) {
    MYNetworkEnvironmentUnknow = -1,
    MYNetworkEnvironmentFail = 0,
    MYNetworkEnvironmentWLAN = 1,
    MYNetworkEnvironmentWIFI = 2,
    MYNetworkEnvironment2G = 3,
    MYNetworkEnvironment3G = 4,
    MYNetworkEnvironment4G = 5
};

typedef NS_ENUM(NSInteger, MYNetworkEnvironmentType) {
    MYNetworkEnvironmentTypeStrong = 0,
    MYNetworkEnvironmentTypeWeak,
    MYNetworkEnvironmentTypeNotConnected
};

@interface MYNetworkMoniter : NSObject

+ (instancetype) sharedNetworkMoniter;

- (MYNetworkEnvironmentType) myEnvironmentType;

extern NSString * const _MY_NETWORK_STATUS_CHANGE_NOTIFICATION_;
extern NSString * const _MY_NETWORK_STATUS_KEY_NEW_;
extern NSString * const _MY_NETWORK_STATUS_KEY_OLD_;

@end
