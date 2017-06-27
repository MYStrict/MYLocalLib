//
//  MYErrorHolderView.h
//  MY_SELL
//
//  Created by yanma on 2017/6/22.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , MYErrorViewType) {
    MYErrorViewTypeNone = 0 ,
    MYErrorViewTypeNetworkFail ,
    MYErrorViewTypeNoData ,
    MYErrorViewTypeNotFunctional ,
    MYErrorViewTypeLoading ,
    MYErrorViewTypeHasNoDataCommon
};

@interface MYErrorHolderView : UIView

- (instancetype) initWithErrorType : (MYErrorViewType) type ;
- (void) myStopAnimation : (MYErrorViewType) type ;

@property (nonatomic , assign) MYErrorViewType typeError ;

@end
