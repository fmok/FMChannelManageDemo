//
//  FirsTitleSectionHeaderView.h
//  DemoHaHaHa
//
//  Created by fm on 2017/7/18.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FirsTitleSectionHeaderViewStyle) {
    FirsTitleSectionHeaderViewStyleNormal = 1 << 0,
    FirsTitleSectionHeaderViewStyleEdit = 1 << 1
};

@interface FirsTitleSectionHeaderView : UICollectionReusableView

@property (nonatomic, assign) FirsTitleSectionHeaderViewStyle currentStyle;

- (void)updateContent:(NSString *)contentText;

@end
