//
//  TRTopViewController.m
//  TRProject
//
//  Created by 郑文青 on 16/8/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRTopViewController.h"

@interface TRTopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
/** 平台币 */
@property (nonatomic,strong)NSArray *allCountArray;
/** 人民币 */
@property (nonatomic,strong)NSArray *allMoneyArray;

@property (nonatomic,strong)UIView *topView;
@end

@implementation TRTopViewController
-(NSArray *)allCountArray
{
    if (!_allCountArray) {
        _allCountArray = @[@"42",@"84",@"350",@"1,036",@"5,586",@"10,486"];
    }
    return _allCountArray;
}
-(NSArray *)allMoneyArray
{
    if (!_allMoneyArray) {
        _allMoneyArray = @[@"6元",@"12元",@"50元",@"148元",@"798元",@"1498元"];
    }
    return _allMoneyArray;
}
#pragma mark 懒加载
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView  = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    [Factory addBackItemToVC:self];
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) {
            UILabel *titleLb = [UILabel new];
            titleLb.text = @"账户余额";
            titleLb.textColor = [UIColor blackColor];
            titleLb.textAlignment = NSTextAlignmentLeft;
            titleLb.font = [UIFont systemFontOfSize:14];
            UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"平台币"]];
            UILabel *counLb = [UILabel new];
            counLb.text = @"0";
            counLb.textColor = [UIColor blackColor];
            counLb.textAlignment = NSTextAlignmentLeft;
            counLb.font = [UIFont systemFontOfSize:12];
            [cell.contentView addSubview:titleLb];
            [cell.contentView addSubview:imageview];
            [cell.contentView addSubview:counLb];
            [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(15);
                make.centerY.equalTo(0);
                make.height.equalTo(20);
            }];
            [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(titleLb.mas_right).equalTo(20);
                make.centerY.equalTo(0);
                make.height.equalTo(20);
                make.width.equalTo(20);
            }];
            [counLb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageview.mas_right).equalTo(5);
                make.centerY.equalTo(0);
                make.height.equalTo(20);
            }];
        }else{
            UIImageView *imageView =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"平台币"]];
            UILabel *counLb = [UILabel new];
            counLb.tag = 111;
            counLb.textColor = [UIColor blackColor];
            counLb.textAlignment = NSTextAlignmentLeft;
            counLb.font = [UIFont systemFontOfSize:12];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 222;
            [button setTitleColor:kNaviBarBGColor forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setBackgroundImage:[UIImage imageNamed:@"未领取"] forState:UIControlStateNormal];
            [cell.contentView addSubview:imageView];
            [cell.contentView addSubview:counLb];
            [cell.contentView addSubview:button];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(15);
                make.height.equalTo(20);
                make.width.equalTo(20);
                make.centerY.equalTo(0);
            }];
            [counLb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageView.mas_right).equalTo(10);
                make.centerY.equalTo(0);
                make.height.equalTo(20);
            }];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(-20);
                make.centerY.equalTo(0);
                make.height.equalTo(30);
                make.width.equalTo(60);
            }];
            if (indexPath.row == 1) {
                UILabel *iOSLb = [UILabel new];
                iOSLb.text = @"iOS首充礼包";
                iOSLb.textColor = [UIColor lightGrayColor];
                iOSLb.textAlignment = NSTextAlignmentCenter;
                iOSLb.font = [UIFont systemFontOfSize:12];
                [cell.contentView addSubview:iOSLb];
                [iOSLb mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(button.mas_left).equalTo(-20);
                    make.centerY.equalTo(0);
                    make.height.equalTo(20);
                }];
            }
        }
        
    }
    if (indexPath.section ==1) {
        UILabel *label = [cell viewWithTag:111];
        label.text = self.allCountArray[indexPath.row];
        UIButton *button = [cell viewWithTag:222];
        WK(weakSelf);
        [button bk_addEventHandler:^(id sender) {
            [weakSelf.view showWarning:@"不好意思,暂时不支持充值功能"];
        } forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitle:self.allMoneyArray[indexPath.row] forState:UIControlStateNormal];
    }
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"选择充值金额";
    }
    return @"";
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    return 20;
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return @"提示:充值成功会在10分钟内到账,遇到问题请联系QQ客服80055732";
    }
    return @"";
}


@end
