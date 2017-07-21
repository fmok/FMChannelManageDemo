//
//  ChannelListViewController.h
//  DemoHaHaHa
//
//  Created by fm on 2017/7/20.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannelSectionHeaderView.h"
#import "ChannelTableHeaderView.h"

@interface ChannelListViewController : UIViewController

@property (nonatomic, strong) UITableView *channelListView;
@property (nonatomic, strong) ChannelTableHeaderView *tableHeaderView;

@end
