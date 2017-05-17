//
//  TRRemindViewController.m
//  TRProject
//
//  Created by 郑文青 on 16/7/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRRemindViewController.h"
#import "TRFocusModel.h"
@interface TRRemindViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UITableView *tableView;
/** 关注过的人 */
@property (nonatomic,strong)NSArray *allRemindArray;
@end

@implementation TRRemindViewController
-(NSArray *)allRemindArray
{
    if (!_allRemindArray) {
        _allRemindArray = [TRFocusModel focusArray];
    }
    return _allRemindArray;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    [Factory addBackItemToVC:self];
    self.title = @"开播提醒";
    self.view.backgroundColor = kBGColor;

    if (self.allRemindArray.count == 0) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"赶快去关注主播吧~~~";
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.centerY.equalTo(0);
            make.width.equalTo(200);
            make.height.equalTo(30);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allRemindArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
        UISwitch *mySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
        mySwitch.onTintColor = kRGBA(235, 53, 67, 1.0);
        mySwitch.on = NO;
        cell.accessoryView = mySwitch;
        
        UIImageView *imageView = [UIImageView new];
       
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 25;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 1;
        [cell.contentView addSubview:imageView];
        UILabel *label1 = [UILabel new];
    
        label1.textAlignment = NSTextAlignmentLeft;
        label1.font = [UIFont systemFontOfSize:14];
        label1.textColor = [UIColor blackColor];
        [cell.contentView addSubview:label1];
        
        UILabel *label2 = [UILabel new];
       
        label2.textAlignment = NSTextAlignmentLeft;
        label2.font = [UIFont systemFontOfSize:12];
        label2.textColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:label2];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.top.equalTo(10);
            make.width.equalTo(50);
            make.height.equalTo(50);
            
        }];
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).equalTo(10);
            make.top.equalTo(10);
            make.height.equalTo(20);
            
        }];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label1.mas_bottom).equalTo(5);
            make.height.equalTo(20);
            make.left.equalTo(imageView.mas_right).equalTo(10);
            make.right.equalTo(-10);
        }];
        TRFocusModel *model = self.allRemindArray[indexPath.row];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.avatarStr] placeholderImage:[UIImage imageNamed:@"分类"]];
    label1.text = model.Hls_name;
    label2.text = model.Hls_title;
    if (indexPath.row == 0) {
        mySwitch.on = YES;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
@end
