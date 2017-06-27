//
//  UICollectionViewFlowLayout+MYCategory.h
//  MY_SELL
//
//  Created by yanma on 2017/6/7.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewFlowLayout (MYCategory)

+ (instancetype) myCollectionViewLayoutWithItemSize: (CGSize) sizeItem;

+ (instancetype) myCollectionViewLayoutWithItemSize:(CGSize)sizeItem
                                   withSectionInset: (UIEdgeInsets) edgeInsets;

+ (instancetype) myCollectionViewLayoutWithItemSize:(CGSize)sizeItem
                                   withSectionInset:(UIEdgeInsets)edgeInsets
                                     withHeaderSize: (CGSize) sizeHeader;

@end
