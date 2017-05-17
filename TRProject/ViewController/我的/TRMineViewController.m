//
//  TRMineViewController.m
//  TRProject
//
//  Created by 郑文青 on 16/7/22.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRMineViewController.h"
#import "MineCell.h"
#import "UserFeedBackViewController.h"
#import "TRSetViewController.h"
#import "TRRoomViewController.h"
#import "TRFocusOnViewController.h"
#import "WatchHistoryViewController.h"
#import "TRRemindViewController.h"
#import "CameraViewController.h"
#import "NewTaskViewController.h"
#import "TRGameViewController.h"
#import "TRMoneyCell.h"
#import "TRTopUpViewController.h"
#import "TRTopViewController.h"
#import "TRLoginOrRegisterview.h"
#import "TRLoginViewController.h"
#import "TRRegisterViewController.h"
#import "TRUserInfoViewController.h"
@interface TRMineViewController ()<UITableViewDelegate,UITableViewDataSource,CardDownAnimationViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *showInfoBtn;
//头像
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//直播按钮
@property (weak, nonatomic) IBOutlet UIButton *meLiveBtn;
//点击登录
@property (weak, nonatomic) IBOutlet UIButton *nickBtn;
@property (weak, nonatomic) IBOutlet UILabel *nickLb;
@property (weak, nonatomic) IBOutlet UIView *openV;

/** title数组 */
@property (nonatomic,strong)NSArray *titleArr;
/** 登录注册view */
@property (nonatomic,strong)TRLoginOrRegisterview *loginOrRegisterview ;

/** 用户 */
@property (nonatomic,strong)TRUserInfo *userInfo;
@end

@implementation TRMineViewController
-(TRUserInfo *)userInfo
{
    if (!_userInfo) {
        _userInfo = [TRUserInfo sharedTRUserInfo];
    }
    return _userInfo;
}
//卡片视图消失时候的代理
-  (void)cardDownAnimationViewDidHide:(CardDownAnimationView *)cardDownView {
    if (cardDownView==self.loginOrRegisterview) {
        [self.loginOrRegisterview removeFromSuperview];
        self.loginOrRegisterview = nil;
    }
}

-(NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"房间管理",@"我的关注",@"观看历史",@"开播提醒",@"新手任务",@"游戏中心"];
    }
    return _titleArr;
}
//我要直播
- (IBAction)clickMeNowLiveBtn:(id)sender
{
    if (!self.userInfo.isLogin) {
        
        [self cilckLoginBtn:nil];
        
    }else{
        
    CameraViewController *cameraVc = [[CameraViewController alloc] init];
    [self presentViewController:cameraVc animated:YES completion:nil];
        
    }
}


