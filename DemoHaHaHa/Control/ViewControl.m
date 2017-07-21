//
//  ViewControl.m
//  DemoHaHaHa
//
//  Created by fm on 2017/7/18.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ViewControl.h"

#define TAG_first_header 100
#define TAG_second_header 101

NSString *const kMyCollectionViewCellIdentifier = @"MyCollectionViewCell";
NSString *const kFirsTitleSectionHeaderViewIdentifier = @"FirsTitleSectionHeaderView";

@interface ViewControl()
{
    BOOL isEditing;
}

@end

@implementation ViewControl

#pragma mark - Public methods
- (void)registerCell
{
    [self.vc.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:kMyCollectionViewCellIdentifier];
    [self.vc.collectionView registerClass:[FirsTitleSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kFirsTitleSectionHeaderViewIdentifier];
}

#pragma mark - Private methods
- (void)subChannel:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    // 1、更新本地数据源
    NSObject *obj = self.vc.unSubDataArr[indexPath.item];
    [self.vc.unSubDataArr removeObjectAtIndex:indexPath.item];
    // 2、同步远端数据、更新UI
    [self.vc.collectionView performBatchUpdates:^{
//        [self.vc.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        [self.vc.subDataArr addObject:obj];
//        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:self.vc.subDataArr.count-1 inSection:0];
//        [self.vc.collectionView insertItemsAtIndexPaths:@[lastIndexPath]];
        NSIndexPath *sourceIndexPath = [NSIndexPath indexPathForItem:indexPath.item inSection:1];
        NSIndexPath *destinationIndexPath = [NSIndexPath indexPathForItem:self.vc.subDataArr.count-1 inSection:0];
        [self.vc.collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    } completion:^(BOOL finished) {
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
        [self.vc.collectionView reloadSections:set];
    }];
}

- (void)unSubChannel:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    NSLog(@"\n&&& section: %@ , item: %@ , data: %@ &&&\n", @(indexPath.section), @(indexPath.item), self.vc.subDataArr[indexPath.item]);
    // 1、更新本地数据源
    NSObject *obj = self.vc.subDataArr[indexPath.item];
    [self.vc.subDataArr removeObjectAtIndex:indexPath.item];
    // 2、同步远端数据
    // 3、更新UI
    [self.vc.collectionView performBatchUpdates:^{
//        [self.vc.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        [self.vc.unSubDataArr insertObject:obj atIndex:0];
//        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:1];
//        [self.vc.collectionView insertItemsAtIndexPaths:@[firstIndexPath]];
        NSIndexPath *sourceIndexPath = [NSIndexPath indexPathForItem:indexPath.item inSection:0];
        NSIndexPath *destinationIndexPath = [NSIndexPath indexPathForItem:0 inSection:1];
        [self.vc.collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    } completion:^(BOOL finished) {
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
        [self.vc.collectionView reloadSections:set];
    }];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"\n*** cellType: %@ ***\n", @(cell.currentType));
    switch (cell.currentType) {
        case MyCollectionViewCellTypeDefault:
        {
            // 无
        }
            break;
        case MyCollectionViewCellTypeAdd:
        {
            // 订阅频道
            [self subChannel:collectionView indexPath:indexPath];
        }
            break;
        case MyCollectionViewCellTypeMul:
        {
            // 取消订阅
            [self unSubChannel:collectionView indexPath:indexPath];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.vc.subDataArr.count;
    } else if (section == 1) {
        return self.vc.unSubDataArr.count;
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
        cell.currentType = (isEditing ? MyCollectionViewCellTypeMul : MyCollectionViewCellTypeDefault);
    } else if (indexPath.section == 1) {
        titleStr = self.vc.unSubDataArr[indexPath.item];
        [cell updateContent:titleStr];
        cell.currentType = MyCollectionViewCellTypeAdd;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return 2;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FirsTitleSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kFirsTitleSectionHeaderViewIdentifier forIndexPath:indexPath];
    headerView.delegate = self;
    if (indexPath.section == 0) {
        headerView.currentStyle = FirsTitleSectionHeaderViewStyleEdit;
        headerView.tag = TAG_first_header;
        [headerView setEditSelectedState:isEditing];
        [headerView updateContent:@"我订阅的频道"];
    } else if (indexPath.section == 1) {
        headerView.currentStyle = FirsTitleSectionHeaderViewStyleNormal;
        headerView.tag = TAG_second_header;
        [headerView updateContent:@"未订阅的频道"];
    } else {
        headerView = nil;
    }
    return headerView;
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
    if (!isEditing) {
        isEditing = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:kMyCollectionViewCellChangeTypeNotificationIdentifier object:@{@"type":@(MyCollectionViewCellTypeMul)}];
        FirsTitleSectionHeaderView *headerView = (FirsTitleSectionHeaderView *)[self.vc.collectionView viewWithTag:TAG_first_header];
        [headerView setEditSelectedState:isEditing];
    }
}

#pragma mark - FirsTitleSectionHeaderViewDelegate
- (void)clickEdit:(BOOL)isEdit
{
    isEditing = isEdit;
    if (isEdit) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kMyCollectionViewCellChangeTypeNotificationIdentifier object:@{@"type":@(MyCollectionViewCellTypeMul)}];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kMyCollectionViewCellChangeTypeNotificationIdentifier object:@{@"type":@(MyCollectionViewCellTypeDefault)}];
    }
}


@end
