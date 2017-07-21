//
//  ChannelSectionHeaderView.m
//  DemoHaHaHa
//
//  Created by fm on 2017/7/20.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ChannelSectionHeaderView.h"

@interface ChannelSectionHeaderView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *foldBtn;
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, assign) ChannelSectionHeaderViewType currentType;

@end

@implementation ChannelSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.foldBtn];
        [self addSubview:self.bottomLine];
        self.currentType = ChannelSectionHeaderViewTypeClose;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foldAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10.f);
        make.top.and.bottom.equalTo(weakSelf);
    }];
    [self.foldBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-10.f);
        make.centerY.equalTo(weakSelf);
    }];
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(weakSelf);
        make.height.mas_equalTo(0.5);
    }];
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContent:(NSString *)title
{
    self.titleLabel.text = title;
    [self setNeedsUpdateConstraints];
}

- (void)setFoldState:(BOOL)state
{
    self.foldBtn.selected = state;
}

#pragma mark - Private methods

#pragma mark - Events
- (void)foldAction:(UITapGestureRecognizer *)tap
{
    self.foldBtn.selected = !self.foldBtn.selected;
    self.currentType = (self.foldBtn.selected ? ChannelSectionHeaderViewTypeOpen : ChannelSectionHeaderViewTypeClose);
    if (self.delegate && [self.delegate respondsToSelector:@selector(foldChannel:tag:)]) {
        [self.delegate foldChannel:self.currentType tag:self.tag];
    }
}

#pragma mark - getter & setter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UIButton *)foldBtn
{
    if (!_foldBtn) {
        _foldBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_foldBtn setImage:[UIImage imageNamed:@"key_close"] forState:UIControlStateNormal];
        [_foldBtn setImage:[UIImage imageNamed:@"key_open"] forState:UIControlStateSelected];
        _foldBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_foldBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _foldBtn;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomLine;
}

@end
