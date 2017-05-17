//
//  FMGVideoPlayView.m
//  02-远程视频播放(AVPlayer)
//
//  Created by apple on 15/8/16.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "FMGVideoPlayView.h"
#import "FullViewController.h"

void *kRateDidChangeKVO         = &kRateDidChangeKVO;
void *kStatusDidChangeKVO       = &kStatusDidChangeKVO;
void *kTimeRangesKVO            = &kTimeRangesKVO;


@interface FMGVideoPlayView()<DanmakuDelegate>


@property(nonatomic,assign)id timeObserver;
/** 属性 */
@property (nonatomic,assign)NSInteger playing;;

@property(nonatomic, strong)UIButton *selButton;

@property (nonatomic,strong)DanmakuView *danmakuView; //弹幕
/** 开始弹幕的时间节点 */
@property (nonatomic,assign)float timeFloat;

/* 播放器 */
@property (nonatomic, strong) AVPlayer *player;

// 播放器的Layer
@property (weak, nonatomic) AVPlayerLayer *playerLayer;

/* playItem */
@property (nonatomic, weak) AVPlayerItem *currentItem;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIView *toolView;

@property (strong, nonatomic) IBOutlet UIButton *backButton;

@property (strong, nonatomic) IBOutlet UIButton *ShareButton;

@property (strong, nonatomic) IBOutlet UIButton *Big_Sml;


// 记录当前是否显示了工具栏
@property (assign, nonatomic) BOOL isShowToolView;

/* 定时器 */
@property (nonatomic, strong) NSTimer *progressTimer;

/* 工具栏的显示和隐藏 */
@property (nonatomic, strong) NSTimer *showTimer;

/* 工具栏展示的时间 */
@property (assign, nonatomic) NSTimeInterval showTime;

/* 全屏控制器 */
@property (nonatomic, strong) FullViewController *fullVc;

#pragma mark - 监听事件的处理

- (IBAction)switchOrientation:(UIButton *)sender;

- (IBAction)tapAction:(UITapGestureRecognizer *)sender;

- (IBAction)BackAction:(UIButton *)sender;

- (IBAction)ShareAction:(UIButton *)sender;
- (IBAction)clickBulletBtn:(UIButton *)sender;




@end

@implementation FMGVideoPlayView


// 快速创建View的方法
+ (instancetype)videoPlayView
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"FMGVideoPlayView" owner:nil options:nil] firstObject];
}
- (AVPlayer *)player
{
    if (!_player) {

        
        // 初始化Player和Layer
        _player = [[AVPlayer alloc] init];

        [_player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:kRateDidChangeKVO];
        [_player addObserver:self forKeyPath:@"currentItem.status" options:NSKeyValueObservingOptionNew context:kStatusDidChangeKVO];
        [_player addObserver:self forKeyPath:@"currentItem.loadedTimeRanges" options:NSKeyValueObservingOptionNew context:kTimeRangesKVO];

        //添加开始弹幕的通知
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveNoticationChanged:) name:@"playLiveChange" object:nil];
    }
    return _player;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.imageView.layer addSublayer:self.playerLayer];

    // 设置工具栏的状态
    self.toolView.alpha = 0;
    self.isShowToolView = NO;
    
    [self showToolView:YES];
}

#pragma mark - 观察者对应的方法

#pragma mark - 重新布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageView sd_setImageWithURL:self.imageURL placeholderImage:[UIImage imageNamed:@"主播正在赶来"]];
    self.playerLayer.frame = self.bounds;
}

#pragma mark - 设置播放的视频
- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;

    NSURL *url = [NSURL URLWithString:urlString];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    self.currentItem = item;
    
    [self.player replaceCurrentItemWithPlayerItem:self.currentItem];
  
//    [self.player play];

   
}
- (void)dealloc
{
    NSLog(@"控制器销毁");
    [_player pause];
    
    [_player removeTimeObserver:_timeObserver];
   
    //通知:
    [_player removeObserver:self forKeyPath:@"rate" context:kRateDidChangeKVO];
    [_player removeObserver:self forKeyPath:@"currentItem.loadedTimeRanges" context:kTimeRangesKVO];
    [_player removeObserver:self forKeyPath:@"currentItem.status" context:kStatusDidChangeKVO];
    [_player replaceCurrentItemWithPlayerItem:nil];
    _currentItem = nil;
    _player = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
 
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

    if (kRateDidChangeKVO == context) {
//        NSLog(@"播放速度变化: %.5f", _player.rate);
        if (_player.rate == 0.0) {
            
            if (_playing > 0) {
                NSLog(@" 暂停");
                self.playing = 0;
                return;
            }
            
        }
    } else if (kStatusDidChangeKVO == context) {
//        NSLog(@"播放状态改变: %li", (long)_player.status);
        
        [self showBusyHUDToView:self];
        
        if (_player.status == AVPlayerStatusReadyToPlay) {
            NSLog(@" 准备播放....");
            //查看播放进度
            __block NSString *timeStr;
            WK(weakSelf);
            _timeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(0.5, 600) queue:nil usingBlock:^(CMTime time) {
                //  NSLog(@"播放时间 %.5f", CMTimeGetSeconds(time));
                timeStr =[NSString stringWithFormat:@"%.5f",CMTimeGetSeconds(time)];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"playLiveChange" object:weakSelf userInfo:@{@"playLive":@"YES",@"time":timeStr}];
            }];
            [self hideBusyHUD];
        }
    } else if (kTimeRangesKVO == context) {
//        NSLog(@"加载时间范围改变");
        NSArray *timeRanges = (NSArray *)[change objectForKey:NSKeyValueChangeNewKey];
        if (timeRanges && [timeRanges count]) {

                if (!_playing) {
                  
                    [_player play];
                    _playing = 1;
                }
        }
    }
}
// 是否显示工具的View
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [self showToolView:!self.isShowToolView];
    
}

