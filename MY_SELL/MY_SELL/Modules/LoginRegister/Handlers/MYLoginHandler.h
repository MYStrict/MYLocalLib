//
//  MYLoginHandler.h
//  MY_SELL
//
//  Created by yanma on 2017/6/6.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYBaseHandler.h"

@interface MYLoginHandler : MYBaseHandler

- (void) myGetLoginData: (NSDictionary *) paramDic
      withCompleteBlock: (blockCompleteHandler) handler;

@end
