//
//  MYMethodDef.h
//  MY_SELL
//
//  Created by yanma on 2017/6/1.
//  Copyright © 2017年 yanma. All rights reserved.
//

#ifndef MYMethodDef_h
#define MYMethodDef_h

//#pragma mark - Methods

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define SCALW_WIDTH(VALUE) (((CGFloat)(VALUE))/ 750.f * [[UIScreen mainScreen] bounds].size.width)
#define SCALE_HEIGHT(VALUE) (((CGFloat)(VALUE))/ 1334.f * [[UIScreen mainScreen] bounds].size.height)

//Appearance
#define _MY_NAVIGATION_HEIGHT_ 44.0f
#define _MY_NAVIGATION_Y_ 64.0f
#define _MY_TABBAR_HEIGHT_ 49.f

#define _MY_MAIN_COLOR_HEX_ 0xDC1729
#define _MY_MAIN_COLOR_ myHexColor(_MY_MAIN_COLOR_HEX_, 1.0f)

//JPEG 压缩比
#define _MY_IMAGE_JPEG_COMPRESSION_QUALITY_ 1.f
//大小限制 kb
#define _MY_IMAGE_JPEG_COMPRESSION_QUALITY_SIZE_ 400.f
//精度
#define _MY_IMAGE_JPEG_COMPRESSION_QUALITY_SCALE_ .1f

//iPhone 7 Basic 1334.f * 750.f
#define MY_DYNAMIC_WIDTH(VALUE) (((CGFloat)(VALUE)) / 750.f * [[UIScreen mainScreen] bounds].size.width)
#define MY_DYNAMIC_HEIGHT(VALUE) (((CGFloat)(VALUE)) / 1334.f * [[UIScreen mainScreen] bounds].size.height)

#define MY_DYNAMIC_NAVIGATION_BAR_ITEM_HEIGHT(VALUE) (((CGFloat)(VALUE)) / 90.f * _MY_NAVIGATION_HEIGHT)

#define MY_DYNAMIC_WIDTH_SCALE(VALUE)  (((CGFloat)(VALUE)) / 750.f)
#define MY_DYNAMIC_HEIGHT_SCALE(VALUE) (((CGFloat)(VALUE)) / 1334.f)F

#define _MY_DEFAULT_FONT_SIZE_ 11.0f
#define _MY_DEFAULT_TITLE_FONT_SIZE_ 12.0f
#define _MY_SYSTEM_FONT_SIZE_ 17.0f

#define _MY_REQUEST_MAXIMUN_COUNT_ 5
#define _MY_GAUSSIAN_BLUR_VALUE_ .1f

#define _MY_NETWORK_OVER_TIME_INTERVAL_ 30.0f

#define _MY_MAIN_LOOP_TIMER_ 3.5f
#define _MY_MAIN_LOOP_MAX_SECTIONS_ 1000
#define _MY_ALERT_DISMISS_INTERVAL_ 1.f
#define _MY_MON_DEFEAULT_BUTTON_COUNTS_ 4

#endif /* MYMethodDef_h */
