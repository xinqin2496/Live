//
//  TRCategoryCell.m
//  TRProject
//
//  Created by jiyingxin on 16/3/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRCategoryCell.h"

@implementation TRCategoryCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.clipsToBounds = YES;
        self.clipsToBounds=YES;
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"分类"]];
        self.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
        UIView *whiteV = [UIView new];
        whiteV.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:whiteV];
        //28 + 2
        [whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(50);
        }];
        [self nickLb];
        [self iconIV];
        [self titleLb];
        [self avatarIV];
    }
    return self;
}

- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLb];
        _titleLb.numberOfLines = 1;
        
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarIV.mas_right).equalTo(10);
            make.right.equalTo(-5);
            make.height.equalTo(20);
            make.bottom.equalTo(-5);
        }];
        _titleLb.font = [UIFont systemFontOfSize:12];
    }
    return _titleLb;
}

- (UILabel *)viewLb {
    if(_viewLb == nil) {
        _viewLb = [[UILabel alloc] init];
        _viewLb.textColor = [UIColor whiteColor];
        _viewLb.font = [UIFont systemFontOfSize:10];
    }
    return _viewLb;
}

- (UILabel *)nickLb {
    if(_nickLb == nil) {
        _nickLb = [[UILabel alloc] init];
        _nickLb.textColor = [UIColor blackColor];
        _nickLb.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_nickLb];
        [_nickLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.avatarIV.mas_right).equalTo(10);
            make.right.equalTo(-5);
            make.height.equalTo(20);
            make.bottom.equalTo(self.titleLb.mas_top).equalTo(0);
            
        }];
    }
    return _nickLb;
}
-(UIImageView *)avatarIV
{
    if (!_avatarIV) {
        _avatarIV = [UIImageView new];
        [_avatarIV setRoundRectLayerCornerRadius:20 borderWidth:1 borderColor:[UIColor whiteColor]];
        [self.contentView addSubview:_avatarIV];
        [_avatarIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(5);
            make.width.equalTo(40);
            make.height.equalTo(40);
            make.bottom.equalTo(-5);
        }];
    }
    return _avatarIV;
}

- (UIImageView *)iconIV {
    if(_iconIV == nil) {
        _iconIV = [[UIImageView alloc] init];
        _iconIV.layer.masksToBounds = YES;
        _iconIV.layer.cornerRadius = 3;
        [self.contentView addSubview:_iconIV];
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.bottom.equalTo(-50);
        }];
        
        UIView *lightV = [[UIView alloc] init];
        lightV.backgroundColor = kRGBA(0, 0, 0, 0.4);
        [lightV setRoundRectLayerCornerRadius:5 borderWidth:1 borderColor:kRGBA(0, 0, 0, 0.4)];
        [_iconIV addSubview:lightV];
        [lightV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(5);
            make.height.equalTo(15);
            make.width.equalTo(65);
            make.bottom.equalTo(-5);
            
        }];
        
        UIImageView *icon0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"观看人数"]];
        [lightV addSubview:icon0];
        [icon0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(5);
            make.centerY.equalTo(0);
        }];
        //观看人数
        [lightV addSubview:self.viewLb];
        [self.viewLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon0.mas_right).equalTo(2);
            make.centerY.equalTo(0);
            make.right.equalTo(5);
        }];
        
    }
    return _iconIV;
}

@end
