//
//  TRCategoriesCell.m
//  TRProject
//
//  Created by jiyingxin on 16/3/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRCategoriesCell.h"

@implementation TRCategoriesCell

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
            make.left.right.equalTo(0);
            make.bottom.equalTo(-2);
            make.height.equalTo(28);
        }];
        [self iconIV];
        [self nameLb];
    }
    return self;
}

- (UIImageView *)iconIV{
    if (!_iconIV) {
        _iconIV = [UIImageView new];
        [self.contentView addSubview:_iconIV];
        _iconIV.contentMode = UIViewContentModeScaleAspectFill;
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(0);
            make.bottom.equalTo(-30);
        }];
    }
    return _iconIV;
}

- (UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLb];
        _nameLb.font = [UIFont systemFontOfSize:16];
        _nameLb.textAlignment = NSTextAlignmentCenter;
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.bottom.equalTo(-3);
        }];
    }
    return _nameLb;
}



@end
