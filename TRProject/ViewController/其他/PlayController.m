//
//  PlayController.m
//  TRProject
//
//  Created by 郑文青 on 16/7/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PlayController.h"
#import "YFViewPager.h"
#import "oneView.h"
#import "TwoView.h"
#import "FMGVideoPlayView.h"
#import "FullViewController.h"
#import "TYAlertController+BlurEffects.h"
#import "ShareView.h"
#import "UIView+TYAlertView.h"
#import "BarrageView.h"
#import <sqlite3.h>
#import "TRDBManager.h"
#import "TRFocusModel.h"
#import "TRWatchHistoryModel.h"
#import "TRBottomGiftView.h"
#import "TRTopUpViewController.h"
#import "TRGiftView.h"
#import "TRMessage.h"
#import "TRLoginOrRegisterview.h"
#import "TRLoginViewController.h"
#import "TRRegisterViewController.h"
@interface PlayController ()<FMGVideoPlayViewDelegate,UIPopoverPresentationControllerDelegate,CardDownAnimationViewDelegate,DanmakuDelegate>
@property (nonatomic,strong)YFViewPager *viewPager;
@property (nonatomic,strong)DanmakuView *danmakuView; //弹幕
/** 属性 */
@property (nonatomic,assign)float timeFloat;
@property (nonatomic,strong)FMGVideoPlayView *FMGVideoPlayView;
@property (nonatomic,strong)oneView *oneView;
@property (nonatomic,strong)TwoView *twoView;
//弹幕框
@property (nonatomic,strong)BarrageView *BarrageView;
/** 礼物视图 */
@property (nonatomic,strong)TRGiftView *giftView;
/** 是否已经关注过的 */
@property (nonatomic,copy)NSString *focusName;
/** 头像 */
@property (nonatomic,strong)UIImage *iconImage;
/** 弹幕字符串 */
@property (nonatomic,copy)NSString *barrageStr;
/** 登录注册view */
@property (nonatomic,strong)TRLoginOrRegisterview *loginOrRegisterview ;
@end

@implementation PlayController

