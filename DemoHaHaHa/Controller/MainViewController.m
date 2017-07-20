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

@interface MainViewController ()

@property (nonatomic, strong) ViewControl *control;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WS(weakSelf);
    [self.subDataArr addObjectsFromArray:@[@"**1**", @"**2**", @"**3**", @"**4**", @"**5**", @"**6**", @"**7**", @"**8**", @"**9**", @"**10**"]];
    [self.unSubDataArr addObjectsFromArray:@[@"**11**", @"**12**", @"**13**", @"**14**", @"**15**", @"**16**", @"**17**",
                                             @"**18**", @"**19**", @"**20**", @"**21**", @"**22**", @"**23**", @"**24**", @"**25**",
                                             @"**26**", @"**27**", @"**28**", @"**29**", @"**30**", @"**31**",
                                             @"**32**", @"**33**", @"**34**", @"**35**"]];
    [self configeNav];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [self.control registerCell];
}

#pragma mark - Private methods
- (void)configeNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickLogo)];
}

#pragma mark - Events
- (void)clickLogo
{
    NSLog(@"\n*** click logo ***\n");
}

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
