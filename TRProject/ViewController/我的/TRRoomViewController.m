
//
//  TRRoomViewController.m
//  TRProject
//
//  Created by 郑文青 on 16/7/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRRoomViewController.h"

@interface TRRoomViewController ()

@end

@implementation TRRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [Factory addBackItemToVC:self];
    self.view.backgroundColor = kBGColor;
   
    UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH)];
    subView.backgroundColor = kBGColor;
    [self.view addSubview:subView];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon1111"]];
    [subView addSubview:imageView];
    UILabel *lable1 = [UILabel new];
    lable1.text = @"太惨了~~~";
    lable1.textColor = [UIColor blackColor];
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.font = [UIFont systemFontOfSize:16];
    [subView addSubview:lable1];
    
    UILabel *lable2 = [UILabel new];
    lable2.text = @"我还不是任何房间的房管";
    lable2.textColor = [UIColor grayColor];
    lable2.textAlignment = NSTextAlignmentCenter;
    lable2.font = [UIFont systemFontOfSize:14];
    [subView addSubview:lable2];
    //添加约束
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(200);
        make.height.and.width.equalTo(80);
    }];
    [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(imageView.mas_bottom).equalTo(10);
        make.height.equalTo(30);
        make.width.equalTo(100);
    }];
    [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(lable1.mas_bottom).equalTo(10);
        make.height.equalTo(30);
        make.width.equalTo(200);
    }];
    
    NSArray *items = @[@"正在直播",@"不在直播"];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:items];
    //设置选中字体的颜色
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,  [UIFont systemFontOfSize:14],NSFontAttributeName ,nil];
    [segmentControl setTitleTextAttributes:dic forState:UIControlStateSelected];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName,  [UIFont systemFontOfSize:14],NSFontAttributeName ,nil];
    [segmentControl setTitleTextAttributes:dic1 forState:UIControlStateNormal];
 
    //设置宽度
    [segmentControl setWidth:100 forSegmentAtIndex:0];
    [segmentControl setWidth:100 forSegmentAtIndex:1];
    //设置边角
    segmentControl.layer.masksToBounds = YES;
    segmentControl.layer.cornerRadius = 5;
    segmentControl.layer.borderColor = [UIColor whiteColor].CGColor;
    segmentControl.layer.borderWidth = 1;
    segmentControl.selectedSegmentIndex = 0;
    
    self.navigationItem.titleView = segmentControl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
