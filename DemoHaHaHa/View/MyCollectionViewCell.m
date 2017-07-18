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
@property (nonatomic, strong) UIImageView *imgView;

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
        [self addSubview:self.imgView];
        self.currentType = MyCollectionViewCellTypeDefault;
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(5);
        make.centerY.equalTo(weakSelf);
    }];
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-5);
        make.centerY.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContent:(NSString *)title
{
    self.titleLabel.text = [NSString stringWithFormat:@" %@", title];
    [self setNeedsUpdateConstraints];
}

#pragma mark - Private methods
- (void)setImg:(MyCollectionViewCellType)type
{
    switch (type) {
        case MyCollectionViewCellTypeDefault:
        {
            self.imgView.hidden = YES;
        }
            break;
        case MyCollectionViewCellTypeAdd:
        {
            self.imgView.hidden = NO;
            [self.imgView setImage:[UIImage imageNamed:@"add_channel"]];
        }
            break;
        case MyCollectionViewCellTypeMul:
        {
            self.imgView.hidden = NO;
            [self.imgView setImage:[UIImage imageNamed:@"mul_channel"]];
        }
            break;
            
        default:
            break;
    }
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

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imgView;
}

- (void)setCurrentType:(MyCollectionViewCellType)currentType
{
    [self setImg:currentType];
}

@end
