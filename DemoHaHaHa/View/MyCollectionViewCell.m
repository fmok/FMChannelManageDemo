//
//  MyCollectionViewCell.m
//  DemoHaHaHa
//
//  Created by fm on 2017/7/18.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "MyCollectionViewCell.h"

@interface MyCollectionViewCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.5;
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContent:(NSString *)title
{
    self.titleLabel.text = [NSString stringWithFormat:@" %@", title];
    [self setNeedsUpdateConstraints];
}

#pragma mark - getter & setter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

@end