//意见反馈
- (IBAction)clickLeftBtnitem:(id)sender
{
    UserFeedBackViewController *feedVC = [UserFeedBackViewController new];
    feedVC.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    feedVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:feedVC animated:YES];
}
//系统设置
- (IBAction)clickRightBtnItem:(id)sender
{
    TRSetViewController *TVC = [TRSetViewController new];
    TVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:TVC animated:YES];
}
//查看个人信息
- (IBAction)clickShowUserInfoBtn:(id)sender
{
    WK(weakSelf);
    TRUserInfoViewController *userInfoVC = [[TRUserInfoViewController alloc]initWithBlock:^(UIImage *photoImage) {
        weakSelf.iconImageView.image = photoImage;
    } saveImage:self.iconImageView.image];
   
    userInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoVC animated:YES];
}
//点我登录
- (IBAction)cilckLoginBtn:(id)sender
{
    self.loginOrRegisterview = [TRLoginOrRegisterview new];
    self.loginOrRegisterview.delegate = self;

    WK(weakSelf);
    //微信登录
    [self.loginOrRegisterview.weChatBtn bk_addEventHandler:^(id sender) {
      
        [weakSelf.loginOrRegisterview hide];
        [[CHSocialServiceCenter shareInstance]loginInAppliactionType:CHSocialWeChat controller:self completion:^(CHSocialResponseData *response) {
        
            NSLog(@"微信登录:%@",response);
        }];
        
    } forControlEvents:UIControlEventTouchUpInside];
    //QQ登录
    [self.loginOrRegisterview.QQBtn bk_addEventHandler:^(id sender) {
   
        [weakSelf.loginOrRegisterview hide];
        
        [[CHSocialServiceCenter shareInstance]loginInAppliactionType:CHSocialQQ controller:self completion:^(CHSocialResponseData *response) {
            
            NSLog(@"QQ登录:%@",response.userName);
           
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.userInfo.nickName = @"郑文青";
            weakSelf.userInfo.login = YES;
            UIImage *image = [UIImage imageNamed:@"IMG_3183"];
            weakSelf.userInfo.iconImageStr = [Factory UIImageToBase64Str:image];
            [weakSelf.userInfo saveUserInfoToSandox];
            weakSelf.iconImageView.image = image;
            weakSelf.nickLb.text = weakSelf.userInfo.nickName;
            weakSelf.showInfoBtn.hidden = NO;
            weakSelf.nickLb.hidden = NO;
            weakSelf.openV.hidden = NO;
            weakSelf.nickBtn.hidden = YES;
            [weakSelf.view setNeedsLayout];
            [weakSelf.tableView reloadData];
        });
       
    } forControlEvents:UIControlEventTouchUpInside];
    //微博登录
    [self.loginOrRegisterview.weiboBtn bk_addEventHandler:^(id sender) {
     
        [weakSelf.loginOrRegisterview hide];
        [[CHSocialServiceCenter shareInstance]loginInAppliactionType:CHSocialSina controller:self completion:^(CHSocialResponseData *response) {
           
            NSLog(@"微博登录:%@",response);
        }];
        
    } forControlEvents:UIControlEventTouchUpInside];
    //账号登录
    [self.loginOrRegisterview.accountBtn bk_addEventHandler:^(id sender) {
       
        [weakSelf.loginOrRegisterview hide];
        TRLoginViewController *loginVC = [TRLoginViewController new];
        loginVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:loginVC animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    //注册
    [self.loginOrRegisterview.registerBtn bk_addEventHandler:^(id sender) {
        
        [weakSelf.loginOrRegisterview hide];
        TRRegisterViewController *registerVC = [TRRegisterViewController new];
        registerVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:registerVC animated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.loginOrRegisterview show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

    self.navigationController.navigationBar.shadowImage =[UIImage new];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = kBGColor;
    [self.meLiveBtn setRoundRectLayerCornerRadius:15 borderWidth:1 borderColor:kRGBA(43, 255, 255, 1.0)];
    [self.iconImageView setRoundBorderWidth:1 borderColor:kRGBA(75, 155, 233, 1.0)];
}
-(void)viewWillAppear:(BOOL)animated
{

    if (self.userInfo.isLogin) {
        [self.userInfo loadUserInfoToSandox];
        self.showInfoBtn.hidden = NO;
        self.nickLb.hidden = NO;
        self.openV.hidden = NO;
        self.nickBtn.hidden = YES;
        self.nickLb.text = self.userInfo.nickName;
        
        NSString *imageStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"iconImageStr"];
        if (imageStr.length == 0 ) {
            self.iconImageView.image = [UIImage imageNamed:@"icon1111"];
        }else {
            UIImage *image = [Factory Base64StrToUIImage:self.userInfo.iconImageStr];
            self.iconImageView.image = image;
        }
        [self.tableView reloadData];
    }else{
        self.nickLb.hidden = YES;
        self.openV.hidden = YES;
        self.showInfoBtn.hidden = YES;
        self.nickBtn.hidden = NO;
        self.iconImageView.image = [UIImage imageNamed:@"icon1111"];
        [self.tableView reloadData];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  
    if (self.userInfo.isLogin) {
        return 2;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (self.userInfo.isLogin) {
        if (section == 0) {
            return 1;
        }
        return 6;
    }
    
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.userInfo.isLogin) {
        
        
        if (indexPath.section == 0) {
            //显示平台币 和充值
            TRMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRMoneyCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
               [cell.topUpBtn addTarget:self action:@selector(clickTopUpBtn) forControlEvents:UIControlEventTouchUpInside];

            return cell;
        }
    }
        MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell" forIndexPath:indexPath];
        cell.iconImageView.image = [UIImage imageNamed:self.titleArr[indexPath.row]];
        cell.titleLb.text = self.titleArr[indexPath.row];
        return cell;

}
-(void)clickTopUpBtn{
    TRTopViewController *topVC = [TRTopViewController new];
    topVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:topVC animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //标记是否是登录过的分区数
    NSInteger num = 0;
    
    if (self.userInfo.isLogin) {
         num = 1;
    }
    
    if (indexPath.section == num) {
        
        if (!self.userInfo.isLogin) {
            
            [self cilckLoginBtn:nil];
            
        }else{

            if (indexPath.row == 0) {
                TRRoomViewController *roomVC = [TRRoomViewController new];
                roomVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:roomVC animated:YES];
            }else if (indexPath.row == 1){
                TRFocusOnViewController *focusVC = [TRFocusOnViewController new];
                focusVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:focusVC animated:YES];
            }else if (indexPath.row == 2){
                WatchHistoryViewController *watchVC = [WatchHistoryViewController new];
                watchVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:watchVC animated:YES];
            }else if (indexPath.row == 3){
                TRRemindViewController *remindVC = [TRRemindViewController new];
                remindVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:remindVC animated:YES];
            }else if (indexPath.row == 4){
                NewTaskViewController *taskVC = [NewTaskViewController new];
                taskVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:taskVC animated:YES];
            }else{
                TRGameViewController *gameVC = [TRGameViewController new];
                gameVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:gameVC animated:YES];
            }
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
@end
