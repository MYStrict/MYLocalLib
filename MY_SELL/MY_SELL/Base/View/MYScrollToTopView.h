//
//  MYScrollToTopView.h
//  MY_SELL
//
//  Created by yanma on 2017/6/22.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYScrollToTopView : UIView

- (instancetype) initWithBounds : (CGRect) rectBounds
                   withPosition : (BOOL) isBottom
                   withSubViews : (UIView *(^)()) blockView;
@property (nonatomic , assign) CGFloat floatOffSet ;

@end
