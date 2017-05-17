//
//  TRLoginOrRegisterview.m
//  TRProject
//
//  Created by 郑文青 on 16/8/3.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRLoginOrRegisterview.h"

@implementation TRLoginOrRegisterview

-(float)heightForContentView
{
    return 400;
}
-(float)widthForContentView
{
    return 280;
}
- (void)prepareForContentSubView
{
    contentView.backgroundColor = [UIColor clearColor];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"取消按钮"] forState:UIControlStateNormal];
    [contentView addSubview:cancelBtn];
    [cancelBtn bk_addEventHandler:^(id sender) {
        [self hide];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(30);
        make.width.equalTo(30);
        make.left.equalTo(126);
        make.bottom.equalTo(-40);
    }];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"注册登录"]];
    [contentView addSubview:imageView];
    [imageView setRoundRectLayerCornerRadius:15 borderWidth:1 borderColor:[UIColor whiteColor]];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(-50);
        make.bottom.equalTo(cancelBtn.mas_top).equalTo(-30);
       
        
    }];
    
    self.weChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addSubview:self.weChatBtn];
    [self.weChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(60);
        make.left.equalTo(40);
        make.height.equalTo(40);
        make.width.equalTo(200);
    }];
    
    self.QQBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
   
    [contentView addSubview:self.QQBtn];
    [self.QQBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weChatBtn.mas_bottom).equalTo(10);
        make.left.equalTo(40);
        make.height.equalTo(40);
        make.width.equalTo(200);
       
    }];
    
    self.weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  
    [contentView addSubview:self.weiboBtn];
    [self.weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.QQBtn.mas_bottom).equalTo(10);
        make.left.equalTo(40);
        make.height.equalTo(40);
        make.width.equalTo(200);
    }];
    
    self.accountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.accountBtn setTitle:@"手机账号登录" forState:UIControlStateNormal];
   
    self.accountBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.accountBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contentView addSubview:self.accountBtn];
    [self.accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weiboBtn.mas_bottom).equalTo(27);
        make.left.equalTo(40);
        make.height.equalTo(40);
        make.width.equalTo(200);
    }];
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   
    [contentView addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountBtn.mas_bottom).equalTo(10);
        make.left.equalTo(115);
        make.height.equalTo(20);
        make.width.equalTo(50);
        
    }];
    
    
}
@end