- (void)cilckLoginBtn
{
    self.loginOrRegisterview = [TRLoginOrRegisterview new];
    self.loginOrRegisterview.delegate = self;
    
    WK(weakSelf);
    //微信登录
    [self.loginOrRegisterview.weChatBtn bk_addEventHandler:^(id sender) {
        
        [weakSelf.loginOrRegisterview hide];
        [[CHSocialServiceCenter shareInstance]loginInAppliactionType:CHSocialWeChat controller:self completion:^(CHSocialResponseData *response) {
            
            NSLog(@"%@",response);
        }];
        
    } forControlEvents:UIControlEventTouchUpInside];
    //QQ登录
    [self.loginOrRegisterview.QQBtn bk_addEventHandler:^(id sender) {
        
        [weakSelf.loginOrRegisterview hide];
        
        [[CHSocialServiceCenter shareInstance]loginInAppliactionType:CHSocialQQ controller:self completion:^(CHSocialResponseData *response) {
           
            NSLog(@"%@",response);
        }];
        TRUserInfo *userInfo = [TRUserInfo new];
        userInfo.login = YES;
        weakSelf.oneView.loginBtn.hidden = YES;
    } forControlEvents:UIControlEventTouchUpInside];
    //微博登录
    [self.loginOrRegisterview.weiboBtn bk_addEventHandler:^(id sender) {
        
        [weakSelf.loginOrRegisterview hide];
        [[CHSocialServiceCenter shareInstance]loginInAppliactionType:CHSocialSina controller:self completion:^(CHSocialResponseData *response) {
           
            NSLog(@"%@",response);
        }];
        
    } forControlEvents:UIControlEventTouchUpInside];
    //账号登录
    [self.loginOrRegisterview.accountBtn bk_addEventHandler:^(id sender) {
        
        [weakSelf.loginOrRegisterview hide];
        TRLoginViewController *loginVC = [TRLoginViewController new];
        loginVC.isModel = YES;
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navi.navigationController.navigationBar.backgroundColor = [UIColor redColor];
        [weakSelf presentViewController:navi animated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    //注册
    [self.loginOrRegisterview.registerBtn bk_addEventHandler:^(id sender) {
        
        [weakSelf.loginOrRegisterview hide];
        TRRegisterViewController *registerVC = [TRRegisterViewController new];
        registerVC.isModel = YES;
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:registerVC];
          [weakSelf presentViewController:navi animated:YES completion:nil];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.loginOrRegisterview show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor blackColor];
    [UIApplication sharedApplication].statusBarStyle= UIStatusBarStyleLightContent;
    
    [self setupVideoPlayView];//创建播放视图
    [self initViewPager];//创建下面的子视图
    //弹幕视图
    _BarrageView = [[BarrageView alloc] initWithFrame:CGRectMake(5, kScreenH - self.oneView.textField.bounds.size.height - 215, 220, 200)];
    
    _BarrageView.hidden = YES;
    [self.view addSubview:_BarrageView];
    //创建观看历史的数据库
    [self setWatchHistoryDatabase];
    //设置电池栏
    [self preferredStatusBarStyle];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    //返回白色
    return UIStatusBarStyleLightContent;
    //返回黑色
    //return UIStatusBarStyleDefault;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)dealloc
{
    NSLog(@"播放控制器销毁了");
}
//创建弹幕滚动效果
-(void)viewWillAppear:(BOOL)animated
{
   
    TRUserInfo *userInfo = [TRUserInfo new];
    if (userInfo.isLogin) {
        self.oneView.loginBtn.hidden = YES;
    }
    [self setNeedsStatusBarAppearanceUpdate];
    //聊天信息通知
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveUserNotification:) name:@"MessageChange" object:nil];
    //弹幕通知
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveBarrageMessageChange:) name:@"barrageMessageChange" object:nil];
    //添加自定义弹幕通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveNoticationChanged:) name:@"playLiveChange" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveFullNoticationChanged:) name:@"FullVCChange" object:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)saveFullNoticationChanged:(NSNotification *)notification
{
    NSLog(@"接收到满屏状态通知");
    NSString *saveStr  = notification.userInfo[@"FullVC"];
    if ([saveStr isEqualToString:@"YES"]) {
        NSLog(@"现在是满屏状态");
        [self.danmakuView stop];
        
    }
}

-(void)saveUserNotification:(NSNotification *)notification
{
    NSLog(@"接收到发送的消息弹幕通知");
    NSString *saveStr = notification.userInfo[@"message"];
    //随机 y 的值
    NSInteger randY = arc4random() %  150;
    SXMarquee *mar2 = [[SXMarquee alloc]initWithFrame:CGRectMake(0, randY, kScreenW, 20) speed:4 Msg:saveStr bgColor:[UIColor clearColor] txtColor:[UIColor whiteColor]];
   // mar2.isRepeat = YES; // 默认是关闭的,打开就重复滚动
    mar2.userInteractionEnabled = NO;
    [mar2 changeMarqueeLabelFont:[UIFont boldSystemFontOfSize:13]];
    [mar2 start];
    [self.FMGVideoPlayView addSubview:mar2];
 
}
//接收到弹幕通知
-(void)saveBarrageMessageChange:(NSNotification *)notification
{
    NSLog(@"接收到弹幕通知");
    NSString *saveStr = notification.userInfo[@"barrageMessage"];
    //随机 y 的值
    NSInteger randY = arc4random() % 150;
   
    SXMarquee *mar2 = [[SXMarquee alloc]initWithFrame:CGRectMake(0, randY, kScreenW, 20) speed:4 Msg:saveStr bgColor:[UIColor clearColor] txtColor:[UIColor whiteColor]];
    // mar2.isRepeat = YES; // 默认是关闭的,打开就重复滚动
    mar2.userInteractionEnabled = NO;
    [mar2 changeMarqueeLabelFont:[UIFont boldSystemFontOfSize:13]];
    [mar2 start];
    [self.FMGVideoPlayView addSubview:mar2];
}

//创建播放器
- (void)setupVideoPlayView
{
    
    FMGVideoPlayView *playView=[FMGVideoPlayView videoPlayView];
    playView.delegate=self;
    self.FMGVideoPlayView = playView;
    // 视频资源路径
    [playView setUrlString:self.Hls_liveStr];
    playView.Onlines.text = self.Hls_onlines;
    playView.imageURL = self.Hls_imageURL;
    //测试用
//    [playView setUrlString:@"http://hls.quanmin.tv/live/7035/playlist.m3u8"];
    // 播放器显示位置（竖屏时）
    playView.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
    // 添加到当前控制器的view上
    [self.view addSubview:playView];
    
    // 指定一个作为播放的控制器
    playView.contrainerViewController = self;
    //开始弹幕
    [self startBullteView];
}
-(void)startBullteView
{
    CGRect rect =  CGRectMake(0, 20, CGRectGetWidth(self.FMGVideoPlayView.bounds), CGRectGetHeight(self.FMGVideoPlayView.bounds)-30);
    DanmakuConfiguration *configuration = [[DanmakuConfiguration alloc] init];
    configuration.duration = 6.5;
    configuration.paintHeight = 21;
    configuration.fontSize = 14;
    configuration.largeFontSize = 16;
    configuration.maxLRShowCount = 30;
    configuration.maxShowCount = 45;
    self.danmakuView = [[DanmakuView alloc] initWithFrame:rect configuration:configuration];
    self.danmakuView.delegate = self;
    [self.FMGVideoPlayView addSubview:self.danmakuView];
    NSString *danmakufile = [[NSBundle mainBundle] pathForResource:@"danmakufile" ofType:nil];
    NSArray *danmakus = [NSArray arrayWithContentsOfFile:danmakufile];
    //添加数据源
    [self.danmakuView prepareDanmakus:danmakus];
}
//收到自定义的弹幕通知
-(void)saveNoticationChanged:(NSNotification *)notication
{
    
    NSString *str = notication.userInfo[@"playLive"];
    NSString *timeStr = notication.userInfo[@"time"];
    self.timeFloat = [timeStr floatValue];
    if ([str isEqualToString:@"YES"]) {
        if (self.FMGVideoPlayView.bulletBtn.selected) {
     
            [self.danmakuView stop];
        }else{
            if (self.danmakuView.isPrepared) {
                
                [self.danmakuView start];
            }
        }
    }
}
#pragma mark -
- (float)danmakuViewGetPlayTime:(DanmakuView *)danmakuView
{
    return self.timeFloat;
}

- (BOOL)danmakuViewIsBuffering:(DanmakuView *)danmakuView
{
    return NO;
}

- (void)danmakuViewPerpareComplete:(DanmakuView *)danmakuView
{
    [self.danmakuView start];
}

//观看历史的数据库
-(void)setWatchHistoryDatabase
{
    //1.创建数据库路径
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [cachesPath stringByAppendingPathComponent:@"watchHistory.db"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    //2.创建表
    if ([database open]) {
        BOOL isSucess = [database executeUpdate:@"create table if not exists watchHistory (id integer primary key,Hls_name text,Hls_title text ,imageStr text, Hls_onlines text,Hls_liveStr text,avatarStr text)"];
        if (!isSucess) {
            NSLog(@"创建表失败:%@", database.lastError);
        }
    }
    [database close];

    [self creatFocusDatabaseString:@"watchHistory"];
    
    NSMutableArray *arr = [NSMutableArray array];
    if ([database open]) {
        FMResultSet *resultSet = [database executeQuery:@"select * from watchHistory"];
        while ([resultSet next]) {
            //从记录中获取每个字段(根据不同的字段类型选择不同的方法)
            //name
            NSString *focusName = [resultSet stringForColumn:@"Hls_name"];
            
            [arr addObject:focusName];
        }
        
    }
    [database close];
    //循环比较有没有关注过的名字
    for (int i = 0; i < arr.count; i++) {
        if ([arr[i] isEqualToString:self.Hls_name]) {//有 就选中 并返回
            [TRWatchHistoryModel removeWatchHistory:self.Hls_name];
            break;
        }
    }
    [self creatFocusDatabaseString:@"watchHistory"];
    


}
//创建下面的子视图
-(void)initViewPager
{
    UIView *middleView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.width * 9 / 16 +10, self.view.bounds.size.width, 65)];
    middleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:middleView];
    //创建中间头像视图
    
    [self creatMiddleView:middleView];
    
    //创建聊天和排行
    [self creatChatAndRankingView];
    
}
 //创建中间头像视图
