//
//  MYCollectionViewDelegateDataSource.m
//  MY_SELL
//
//  Created by yanma on 2017/6/6.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import "MYCollectionViewDelegateDataSource.h"

@implementation MYCollectionViewDelegate

- (id<UICollectionViewDelegate>)initWithDefaultSettings {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.blockDidSelect) {
        if (self.blockDidSelect(collectionView, indexPath)) {
            [collectionView deselectItemAtIndexPath:indexPath animated:false];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.blockDidHightedCell) {
        self.blockDidHightedCell(collectionView, indexPath);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.blockDidUnhigntedCell) {
        self.blockDidUnhigntedCell(collectionView, indexPath);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.blockMinimumLineSpacingInSection ? self.blockMinimumLineSpacingInSection(collectionView , collectionViewLayout , section) : .0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.blockMinimumInteritemSpacingInSection ? self.blockMinimumInteritemSpacingInSection (collectionView , collectionViewLayout , section) : .0f;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.blockSpacingBetweenSections ? self.blockSpacingBetweenSections(collectionView , collectionViewLayout , section) : UIEdgeInsetsZero ;
}


@end

@implementation MYCollectionViewDataSource

- (id<UICollectionViewDataSource>)initWithDefaultSettings {
    if (self = [super init]) {
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.blockSections ? self.blockSections(collectionView) : 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.blockItemsInSections ? self.blockItemsInSections(collectionView, section) : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString * stringCellIndentifier = self.blockCellIndentifier ? self.blockCellIndentifier(collectionView, indexPath) : @"CELL";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:stringCellIndentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] init];
    }
    return self.blockConfigCell ? self.blockConfigCell(collectionView , cell, indexPath) : cell;
}

_MY_DETECT_DEALLOC_


@end
