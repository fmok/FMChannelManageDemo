//
//  ChannellistControl.m
//  DemoHaHaHa
//
//  Created by fm on 2017/7/20.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ChannellistControl.h"
#import "MainViewController.h"

#define kCellIdentifier  @"cell"
#define kChannelSectionHeaderViewidentifier @"ChannelSectionHeaderView"

#define Section_count 20

@interface ChannellistControl()

@property (nonatomic, strong) NSMutableDictionary *channelCountDict;
@property (nonatomic, strong) NSMutableDictionary *channelFoldDict;

@end

@implementation ChannellistControl

#pragma mark - Public methods
- (void)registerCell
{
    [self.vc.channelListView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}

- (void)loadData
{
    for (NSInteger i = 0; i < Section_count; i ++) {
        [self.channelCountDict setObject:@(10) forKey:@(i)];
        [self.channelFoldDict setObject:@(0) forKey:@(i)];  // 0: 关闭  1: 打开
    }
}

- (void)toEditChannel
{
    MainViewController *vc = [[MainViewController alloc] init];
    vc.title = @"频道订阅";
    [self.vc.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ChannelSectionHeaderViewDelegate
- (void)foldChannel:(ChannelSectionHeaderViewType)type tag:(NSInteger)tag
{
    NSLog(@"\n*** tag:%@ ***\n", @(tag));
    switch (type) {
        case ChannelSectionHeaderViewTypeClose:
        {
            [self.channelFoldDict setObject:@(0) forKey:@(tag-100)];
        }
            break;
        case ChannelSectionHeaderViewTypeOpen:
        {
            [self.channelFoldDict setObject:@(1) forKey:@(tag-100)];
        }
            break;
            
        default:
            break;
    }
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:tag-100];
    [self.vc.channelListView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ChannelSectionHeaderView *headerView = (ChannelSectionHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:kChannelSectionHeaderViewidentifier];
    if (!headerView) {
        headerView = [[ChannelSectionHeaderView alloc] init];
    }
    headerView.tag = 100+section;
    headerView.delegate = self;
    BOOL isFold = [[self.channelFoldDict objectForKey:@(section)] boolValue];
    [headerView setFoldState:isFold];
    [headerView updateContent:[NSString stringWithFormat:@"*** section: %@ ***", @(section)]];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = [NSString stringWithFormat:@"%@ - %@", @(indexPath.section), @(indexPath.row)];
    [self.vc.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [[self.channelCountDict objectForKey:@(section)] integerValue];
    BOOL isFold = [[self.channelFoldDict objectForKey:@(section)] boolValue];
    if (isFold) {
        return count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"   &&& row: %@ &&&   ", @(indexPath.row)];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return Section_count;
}

#pragma mark - getter & setter
- (NSMutableDictionary *)channelCountDict
{
    if (!_channelCountDict) {
        _channelCountDict = [[NSMutableDictionary alloc] init];
    }
    return _channelCountDict;
}

- (NSMutableDictionary *)channelFoldDict
{
    if (!_channelFoldDict) {
        _channelFoldDict = [[NSMutableDictionary alloc] init];
    }
    return _channelFoldDict;
}

@end
