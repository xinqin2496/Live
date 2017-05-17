//
//  NewTaskViewController.m
//  TRProject
//
//  Created by 郑文青 on 16/7/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "NewTaskViewController.h"
#import "TRNewTaskCell.h"
@interface NewTaskViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UITableView *tableView;


@end

@implementation NewTaskViewController
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Factory addBackItemToVC:self];
    self.title = @"我的任务";

    [self tableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    NSLog(@"我的任务控制器销毁了");
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TRNewTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[TRNewTaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     WK(weakSelf);
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.iconIV.image = [UIImage imageNamed:@"送礼物啦"];
            cell.titleLb.text = @"送礼物啦";
            cell.subtitleLb.text = @"每天第一次送礼物可以获得额外25种子";
            
        }else{
            cell.iconIV.image = [UIImage imageNamed:@"发送弹幕"];
            cell.titleLb.text = @"发送弹幕";
            cell.subtitleLb.text = @"每天第一次发弹幕可以获得额外25种子";
           
        }
        [cell.button setTitle:@"未完成" forState:UIControlStateNormal];
        [cell.button setBackgroundImage:[UIImage imageNamed:@"未完成"] forState:UIControlStateNormal];
        [cell.button bk_addEventHandler:^(id sender) {
            [weakSelf.view showWarning:@"请先完成任务再重试"];
        } forControlEvents:UIControlEventTouchUpInside];
    }else{
        if (indexPath.row ==0) {
            cell.iconIV.image = [UIImage imageNamed:@"上传头像"];
            cell.titleLb.text = @"上传头像";
            cell.subtitleLb.text = @"送75种子";
            [cell.button setTitle:@"未完成" forState:UIControlStateNormal];
            [cell.button setBackgroundImage:[UIImage imageNamed:@"未完成"] forState:UIControlStateNormal];
            [cell.button bk_addEventHandler:^(id sender) {
                [weakSelf.view showWarning:@"请先完成任务再重试"];
            } forControlEvents:UIControlEventTouchUpInside];
        }else if (indexPath.row ==1){
            cell.iconIV.image = [UIImage imageNamed:@"手机绑定奖励"];
            cell.titleLb.text = @"手机绑定奖励";
            cell.subtitleLb.text = @"送125种子";
            [cell.button setTitle:@"未领取" forState:UIControlStateNormal];
            [cell.button setTitleColor:kNaviBarBGColor forState:UIControlStateNormal];
            [cell.button setBackgroundImage:[UIImage imageNamed:@"未领取"] forState:UIControlStateNormal];
            
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isIphone"] isEqualToString:@"iphone"]) {
                cell.button.selected = YES;
            }
            [cell.button bk_addEventHandler:^(id sender) {
                
                cell.button.selected = YES;
                if (cell.button.selected) {
                    [[NSUserDefaults standardUserDefaults]setObject:@"iphone" forKey:@"isIphone"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
            } forControlEvents:UIControlEventTouchUpInside];
           
           
            
            
        }else if (indexPath.row ==2){
            cell.iconIV.image = [UIImage imageNamed:@"邮箱绑定奖励"];
            cell.titleLb.text = @"邮箱绑定奖励";
            cell.subtitleLb.text = @"送75种子";
            [cell.button setTitle:@"未完成" forState:UIControlStateNormal];
            [cell.button setBackgroundImage:[UIImage imageNamed:@"未完成"] forState:UIControlStateNormal];
           
            [cell.button bk_addEventHandler:^(id sender) {
                [weakSelf.view showWarning:@"请先完成任务再重试"];
            } forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            cell.iconIV.image = [UIImage imageNamed:@"注册奖励"];
            cell.titleLb.text = @"注册奖励";
            cell.subtitleLb.text = @"送125种子";
            [cell.button setTitle:@"未领取" forState:UIControlStateNormal];
            [cell.button setTitleColor:kNaviBarBGColor forState:UIControlStateNormal];
            [cell.button setBackgroundImage:[UIImage imageNamed:@"未领取"] forState:UIControlStateNormal];
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isRegister"]isEqualToString:@"register"]) {
                cell.button.selected = YES;
            }
            [cell.button bk_addEventHandler:^(id sender) {
                cell.button.selected = YES;
                if (cell.button.selected) {
                    [[NSUserDefaults standardUserDefaults]setObject:@"register" forKey:@"isRegister"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
            } forControlEvents:UIControlEventTouchUpInside];
            
        }
       
       
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"栏目标题"]];
    [view addSubview:imageView];
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(10);
        make.height.equalTo(15);
        make.width.equalTo(3);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).equalTo(10);
        make.height.equalTo(10);
        make.top.equalTo(15);
    }];
    if (section == 0) {
        label.text = @"日常任务";
    }else{
        label.text = @"基础任务";
    }
    return view;
}


@end
