//
//  MYNationHandler.h
//  MY_SELL
//
//  Created by yanma on 2017/6/23.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYBaseHandler.h"


@class MYNationModel;

@interface MYNationHandler : MYBaseHandler

+ (instancetype) sharedNationHandler ;

- (void) ymSetNationWithNationID : (NSString *) stringNationID
             withCompleteHandler : (blockCompleteSingleValue) block ;

- (void) ymGetNaionListWithHandler : (blockCompleteHandler) block ;

- (NSArray *) ymNationLists ; // 获得所有 国家列表

- (MYNationModel *) ymMainNation ; // 获得当前选中 国家

- (NSString *) ymMainNationCountry ;

/// 根据 nation id 查找国家 .
- (void) ymGetNationModel : (NSString *) stringNationId
         withCompleteBock : (void(^)(MYNationModel *model)) block ;

// 选中后调用设置国家 .
- (void) ymSetMainNation : (MYNationModel *) model
     withCompleteHandler : (dispatch_block_t) block ;

- (void) ymUpdateWithInsertComplete : (dispatch_block_t) blockInsertion
                 withDeleteComplete : (dispatch_block_t) blockDelete ;
- (void) ymStopNotification ;

@property (nonatomic , copy) void(^blockMainNationCompletionHandler)(MYNationModel * model) ;
@property (nonatomic , copy) dispatch_block_t blockReloadNation ;

extern NSString * const _YM_NATION_CHANGE_NOTIFICATION_ ;
extern NSString * const _YM_NATION_SET_NATION_KEY_ ;

extern NSString * const _YM_NATION_SET_MAIN_NOTIFICATION_ ;
extern NSString * const _YM_NATION_SET_MAIN_NATION_KEY_ ;

@end
