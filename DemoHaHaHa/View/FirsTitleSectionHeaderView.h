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

@protocol FirsTitleSectionHeaderViewDelegate <NSObject>

- (void)clickEdit:(BOOL)isEdit;

@end

@interface FirsTitleSectionHeaderView : UICollectionReusableView

@property (nonatomic, weak) id<FirsTitleSectionHeaderViewDelegate>delegate;
@property (nonatomic, assign) FirsTitleSectionHeaderViewStyle currentStyle;

- (void)updateContent:(NSString *)contentText;
- (void)setEditSelectedState:(BOOL)state;

@end
