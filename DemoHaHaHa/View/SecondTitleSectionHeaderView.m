//
//  SecondTitleSectionHeaderView.m
//  DemoHaHaHa
//
//  Created by fm on 2017/7/18.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "SecondTitleSectionHeaderView.h"

@interface SecondTitleSectionHeaderView()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SecondTitleSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10.f);
        make.centerY.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContent:(NSString *)contentText
{
    self.titleLabel.text = contentText;
}

#pragma mark - getter & setter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor grayColor];
    }
    return _titleLabel;
}

@end