- (IBAction)BackAction:(UIButton *)sender {
    
    [_player pause];
    [_player removeTimeObserver:_timeObserver];
    
    //通知:
    [_player removeObserver:self forKeyPath:@"rate" context:kRateDidChangeKVO];
    [_player removeObserver:self forKeyPath:@"currentItem.loadedTimeRanges" context:kTimeRangesKVO];
    [_player removeObserver:self forKeyPath:@"currentItem.status" context:kStatusDidChangeKVO];
    [_player replaceCurrentItemWithPlayerItem:nil];
    _currentItem = nil;
    _player = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    if (sender.selected) {
        
        _Big_Sml.selected=NO;
        [self videoplayViewSwitchOrientation:!sender.selected];
    }
    else {
        
        [self.delegate backAction];
    }
    
}
//分享
- (IBAction)ShareAction:(UIButton *)sender {
    
    [self.delegate shareAction];
}
//弹幕
- (IBAction)clickBulletBtn:(UIButton *)sender
{
    self.bulletBtn.selected = !self.bulletBtn.selected;
    if ( self.bulletBtn.selected) {
       
        [self.danmakuView stop];
        
    }else{
   
        [self.danmakuView start];
    }
}



- (void)showToolView:(BOOL)isShow
{
    self.toolView.alpha=!self.isShowToolView;
   
    [UIView animateWithDuration:1.0 animations:^{
        self.isShowToolView = !self.isShowToolView;
        self.backButton.hidden=!self.isShowToolView;
        self.ShareButton.hidden=!self.isShowToolView;
    }];
}


#pragma mark - 切换屏幕的方向

- (IBAction)switchOrientation:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [self videoplayViewSwitchOrientation:sender.selected];
}

- (void)videoplayViewSwitchOrientation:(BOOL)isFull
{
    _backButton.selected=isFull;
    //创建弹幕管理类
    DanmakuConfiguration *configuration = [[DanmakuConfiguration alloc] init];
    configuration.duration = 6.5;
    configuration.paintHeight = 21;
    configuration.fontSize = 14;
    configuration.largeFontSize = 16;
    configuration.maxLRShowCount = 30;
    configuration.maxShowCount = 45;

    if (isFull) {
    
        [self.contrainerViewController presentViewController:self.fullVc animated:NO completion:^{
            [self.fullVc.view addSubview:self];
            self.center = self.fullVc.view.center;
            
            [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                self.frame = self.fullVc.view.bounds;
            } completion:nil];
            
            [self.danmakuView stop];
            CGRect rect =  CGRectMake(0, 20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-20);
            self.danmakuView = [[DanmakuView alloc] initWithFrame:rect configuration:configuration];
            self.danmakuView.delegate = self;
            [self.fullVc.view insertSubview:self.danmakuView aboveSubview:self];
            NSString *danmakufile = [[NSBundle mainBundle] pathForResource:@"danmakufile" ofType:nil];
            NSArray *danmakus = [NSArray arrayWithContentsOfFile:danmakufile];
            //添加数据源
            [self.danmakuView prepareDanmakus:danmakus];
        }];
    } else {
    
        [self.fullVc dismissViewControllerAnimated:NO completion:^{
            [self.contrainerViewController.view addSubview:self];
            
            [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                self.frame = CGRectMake(0, 20, self.contrainerViewController.view.bounds.size.width, self.contrainerViewController.view.bounds.size.width * 9 / 16);
            } completion:nil];
            
            [self.danmakuView stop];
            CGRect rect =  CGRectMake(0, 20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-20);
            self.danmakuView = [[DanmakuView alloc] initWithFrame:rect configuration:configuration];
            self.danmakuView.delegate = self;
            //            [self addSubview:self.danmakuView];
            [self.contrainerViewController.view insertSubview:self.danmakuView aboveSubview:self];
            NSString *danmakufile = [[NSBundle mainBundle] pathForResource:@"danmakufile" ofType:nil];
            NSArray *danmakus = [NSArray arrayWithContentsOfFile:danmakufile];
            //添加数据源
            [self.danmakuView prepareDanmakus:danmakus];
        }];
    }
}
//收到自定义的弹幕通知
-(void)saveNoticationChanged:(NSNotification *)notication
{
    NSString *str = notication.userInfo[@"playLive"];
    NSString *timeStr = notication.userInfo[@"time"];
    self.timeFloat = [timeStr floatValue];
    if ([str isEqualToString:@"YES"]) {
        if(self.bulletBtn.selected){
           
            [self.danmakuView stop];
        }
        else {
            if(self.danmakuView.isPrepared) {
            
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

#pragma mark - 懒加载代码
- (FullViewController *)fullVc
{
    if (_fullVc == nil) {
        _fullVc = [[FullViewController alloc] init];
    }
    return _fullVc;
}

@end
