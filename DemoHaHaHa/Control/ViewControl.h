//
//  ViewControl.h
//  DemoHaHaHa
//
//  Created by fm on 2017/7/18.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
#import "MyCollectionViewCell.h"
#import "FirsTitleSectionHeaderView.h"

@interface ViewControl : NSObject<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    FMCollectionViewFlowLayoutDelegate,
    FirsTitleSectionHeaderViewDelegate>

@property (nonatomic, weak) MainViewController *vc;

- (void)registerCell;

@end