-(void)creatMiddleView:(UIView *)middleView
{
    UIImageView *imageView = [UIImageView new];
    //主播头像
    [imageView sd_setImageWithURL:self.Hls_avatarURL placeholderImage:[UIImage imageNamed:@"主播正在赶来"]];
    self.iconImage = imageView.image;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 20;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.borderWidth = 1;
    [middleView addSubview:imageView];
    //名称
    UILabel *nickLb = [UILabel new];
    nickLb.text = self.Hls_name;
    
    nickLb.textAlignment = NSTextAlignmentLeft;
    nickLb.textColor = [UIColor blackColor];
    nickLb.font = [UIFont systemFontOfSize:12];
    [middleView addSubview:nickLb];
    //描述
    UILabel *titleLb = [UILabel new];
    titleLb.text = self.Hls_title;
    
    titleLb.textColor = [UIColor grayColor];
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.font = [UIFont systemFontOfSize:10];
    [middleView addSubview:titleLb];
    
    //关注
    UIButton *focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [focusBtn setImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
    [focusBtn setImage:[UIImage imageNamed:@"已关注"] forState:UIControlStateSelected];
    [middleView addSubview:focusBtn];
    
    UILabel *focusLb = [UILabel new];
 
    focusLb.textColor = [UIColor redColor];
    focusLb.textAlignment = NSTextAlignmentCenter;
    focusLb.font = [UIFont systemFontOfSize:10];
    focusLb.text = @"关注";
    [middleView addSubview:focusLb];
    
    
    //查询是否已经关注过了
    //1.创建数据库路径
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [cachesPath stringByAppendingPathComponent:@"focus.db"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    //2.创建表
    if ([database open]) {
        BOOL isSucess = [database executeUpdate:@"create table if not exists focus (id integer primary key,Hls_name text,Hls_title text ,imageStr text, Hls_onlines text,Hls_liveStr text, avatarStr text)"];
        if (!isSucess) {
            NSLog(@"创建表失败:%@", database.lastError);
        }
    }
    [database close];
    NSMutableArray *arr = [NSMutableArray array];
    if ([database open]) {
        FMResultSet *resultSet = [database executeQuery:@"select * from focus"];
        while ([resultSet next]) {
            //从记录中获取每个字段(根据不同的字段类型选择不同的方法)
            //name
           NSString *focusName = [resultSet stringForColumn:@"Hls_name"];
            
            [arr addObject:focusName];
        }
      
    }
    
   //循环比较有没有关注过的名字
    for (int i = 0; i < arr.count; i++) {
        if ([arr[i] isEqualToString:self.Hls_name]) {//有 就选中 并返回
            focusBtn.selected = YES;
            focusLb.textColor = [UIColor lightGrayColor];
            focusLb.textAlignment = NSTextAlignmentCenter;
            focusLb.font = [UIFont systemFontOfSize:10];
            focusLb.text = @"已关注";
            break;
        }else{
            
            focusBtn.selected = NO;
        }
    }
     [database close];
    WK(weakSelf);
    //点击关注
    [focusBtn bk_addEventHandler:^(id sender) {
        [weakSelf.oneView endEditing:YES];
        TRUserInfo *userInfo = [TRUserInfo new];
        if (!userInfo.isLogin) {
            [weakSelf cilckLoginBtn];
            return ;
        }
        if (focusBtn.selected == NO) {//关注
            focusLb.text = @"已关注";
            focusLb.textColor = [UIColor lightGrayColor];
            focusLb.textAlignment = NSTextAlignmentCenter;
            focusLb.font = [UIFont systemFontOfSize:10];
            NSString *message = [NSString stringWithFormat:@"是否对 【%@】 设置开播提醒",weakSelf.Hls_name];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"关注成功" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self.view showSuccess:@"设置提醒成功"];
            }];
            UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
              
            }];
            [okBtn setValue:kRGBA(22, 176, 254,1.0) forKey:@"titleTextColor"];
            [cancelBtn setValue:kRGBA(22, 176, 254,1.0) forKey:@"titleTextColor"];
            [alert addAction:okBtn];
            [alert addAction:cancelBtn];
            [self presentViewController:alert animated:YES completion:nil];
            //创建关注的数据库
            [weakSelf creatFocusDatabaseString:@"focus"];
        }else{//取消关注
            focusLb.text = @"关注";
            focusLb.textColor = [UIColor redColor];
            focusLb.textAlignment = NSTextAlignmentCenter;
            focusLb.font = [UIFont systemFontOfSize:10];
            [weakSelf.view showWarning:@"取消关注"];
            //删除数据库中的数据
            [TRFocusModel removeFocus:weakSelf.Hls_name];
        }
       

          focusBtn.selected = !focusBtn.selected;
    } forControlEvents:UIControlEventTouchUpInside];
    
    focusBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//设置button的内容竖向居中。。设置content是title和image一起变化
    
    
    //分享
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    
    [shareBtn bk_addEventHandler:^(id sender) {
        
        [self shareAction];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    shareBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [middleView addSubview:shareBtn];
    UILabel *shareLb = [UILabel new];
    shareLb.textColor = [UIColor grayColor];
    shareLb.textAlignment = NSTextAlignmentCenter;
    shareLb.font = [UIFont systemFontOfSize:10];
    shareLb.text = @"分享";
    [middleView addSubview:shareLb];
    //设置约束
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(0);
        make.width.equalTo(40);
        make.height.equalTo(40);
        make.left.equalTo(10);
    }];
    [nickLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.left.equalTo(imageView.mas_right).equalTo(10);
        make.bottom.equalTo(titleLb.mas_top).equalTo(0);
        make.right.equalTo(focusBtn.mas_left).equalTo(-10);
        make.height.equalTo(20);
    }];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(20);
        make.left.equalTo(imageView.mas_right).equalTo(10);
        make.top.equalTo(nickLb.mas_bottom).equalTo(0);
        make.right.equalTo(focusBtn.mas_left).equalTo(-10);
    }];
    [focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(10);
        make.height.equalTo(25);
        make.width.equalTo(25);
        make.right.equalTo(shareBtn.mas_left).equalTo(-10);
        
    }];
    [focusLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(15);
        make.top.equalTo(focusBtn.mas_bottom).equalTo(0);
        make.width.equalTo(40);
        make.right.equalTo(shareBtn.mas_left).equalTo(-2);
    }];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.height.equalTo(25);
        make.width.equalTo(25);
        make.right.equalTo(-10);
    }];
    [shareLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(15);
        make.top.equalTo(shareBtn.mas_bottom).equalTo(0);
        make.width.equalTo(25);
        make.right.equalTo(-10);
    }];

}
//创建聊天和排行
-(void)creatChatAndRankingView
{
    WK(weakSelf);
    self.oneView = [[oneView alloc]init];
    self.oneView.backName = self.Hls_name;
    TRUserInfo *userInfo = [TRUserInfo new];
    if (userInfo.isLogin == NO) {
        self.oneView.loginBtn.hidden = NO;
        
        [self.oneView.loginBtn bk_addEventHandler:^(id sender) {
            [weakSelf cilckLoginBtn];
        } forControlEvents:UIControlEventTouchUpInside];
    }else{
        self.oneView.loginBtn.hidden = YES;
    }
  

    UITapGestureRecognizer *tapGester = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap:)];
    tapGester.numberOfTapsRequired = 1;
    [self.oneView addGestureRecognizer:tapGester];
    //弹幕
    [self.oneView.barrageBtn bk_addEventHandler:^(id sender) {
        
        [UIView animateWithDuration:5 animations:^{
            weakSelf.BarrageView.hidden = !weakSelf.BarrageView.hidden;
        }];
        
    } forControlEvents:UIControlEventTouchUpInside];
    //礼物
    [self.oneView.giftBtn bk_addEventHandler:^(id sender) {
        
        TRBottomGiftView *giftView = [TRBottomGiftView createViewFromNib];
        [giftView.top_upBtn bk_addEventHandler:^(id sender) {
            
            [giftView hideView];
            TRTopUpViewController *topVC = [TRTopUpViewController new];
            topVC.mark = YES;
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:topVC];
            
            [weakSelf presentViewController:navi animated:YES completion:nil];
        } forControlEvents:UIControlEventTouchUpInside];
        
        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:giftView preferredStyle:TYAlertControllerStyleActionSheet];
        alertController.backgoundTapDismissEnable = YES;
        [weakSelf presentViewController:alertController animated:YES completion:nil];
        
    } forControlEvents:UIControlEventTouchUpInside];
    //充值
    
    [self.oneView.top_upBtn bk_addEventHandler:^(id sender) {
        
        weakSelf.giftView = [TRGiftView new];
        weakSelf.giftView.delegate = self;
        [weakSelf.giftView.top_upBtn bk_addEventHandler:^(id sender) {
            [weakSelf.giftView hide];
            TRTopUpViewController *topVC = [TRTopUpViewController new];
            topVC.mark = YES;
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:topVC];
            
            [weakSelf presentViewController:navi animated:YES completion:nil];
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        [weakSelf.giftView show];

       
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.twoView = [[TwoView alloc]init];
    
    NSArray *titles = [[NSArray alloc] initWithObjects:
                       @"聊天",
                       @"排行", nil];
    
    NSArray *views = [[NSArray alloc] initWithObjects:
                      self.oneView,
                      self.twoView, nil];
    
    self.viewPager = [[YFViewPager alloc] initWithFrame:CGRectMake(0,kScreenW * 9 / 16+65, kScreenW ,kScreenH-kScreenW * 9 / 16 - 65)
                                                 titles:titles
                                                  icons:nil
                                          selectedIcons:nil
                                                  views:views];
    [self.view addSubview:self.viewPager];
    
    //点中 聊天 和 排行 的 title
    [self.viewPager didSelectedBlock:^(id viewPager, NSInteger index) {
        switch (index) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                
            }
                break;
            default:
                break;
        }
    }];

}
//卡片视图消失时候的代理
-  (void)cardDownAnimationViewDidHide:(CardDownAnimationView *)cardDownView {
    if (cardDownView==self.giftView) {
        [self.giftView removeFromSuperview];
        self.giftView = nil;
    }else if (cardDownView==self.loginOrRegisterview) {
        [self.loginOrRegisterview removeFromSuperview];
        self.loginOrRegisterview = nil;
    }
}
//把关注的数据添加到数据库里面
-(void)creatFocusDatabaseString:(NSString *)databaseName
{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *nameStr = [NSString stringWithFormat:@"%@.db",databaseName];
    NSString *dbPath = [cachesPath stringByAppendingPathComponent:nameStr];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    //把图片url 转成字符串
    NSString *imageStr = [self.Hls_imageURL absoluteString];
    NSString *avatarStr = [self.Hls_avatarURL absoluteString];
    //不用再创建表了,上面已经创建过了
     NSString *insertStr =[NSString stringWithFormat:@"insert into %@ (Hls_name, Hls_title, imageStr,Hls_onlines,Hls_liveStr,avatarStr) values ('%@','%@','%@','%@','%@','%@')",databaseName,self.Hls_name, self.Hls_title, imageStr,self.Hls_onlines,self.Hls_liveStr,avatarStr];
    //3.插入数据
    if ([database open]) {
        BOOL isSuccess = [database executeUpdate:insertStr];
        if (!isSuccess) {
            NSLog(@"插入数据失败:%@", database.lastError);
        }
    }
    [database close];
}

//给oneView 添加手势 隐藏弹幕view
-(void)clickTap:(UIGestureRecognizer *)sender
{
    [self.oneView endEditing:YES];
    self.BarrageView.hidden = YES;
}
#pragma mark FMGVideoPlayViewDelegate
-(void)backAction
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//分享
-(void)shareAction
{
    [self.oneView endEditing:YES];
    
    NSInteger liveStrlenght = self.Hls_liveStr.length - 41;
    NSRange range = {27,liveStrlenght};
    NSString *shareStr = [self.Hls_liveStr substringWithRange:range];
    //网页版的全民直播链接
    NSString *liveStr = [NSString stringWithFormat:@"http://m.quanmin.tv/v/%@?from=singlemessage&isappinstalled=1",shareStr];
   
    ShareView *shareView = [ShareView createViewFromNib];
    
    [shareView setShareController:self Content:self.Hls_title Image:self.iconImage URL:liveStr Title:self.Hls_name];
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:shareView preferredStyle:TYAlertControllerStyleActionSheet];
    alertController.backgoundTapDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
