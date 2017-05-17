//
//  TRGameViewController.m
//  TRProject
//
//  Created by 郑文青 on 16/7/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRGameViewController.h"
#import "TRGameCell.h"
@interface TRGameViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *topView;

@end

@implementation TRGameViewController
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate= self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Factory addBackItemToVC:self];
    self.title = @"游戏中心";

    [self tableView];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRGameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRGameCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"TRGameCell" owner:nil options:nil].lastObject;
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.downloadBtn bk_addEventHandler:^(id sender) {
       
    //去AppStore下载游戏
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/ge-dou-xue-yuan-guan-fang-ban/id1041370707?mt=8"]];
        
    } forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/ge-dou-xue-yuan-guan-fang-ban/id1041370707?mt=8"]];
}
@end
