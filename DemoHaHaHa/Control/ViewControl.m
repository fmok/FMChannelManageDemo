//
//  ViewControl.m
//  DemoHaHaHa
//
//  Created by fm on 2017/7/18.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ViewControl.h"

NSString *const kMyCollectionViewCellIdentifier = @"MyCollectionViewCell";
NSString *const kFirsTitleSectionHeaderViewIdentifier = @"FirsTitleSectionHeaderView";
NSString *const kSecondTitleSectionHeaderViewIdentifier = @"SecondTitleSectionHeaderView";

@implementation ViewControl

#pragma mark - Public methods
- (void)registerCell
{
    [self.vc.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:kMyCollectionViewCellIdentifier];
    [self.vc.collectionView registerClass:[FirsTitleSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kFirsTitleSectionHeaderViewIdentifier];
    [self.vc.collectionView registerClass:[SecondTitleSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSecondTitleSectionHeaderViewIdentifier];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.vc.subDataArr.count;
    } else if (section == 1) {
    } else {
        NSArray *arr = self.vc.unSubDataArr[section-2];
        return arr.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMyCollectionViewCellIdentifier forIndexPath:indexPath];
    NSString *titleStr = nil;
    if (indexPath.section == 0) {
        titleStr = self.vc.subDataArr[indexPath.item];
        [cell updateContent:titleStr];
        cell.currentType = MyCollectionViewCellTypeMul;
    } else if (indexPath.section == 1) {
        cell = nil;
    } else {
        titleStr = self.vc.unSubDataArr[indexPath.section-2][indexPath.item];
        [cell updateContent:titleStr];
        cell.currentType = MyCollectionViewCellTypeAdd;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return 1+1+self.vc.unSubDataArr.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        FirsTitleSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kFirsTitleSectionHeaderViewIdentifier forIndexPath:indexPath];
        headerView.currentStyle = FirsTitleSectionHeaderViewStyleEdit;
        [headerView updateContent:@"我订阅的频道"];
        return headerView;
    } else if (indexPath.section == 1) {
        FirsTitleSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kFirsTitleSectionHeaderViewIdentifier forIndexPath:indexPath];
        headerView.currentStyle = FirsTitleSectionHeaderViewStyleNormal;
        [headerView updateContent:@"未订阅的频道"];
        return headerView;
    } else {
        SecondTitleSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSecondTitleSectionHeaderViewIdentifier forIndexPath:indexPath];
        [headerView updateContent:[NSString stringWithFormat:@"频道-%@", @(indexPath.section-2)]];
        return headerView;
    }
    return nil;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section >= 2) {
        return CGSizeMake(Screen_W, 30);
    }
    return CGSizeMake(Screen_W, 50);
}

#pragma mark - FMCollectionViewFlowLayoutDelegate
- (void)moveDataItem:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    if (toIndexPath.section > 0) return;
    NSObject *obj = self.vc.subDataArr[fromIndexPath.item];
    [self.vc.subDataArr removeObjectAtIndex:fromIndexPath.item];
    [self.vc.subDataArr insertObject:obj atIndex:toIndexPath.item];
    NSLog(@"\n*** subDataArr exchange %@ & %@ : ***\n %@ \n", @(fromIndexPath.item), @(toIndexPath.item), self.vc.subDataArr);
}

- (void)beginResponseToLongPress
{
    
}


@end
