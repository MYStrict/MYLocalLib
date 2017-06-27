//
//  WKWebView+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/26.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (MYCategory)

+ (instancetype) myInitWithFrame : (CGRect) rectFrame ;

+ (instancetype) myInitWithFrame : (CGRect)rectFrame
                    withDelegate : (id) delegate ;

+ (instancetype) myInitWithFrame : (CGRect)rectFrame
               withConfiguration : (WKWebViewConfiguration *) configuration
                    withDelegate : (id) delegate;

- (WKNavigation *) myLoadRequest : (NSString *) stringRequest ;

- (WKNavigation *) myLoadHTMLString : (NSString *) stringHTML ;

@end
