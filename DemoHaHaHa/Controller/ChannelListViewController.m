//
//  ChannelListViewController.m
//  DemoHaHaHa
//
//  Created by fm on 2017/7/20.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ChannelListViewController.h"
#import "ChannellistControl.h"

@interface ChannelListViewController ()

@property (nonatomic, strong) ChannellistControl *control;

@end

@implementation ChannelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    WS(weakSelf);
    [self.view addSubview:self.channelListView];
    [self.channelListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [self.control registerCell];
    [self.control loadData];
}

#pragma mark - getter & setter
- (ChannellistControl *)control
{
    if (!_control) {
        _control = [[ChannellistControl alloc] init];
        _control.vc = self;
    }
    return _control;
}

- (UITableView *)channelListView
{
    if (!_channelListView) {
        _channelListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _channelListView.backgroundColor = [UIColor whiteColor];
        _channelListView.delegate = self.control;
        _channelListView.dataSource = self.control;
        _channelListView.showsHorizontalScrollIndicator = NO;
        _channelListView.showsVerticalScrollIndicator = NO;
        _channelListView.tableHeaderView = self.tableHeaderView;
    }
    return _channelListView;
}

- (ChannelTableHeaderView *)tableHeaderView
{
    if (!_tableHeaderView) {
        _tableHeaderView = [[ChannelTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, 60)];
        [_tableHeaderView updateContent:@"编辑我订阅的频道"];
        [_tableHeaderView addTarget:self.control action:@selector(toEditChannel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tableHeaderView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
