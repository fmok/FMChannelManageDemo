//
//  FMCollectionViewFlowLayout.h
//  DemoHaHaHa
//
//  Created by fm on 2017/7/18.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FMCollectionViewFlowLayoutDelegate <NSObject>

- (void)beginResponseToLongPress;
- (void)moveDataItem:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath;

@end

@interface FMCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<FMCollectionViewFlowLayoutDelegate> delegate;

@end
