//
//  TRNewTaskCell.m
//  TRProject
//
//  Created by 郑文青 on 16/7/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRNewTaskCell.h"

@implementation TRNewTaskCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self iconIV];
        [self titleLb];
        [self subtitleLb];
        [self button];
    }
    return self;
}
-(UIImageView *)iconIV
{
    if (!_iconIV) {
        _iconIV = [UIImageView new];
        [self.contentView addSubview:_iconIV];
        _iconIV.layer.masksToBounds = YES;
        _iconIV.layer.cornerRadius = 3;
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.top.equalTo(10);
            make.width.equalTo(40);
            make.height.equalTo(40);
        }];
    }
    return _iconIV;
}
-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        [self.contentView addSubview:_titleLb];
        _titleLb.textColor = [UIColor blackColor];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.font = [UIFont systemFontOfSize:14];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(10);
             make.height.equalTo(20);
            make.left.equalTo(_iconIV.mas_right).equalTo(10);
           
        }];
    }
    return _titleLb;
}
-(UILabel *)subtitleLb
{
    if (!_subtitleLb) {
        _subtitleLb = [UILabel new];
        [self.contentView addSubview:_subtitleLb];
        _subtitleLb.textColor = [UIColor lightGrayColor];
        _subtitleLb.numberOfLines = 0;
        _subtitleLb.textAlignment = NSTextAlignmentLeft;
        _subtitleLb.font = [UIFont systemFontOfSize:12];
        [_subtitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLb.mas_bottom).equalTo(0);
            make.left.equalTo(_iconIV.mas_right).equalTo(10);
            make.right.equalTo(-80);
        }];
    }
    return _subtitleLb;
}
-(UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_button];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:12];
        [_button setBackgroundImage:[UIImage new] forState:UIControlStateSelected];
        [_button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [_button setTitle:@"已完成" forState:UIControlStateSelected];
        [_button setTitleColor:kRGBA(7, 165, 242, 1.0) forState:UIControlStateNormal];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.height.equalTo(30);
            make.width.equalTo(60);
            make.top.equalTo(15);
        }];
    }
    return _button;
}


@end
