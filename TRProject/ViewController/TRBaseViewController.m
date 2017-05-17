//
//  TRBaseViewController.m
//  TRProject
//
//  Created by 郑文青 on 16/8/25.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRBaseViewController.h"

@interface TRBaseViewController ()
/** 电池栏背景 */
@property (nonatomic,strong)UIView *topView;
@end

@implementation TRBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [self addBackItemToVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    //自定义一个view 做电池栏的背景色
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, kScreenW, 20)];
    topView.backgroundColor = kRGBA(255, 86, 142, 1.0);
    self.topView = topView;
    [self.navigationController.navigationBar addSubview:topView];
    [self.navigationController.navigationBar setBackgroundColor: kRGBA(255, 86, 142, 1.0)];
}
-(void)viewWillDisappear:(BOOL)animated
{
    //把电池栏和导航栏颜色清掉
    self.topView.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackgroundColor: [UIColor clearColor]];
    
}


-(void)addBackItemToVC{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 44);
    [btn setImage:[UIImage imageNamed:@"返回_默认"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"返回_按下"] forState:UIControlStateHighlighted];
    WK(weakSelf);
    [btn bk_addEventHandler:^(id sender) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    //把视图的边角变为圆形, cornerRadius圆角半径
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //弹簧控件, 修复边距
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    self.navigationItem.leftBarButtonItems = @[spaceItem,backItem];
}

@end
