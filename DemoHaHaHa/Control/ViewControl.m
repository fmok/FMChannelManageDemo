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
    [self.vc.subDataArr addObject:self.vc.unSubDataArr[indexPath.item]];
    [self.vc.unSubDataArr removeObjectAtIndex:indexPath.item];
    
    NSIndexPath *sourceIndexPath = [NSIndexPath indexPathForItem:indexPath.item inSection:1];
    NSIndexPath *destinationIndexPath = [NSIndexPath indexPathForItem:self.vc.subDataArr.count-1 inSection:0];
    
    WS(weakSelf);
    [self.vc.collectionView performBatchUpdates:^{
        [weakSelf.vc.collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    } completion:^(BOOL finished) {
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:weakSelf.vc.subDataArr.count-1 inSection:0];
        [weakSelf.vc.collectionView reloadItemsAtIndexPaths:@[lastIndexPath]];
    }];
}

- (void)unSubChannel:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    [self.vc.unSubDataArr insertObject:self.vc.subDataArr[indexPath.item] atIndex:0];
    [self.vc.subDataArr removeObjectAtIndex:indexPath.item];
    
    NSIndexPath *sourceIndexPath = [NSIndexPath indexPathForItem:indexPath.item inSection:0];
    NSIndexPath *destinationIndexPath = [NSIndexPath indexPathForItem:0 inSection:1];
    
    WS(weakSelf);
    [self.vc.collectionView performBatchUpdates:^{
        [weakSelf.vc.collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    } completion:^(BOOL finished) {
        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [weakSelf.vc.collectionView reloadItemsAtIndexPaths:@[firstIndexPath]];
    }];
}

- (void)setEditState
{
    if (!isEditing) {
        isEditing = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:kMyCollectionViewCellChangeTypeNotificationIdentifier object:@{@"type":@(MyCollectionViewCellTypeMul)}];
        FirsTitleSectionHeaderView *headerView = (FirsTitleSectionHeaderView *)[self.vc.collectionView viewWithTag:TAG_first_header];
        [headerView setEditSelectedState:isEditing];
    }
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
            [self setEditState];
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
    [self setEditState];
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
