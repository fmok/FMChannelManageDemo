//
//  ChannellistControl.h
//  DemoHaHaHa
//
//  Created by fm on 2017/7/20.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChannelListViewController.h"

@interface ChannellistControl : NSObject<UITableViewDelegate, UITableViewDataSource, ChannelSectionHeaderViewDelegate>

@property (nonatomic, weak) ChannelListViewController *vc;

- (void)registerCell;
- (void)loadData;

@end
