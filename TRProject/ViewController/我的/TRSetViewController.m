//
//  TRSetViewController.m
//  TRProject
//
//  Created by 郑文青 on 16/7/25.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRSetViewController.h"

@interface TRSetViewController ()
/** 缓存 */
@property (nonatomic,copy)NSString *cachesStr;
@property (nonatomic,copy)NSString *documentPath;
@property (nonatomic,copy)NSString *libraryPath;
@property (nonatomic,copy)NSString *temporaryPath;

@property (nonatomic,strong)UIView *topView;
@end

@implementation TRSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBGColor;
    
    [Factory addBackItemToVC:self];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.title = @"系统设置";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.scrollEnabled = NO;
    [self folderSize];//计算缓存大小
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"非WiFi下播放提醒";
            UISwitch *mySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
            mySwitch.onTintColor = kRGBA(255, 86, 142, 1.0);
            mySwitch.on = YES;
            cell.accessoryView = mySwitch;
            
            
        }else{
            cell.textLabel.text = @"清理缓存";
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
            label.text = self.cachesStr;
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentRight;
            cell.accessoryView = label;
        }
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"关于我们";
        }else{
            cell.textLabel.text = @"给我们评分";
        }
    }
    

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0){
        if (indexPath.row == 1) {
            [self.view showBusyHUD];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.view showSuccess:@"已清除缓存"];
                
            });
            [self cleanCaches:self.libraryPath];
            [self folderSize];
            [self.tableView reloadData];
        }
    }else{
        if (indexPath.row == 0) {
            [UIAlertView bk_showAlertViewWithTitle:@"关于我们" message:@"我是我嗨直播哦!~" cancelButtonTitle:@"我知道了" otherButtonTitles:@[@"我也知道了"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                
            }];
        }else{
            //去AppStore 页面 评论
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/quan-mintv/id1066718693?l=zh&ls=1&mt=8"]];
        }
    }
}
//计算缓存大小
-(void)folderSize
{
    self.documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    self.libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    self.temporaryPath = NSTemporaryDirectory();
    //sdWebImage 缓存的图片
    float imageCache = [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
    
    CGFloat size = [self folderSizeAtPath:self.documentPath] + [self folderSizeAtPath:self.libraryPath] + [self folderSizeAtPath:self.temporaryPath] + imageCache;
    
    NSString *message = size > 1 ? [NSString stringWithFormat:@"%.2fM", size] : [NSString stringWithFormat:@"0M"];
    
    self.cachesStr = message ;
    
}
// 计算目录大小
- (CGFloat)folderSizeAtPath:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    if ([manager fileExistsAtPath:path]) {
        // 获取该目录下的文件，计算其大小
        NSArray *childrenFile = [manager subpathsAtPath:path];
        for (NSString *fileName in childrenFile) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            size += [manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        }
        // 将大小转化为M
        return size / 1024.0 / 1024.0;
    }
    return 0;
}
// 根据路径删除文件
- (void)cleanCaches:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}
@end
