//
//  FirsTitleSectionHeaderView.m
//  DemoHaHaHa
//
//  Created by fm on 2017/7/18.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FirsTitleSectionHeaderView.h"

@interface FirsTitleSectionHeaderView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *editBtn;

@end

@implementation FirsTitleSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.editBtn];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10.f);
        make.centerY.equalTo(weakSelf);
    }];
    [self.editBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-10.f);
        make.centerY.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    [super updateConstraints];
}

- (void)updateContent:(NSString *)contentText
{
    self.titleLabel.text = contentText;
}

#pragma mark - Events
- (void)editAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickEdit:)]) {
        [self.delegate clickEdit:sender.selected];
    }
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

- (UIButton *)editBtn
{
    if (!_editBtn) {
        _editBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _editBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _editBtn.layer.borderWidth = 0.5;
        _editBtn.backgroundColor = [UIColor whiteColor];
        _editBtn.layer.cornerRadius = 5.f;
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitle:@"完成" forState:UIControlStateSelected];
        [_editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

- (void)setCurrentStyle:(FirsTitleSectionHeaderViewStyle)currentStyle
{
    _currentStyle = currentStyle;
    switch (currentStyle) {
        case FirsTitleSectionHeaderViewStyleNormal:
        {
            self.editBtn.hidden = YES;
        }
            break;
        case FirsTitleSectionHeaderViewStyleEdit:
        {
            self.editBtn.hidden = NO;
        }
            break;
        default:
            break;
    }
}

@end
