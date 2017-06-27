//
//  NSMutableArray+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/2.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "NSMutableArray+MYCategory.h"

#import "NSArray+MYCategory.h"
#import <objc/runtime.h>

const char * _MY_ARRAY_ASSOCIATE_KEY_;
const char * _MY_ARRAY_OBSERVER_KEY_;
const char * _MY_ARRAY_OPERATE_COMPLETE_KEY_;

@implementation NSMutableArray (MYCategory)

- (void)myAddObject:(id)object {
    BOOL isCanAdd = NO;
    if (self.stringClass) {
        isCanAdd = [object isKindOfClass:NSClassFromString(self.stringClass)];
    }else isCanAdd = YES;
    
    if (isCanAdd && object) {
        [self addObject:object];
        if (self.blockChange) {
            self.blockChange(object, self.count);
        }
        if (self.blockComplete) {
            self.blockComplete();
        }
    }
}

- (void)myAddObject:(id)object withClass:(Class)clazz {
    BOOL isCanAdd = NO;
    if (clazz) {
        isCanAdd = [object isKindOfClass:clazz];
    }else if (self.stringClass) {
        isCanAdd = [object isKindOfClass:NSClassFromString(self.stringClass)];
    }else isCanAdd = YES;
    
    if (isCanAdd && object) {
        [self addObject:object];
        if (self.blockChange) {
            self.blockChange(object, self.count);
        }
        if (self.blockComplete) {
            self.blockComplete();
        }
    }
}

- (void)myAddObjects:(NSMutableArray *)arrayObjects withClass:(Class)clazz {
    if (!arrayObjects || !arrayObjects.count) {
        return;
    }
    
    for (id object in arrayObjects) {
        BOOL isCanAdd = NO;
        if (clazz) {
            isCanAdd = [object isKindOfClass:clazz];
        }else if (self.stringClass) {
            isCanAdd = [object isKindOfClass:NSClassFromString(self.stringClass)];
        }else isCanAdd = YES;
        
        if (isCanAdd && object) {
            [self addObject:object];
            if (self.blockChange) {
                self.blockChange(arrayObjects, self.count);
            }
        }

        if (self.blockComplete) {
            self.blockComplete();
        }
    }
}

- (void)myRemoveObject:(id)object withClass:(Class)clazz {
    BOOL isCanRemove = NO;
    if (clazz) {
        isCanRemove = [object isKindOfClass:clazz];
    }else if (self.stringClass) {
        isCanRemove = [object isKindOfClass:NSClassFromString(self.stringClass)];
    }else isCanRemove = YES;
    
    if (isCanRemove) {
        if (self.count && [self containsObject:object]) {
            [self removeObject:object];
            if (self.blockChange) {
                self.blockChange(object, self.count);
            }
            if (self.blockComplete) {
                self.blockComplete();
            }
        }
    }
    
}

- (void)myRemoveObject:(id)object withCompleteHandler:(dispatch_block_t)block {
    if (![self isKindOfClass:[NSMutableArray class]]) {
        return;
    }
    if (self.myIsArrayValued) {
        if ([self containsObject:object]) {
            [self removeObject:object];
            if (block) {
                block();
            }
            if (self.blockComplete) {
                self.blockComplete();
            }
        }
    }
}

- (void)myRemoveAllObject:(BOOL (^)(BOOL, id))block withClass:(Class)clazz {
    if (!self.count) {
        return;
    }
    
    for (NSUInteger i = 0; i < self.count; i++) {
        id object = self[i];
        BOOL isCanRemove = NO;
        if (clazz) {
            isCanRemove = [object isKindOfClass:clazz];
        }else if (self.stringClass) {
            isCanRemove = [object isKindOfClass:NSClassFromString(self.stringClass)];
        }else isCanRemove = YES;
        
        if (block) {
            if ([self containsObject:object]) {
                if (block(isCanRemove, object)) {
                    if (self.blockChange) {
                        self.blockChange(object, self.count);
                    }
                }
            }
        }
    }
    
    if (self.blockComplete) {
        self.blockComplete();
    }
}

- (void)myAddObjects:(NSMutableArray *)array withCompleteHandler:(dispatch_block_t)block {
    [self addObjectsFromArray:array];
    if (block) {
        block();
    }
    if (self.blockComplete) {
        self.blockComplete();
    }
}


#pragma mark - Setter
- (void)setStringClass:(NSString *)stringClass {
    /*
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
     id object                     :表示关联者，是一个对象，变量名理所当然也是object
     const void *key               :获取被关联者的索引key
     id value                      :被关联者，这里是一个block
     objc_AssociationPolicy policy : 关联时采用的协议(关联策略)，有assign，retain，copy等协议，还有这种关联是原子的还是非原子的,一般使用OBJC_ASSOCIATION_RETAIN_NONATOMIC
     */
    objc_setAssociatedObject(self, &_MY_ARRAY_ASSOCIATE_KEY_, stringClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBlockChange:(void (^)(id, NSInteger))blockChange {
    if (blockChange) {
        objc_setAssociatedObject(self, &_MY_ARRAY_OBSERVER_KEY_, blockChange, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)setBlockComplete:(dispatch_block_t)blockComplete {
    if (blockComplete) {
        objc_setAssociatedObject(self, &_MY_ARRAY_OPERATE_COMPLETE_KEY_, blockComplete, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

#pragma mark - Getter
- (NSString *)stringClass {
    /*
        通过key获取被关联对象
     */
   return objc_getAssociatedObject(self, &_MY_ARRAY_ASSOCIATE_KEY_);
}

- (void (^)(id, NSInteger))blockChange {
    return objc_getAssociatedObject(self, &_MY_ARRAY_OBSERVER_KEY_);
}

- (dispatch_block_t)blockComplete {
    return objc_getAssociatedObject(self, &_MY_ARRAY_OPERATE_COMPLETE_KEY_);
}


/*
    断开关联
    1）使用objc_setAssociatedObject函数，传入nil值即可
    objc_setAssociatedObject(self, &_MY_ARRAY_ASSOCIATE_KEY_, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    断开所有关联，慎用
    2）objc_removeAssociatedObjects可以断开所有关联，通常情况下不建议使用这个函数，因为他会断开所有关联。只有在需要把对象恢复到“原始状态”的时候才会使用这个函数。
 */



@end



