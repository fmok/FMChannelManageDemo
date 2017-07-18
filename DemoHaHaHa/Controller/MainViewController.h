//
//  ViewController.h
//  DemoHaHaHa
//
//  Created by fm on 2017/7/18.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMCollectionViewFlowLayout.h"

@interface MainViewController : UIViewController

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) FMCollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *subDataArr;
@property (nonatomic, strong) NSMutableArray *unSubDataArr;

@end

