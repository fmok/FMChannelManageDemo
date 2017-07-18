//
//  MyCollectionViewCell.h
//  DemoHaHaHa
//
//  Created by fm on 2017/7/18.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MyCollectionViewCellType) {
    MyCollectionViewCellTypeDefault = 1 << 0, // 无，默认
    MyCollectionViewCellTypeAdd = 1 << 1,  // 加号
    MyCollectionViewCellTypeMul = 1 << 2  // 减号
};

@interface MyCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) MyCollectionViewCellType currentType;

- (void)updateContent:(NSString *)title;

@end
