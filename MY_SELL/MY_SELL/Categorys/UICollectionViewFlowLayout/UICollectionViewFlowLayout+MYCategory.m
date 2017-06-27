
//
//  UICollectionViewFlowLayout+MYCategory.m
//  MY_SELL
//
//  Created by yanma on 2017/6/7.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "UICollectionViewFlowLayout+MYCategory.h"

@implementation UICollectionViewFlowLayout (MYCategory)

+ (instancetype)myCollectionViewLayoutWithItemSize:(CGSize)sizeItem {
    return [self myCollectionViewLayoutWithItemSize:sizeItem withSectionInset:UIEdgeInsetsZero withHeaderSize:CGSizeZero];
}

+ (instancetype)myCollectionViewLayoutWithItemSize:(CGSize)sizeItem withSectionInset:(UIEdgeInsets)edgeInsets {
    return [self myCollectionViewLayoutWithItemSize:sizeItem withSectionInset:edgeInsets withHeaderSize:CGSizeZero];
}

+ (instancetype)myCollectionViewLayoutWithItemSize:(CGSize)sizeItem withSectionInset:(UIEdgeInsets)edgeInsets withHeaderSize:(CGSize)sizeHeader {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = sizeItem;
    if (!UIEdgeInsetsEqualToEdgeInsets(edgeInsets, UIEdgeInsetsZero)) {
        layout.sectionInset = edgeInsets;
    }
    layout.sectionInset = edgeInsets;
    if (!CGSizeEqualToSize(sizeHeader, CGSizeZero)) {
        layout.headerReferenceSize = sizeHeader;
    }
    
    return layout;
}

@end
