//
//  FMCollectionViewFlowLayout.m
//  DemoHaHaHa
//
//  Created by fm on 2017/7/18.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMCollectionViewFlowLayout.h"
#import "MainViewController.h"

@interface FMCollectionViewFlowLayout()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;    //当前的IndexPath
@property (nonatomic, strong) UIView *mappingImageCell;         //拖动cell的截图
@property (nonatomic, weak) MainViewController *vc;

@end

@implementation FMCollectionViewFlowLayout

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configureObserver];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureObserver];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"collectionView"];
}

#pragma mark - setup

- (void)configureObserver{
    [self addObserver:self forKeyPath:@"collectionView" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setUpGestureRecognizers{
    if (self.collectionView == nil) {
        return;
    }
    _longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
    _longPress.minimumPressDuration = 0.2f;
    _longPress.delegate = self;
    [self.collectionView addGestureRecognizer:_longPress];
}

#pragma mark - observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"collectionView"]) {
        [self setUpGestureRecognizers];
    } else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer*)longPress
{
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint location = [longPress locationInView:self.collectionView];
            NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:location];
            if (!indexPath) return;
            if (indexPath.section > 0) return; // 长按其他分组，使无响应
            
            self.currentIndexPath = indexPath;
            UICollectionViewCell* targetCell = [self.collectionView cellForItemAtIndexPath:self.currentIndexPath];
            //得到当前cell的映射(截图)
            UIView *cellView = [targetCell snapshotViewAfterScreenUpdates:YES];
            self.mappingImageCell = cellView;
            self.mappingImageCell.frame = cellView.frame;
            targetCell.hidden = YES;
            [self.collectionView addSubview:self.mappingImageCell];
            
            cellView.center = targetCell.center;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint point = [longPress locationInView:self.collectionView];
            //更新cell的位置
            self.mappingImageCell.center = point;
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
            if (indexPath == nil) return;
            if (indexPath.section > 0) return;  // 拉倒其他分组，无操作
            if (![indexPath isEqual:self.currentIndexPath])
            {
                //改变数据源
                if (self.delegate && [self.delegate respondsToSelector:@selector(moveDataItem:toIndexPath:)]) {
                    [self.delegate moveDataItem:self.currentIndexPath toIndexPath:indexPath];
                }
                [self.collectionView moveItemAtIndexPath:self.currentIndexPath toIndexPath:indexPath];
                self.currentIndexPath = indexPath;
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:self.currentIndexPath];
            
            [UIView animateWithDuration:0.25 animations:^{
                self.mappingImageCell.center = cell.center;
            } completion:^(BOOL finished) {
                [self.mappingImageCell removeFromSuperview];
                cell.hidden           = NO;
                self.mappingImageCell = nil;
                self.currentIndexPath = nil;
            }];
        }
            break;
        default:
        {
            
        }
            break;
    }
    
    
}

@end

