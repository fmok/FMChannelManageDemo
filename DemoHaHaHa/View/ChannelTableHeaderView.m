//
//  ChannelTableHeaderView.m
//  DemoHaHaHa
//
//  Created by fm on 2017/7/21.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ChannelTableHeaderView.h"

@interface ChannelTableHeaderView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation ChannelTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.bottomLine];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10.f);
        make.top.and.bottom.and.right.equalTo(weakSelf);
    }];
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(weakSelf);
        make.height.mas_equalTo(.5);
    }];
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContent:(NSString *)title
{
    self.titleLabel.text = title;
    [self setNeedsUpdateConstraints];
}

#pragma mark - Private methods

#pragma maek - getter & setter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomLine;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
