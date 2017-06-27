//
//  WKWebView+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/26.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "WKWebView+MYCategory.h"

@implementation WKWebView (MYCategory)


+ (instancetype) myInitWithFrame : (CGRect) rectFrame {
    return [self myInitWithFrame:rectFrame withDelegate:nil];
}

+ (instancetype) myInitWithFrame : (CGRect)rectFrame
                    withDelegate : (id) delegate {
    return [self myInitWithFrame:rectFrame withConfiguration:nil withDelegate:delegate];
}

+ (instancetype) myInitWithFrame : (CGRect)rectFrame
               withConfiguration : (WKWebViewConfiguration *) configuration
                    withDelegate : (id) delegate {
    WKWebView *webView = nil;
    if (configuration) {
        webView = [[WKWebView alloc] initWithFrame:rectFrame
                                     configuration:configuration];
    } else webView = [[WKWebView alloc] initWithFrame:rectFrame];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    webView.autoresizesSubviews = YES;
    webView.allowsBackForwardNavigationGestures = YES;
    webView.scrollView.alwaysBounceVertical = YES;
    webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    if (delegate) {
        webView.navigationDelegate = delegate;
    }
    return webView;
}

- (WKNavigation *) myLoadRequest : (NSString *) stringRequest {
    return [self loadRequest:[NSURLRequest requestWithURL:myURL(stringRequest, false)]];
}

- (WKNavigation *) myLoadHTMLString : (NSString *) stringHTML {
    if ([stringHTML isKindOfClass:[NSString class]])
        if (stringHTML.myIsStringValued)
            return [self loadHTMLString:stringHTML
                                baseURL:nil];
    return nil;
}

@end
