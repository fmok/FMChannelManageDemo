//
//  ChannelSectionHeaderView.h
//  DemoHaHaHa
//
//  Created by fm on 2017/7/20.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ChannelSectionHeaderViewType) {
    ChannelSectionHeaderViewTypeClose = 1 << 0,
    ChannelSectionHeaderViewTypeOpen = 1 << 1
};

@protocol ChannelSectionHeaderViewDelegate <NSObject>

- (void)foldChannel:(ChannelSectionHeaderViewType)type tag:(NSInteger)tag;

@end

@interface ChannelSectionHeaderView : UIView

@property (nonatomic, weak) id<ChannelSectionHeaderViewDelegate>delegate;

- (void)updateContent:(NSString *)title;
- (void)setFoldState:(BOOL)state;

@end
