//
//  MYCollectionViewDelegateDataSource.h
//  MY_SELL
//
//  Created by yanma on 2017/6/6.
//  Copyright © 2017年 yanma. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface MYCollectionViewDelegate : NSObject <UICollectionViewDelegateFlowLayout>

- (id < UICollectionViewDelegate >) initWithDefaultSettings;

@property (nonatomic, copy) BOOL (^blockDidSelect)(UICollectionView * collectionView, NSIndexPath * indexPath);
@property (nonatomic, copy) void (^blockDidHightedCell)(UICollectionView * collectionView, NSIndexPath * indexPath);
@property (nonatomic, copy) void (^blockDidUnhigntedCell)(UICollectionView * collectionView, NSIndexPath * indexPath);
@property (nonatomic, copy) CGFloat (^blockMinimumLineSpacingInSection)(UICollectionView * collectionView, UICollectionViewLayout * layout, NSInteger integerSection);
@property (nonatomic, copy) CGFloat (^blockMinimumInteritemSpacingInSection)(UICollectionView * collectionView, UICollectionViewLayout * layout, NSInteger integerSection);
@property (nonatomic, copy) UIEdgeInsets (^blockSpacingBetweenSections)(UICollectionView * collectionView, UICollectionViewLayout * layout, NSInteger integerSection);

@end


@interface MYCollectionViewDataSource : NSObject <UICollectionViewDataSource>

- (id <UICollectionViewDataSource>) initWithDefaultSettings;

@property (nonatomic, copy) NSInteger (^blockSections)(UICollectionView * collectionView);
@property (nonatomic, copy) NSInteger (^blockItemsInSections)(UICollectionView * collectionView, NSInteger integerSections);
@property (nonatomic, copy) NSString * (^blockCellIndentifier)(UICollectionView * collectionView, NSIndexPath * indexPath);
@property (nonatomic, copy) UICollectionViewCell * (^blockConfigCell)(UICollectionView * collectionView, UICollectionViewCell * cellConfig, NSIndexPath * indexPath);

@end
