//
//  TRGiftView.m
//  TRProject
//
//  Created by 郑文青 on 16/7/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRGiftView.h"

@implementation TRGiftView

- (void)prepareForContentSubView {
    contentView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"首充"]];
    [contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.bottom.equalTo(-20);
        make.right.equalTo(-40);
       
    }];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(contentView.width - 30, 0, contentView.width - 30, 30)];
   
    [btn setTitle:@"" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
    [contentView addSubview:btn];
    [btn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    
    self.top_upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addSubview:self.top_upBtn];
    [btn setTitle:@"" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
    [self.top_upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(40);
        make.left.equalTo(20);
        make.bottom.equalTo(-35);
        make.right.equalTo(-20);
    }];
}


@end
