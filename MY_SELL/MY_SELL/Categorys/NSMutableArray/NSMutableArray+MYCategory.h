//
//  NSMutableArray+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/2.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MYCategory)

@property (nonatomic, strong) NSString * stringClass;

- (void) myAddObject: (id) object;

- (void) myAddObject: (id) object
           withClass: (Class) clazz;

- (void) myAddObjects: (NSMutableArray *) arrayObjects
            withClass: (Class) clazz;

- (void) myRemoveObject: (id) object
              withClass: (Class) clazz;

- (void) myRemoveObject: (id) object
    withCompleteHandler: (dispatch_block_t) block;

- (void) myRemoveAllObject: (BOOL(^)(BOOL isClass, id object)) block
                             withClass: (Class) clazz;

- (void) myAddObjects: (NSMutableArray *) array
  withCompleteHandler: (dispatch_block_t) block;

@property (nonatomic, copy) void(^blockChange) (id value, NSInteger integerTotalCount);

@property (nonatomic, copy) dispatch_block_t blockComplete;

@end
