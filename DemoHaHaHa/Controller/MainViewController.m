//
//  ViewController.m
//  DemoHaHaHa
//
//  Created by fm on 2017/7/18.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "MainViewController.h"
#import "FMCollectionViewFlowLayout.h"
#import "ViewControl.h"

@interface MainViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) ViewControl *control;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WS(weakSelf);
    [self.subDataArr addObjectsFromArray:@[@"**1**", @"**2**", @"**3**", @"**4**", @"**5**", @"**6**", @"**7**", @"**8**", @"**9**", @"**10**"]];
    /*
     
     // **************************** Java接口Json数据结构 **************************************
     
     
     // **************************** APP端本地数据结构 **************************************
     itemModel  {   category:
                    unistr:
                    title；
                    is_hot:
                }
     
     subArr [   {}   ---> itemModel
                {}
                {}
                {}
            ]
     
     unSubDic { china(category) : [ {}  ---> itemModel
                                    {}
                                    {}
                                  ]
     
                world: [  {}
                          {}
                       ]
              }
     
     数据解析：
        subArr: 方案（1）首次安装：读取本地 已订阅 的数据，还需要把每条数据添加上 category； 非首次安装：直接读取即可。
                方案（2）首次安装：清除本地数据； 非首次安装：直接读取本地。
        unSubArr: 原来的本地数据结构不对，需要重新分组； 每次重启app，需要更新这部分数据
                  so 本地留一份默认数据，每一次启动，读取本地数据，然后拉回最新数据，整理并保存
     订阅： add 到 subArr 的最后一个
     取消订阅： 根据取消 itemModel 的 category 在 unSubDic 中根据键值对找到对应的 数组，然后将此 itemMode insert 到该数组的首位
     
     */
    [self.unSubDataArr addObjectsFromArray:@[@[@"**11**", @"**12**", @"**13**", @"**14**", @"**15**", @"**16**", @"**17**"],
                                             @[@"**18**", @"**19**", @"**20**", @"**21**", @"**22**", @"**23**", @"**24**", @"**25**"],
                                             @[@"**26**", @"**27**", @"**28**", @"**29**", @"**30**", @"**31**"],
                                             @[@"**32**", @"**33**", @"**34**", @"**35**"]]];
    [self fullScreenPop];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [self.control registerCell];
}

- (void)fullScreenPop
{
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

#pragma mark - Private methods

#pragma mark - getter & setter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self.control;
        _collectionView.dataSource = self.control;
    }
    return _collectionView;
}

- (FMCollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[FMCollectionViewFlowLayout alloc] init];
        _flowLayout.delegate = self.control;
    }
    return _flowLayout;
}

- (ViewControl *)control
{
    if (!_control) {
        _control = [[ViewControl alloc] init];
        _control.vc = self;
    }
    return _control;
}

- (NSMutableArray *)subDataArr
{
    if (!_subDataArr) {
        _subDataArr = [[NSMutableArray alloc] init];
    }
    return _subDataArr;
}

- (NSMutableArray *)unSubDataArr
{
    if (!_unSubDataArr) {
        _unSubDataArr = [[NSMutableArray alloc] init];
    }
    return _unSubDataArr;
}


@end
