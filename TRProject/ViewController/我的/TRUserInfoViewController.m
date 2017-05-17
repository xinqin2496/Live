//
//  TRUserInfoViewController.m
//  TRProject
//
//  Created by 郑文青 on 16/8/5.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRUserInfoViewController.h"

@interface TRUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UITableView *tableView;
/** title */
@property (nonatomic,strong)NSArray *titleArray;
/** 接收的头像 */
@property (nonatomic,strong)UIImage *iconImage;
/** 头像 */
@property (nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,copy)PHOTO_BLOCK myBlock;

@end

@implementation TRUserInfoViewController
-(instancetype)initWithBlock:(PHOTO_BLOCK)block saveImage:(UIImage *)saveImage
{
    if (self = [super init]) {
        self.myBlock = block;
        self.iconImage = saveImage;
    }
    return self;
}
-(NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"头像",@"昵称",@"手机号",@"邮箱"];
    }
    return _titleArray;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBGColor;
    self.title = @"个人资料";
    [Factory addBackItemToVC:self];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 40)];
    footView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footView;
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [exitBtn setBackgroundColor:kNaviBarBGColor];
    [exitBtn setRoundRectLayerCornerRadius:20 borderWidth:1 borderColor:kNaviBarBGColor];
    [footView addSubview:exitBtn];
    WK(weakSelf);
    [exitBtn bk_addEventHandler:^(id sender) {
        [weakSelf.view showWarning:@"退出登录"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"autoLogin"];
        TRUserInfo *userInfo = [TRUserInfo new];
        userInfo.login = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES]; 
        });
       
    } forControlEvents:UIControlEventTouchUpInside];
    [exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(20);
        make.bottom.equalTo(0);
        make.right.equalTo(-20);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
   
    
    UILabel *titleLb = [UILabel new];
    titleLb.textColor = [UIColor blackColor];
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.height.equalTo(20);
        make.centerY.equalTo(0);
    }];
    titleLb.text = self.titleArray[indexPath.row];
     TRUserInfo *userInfo = [TRUserInfo new];
    if (indexPath.row == 0) {
       
        UIImageView *imageView = [UIImageView new];
        self.iconImageView = imageView;
        imageView.image = self.iconImage;
        [cell.contentView addSubview: imageView];

        [imageView setRoundRectLayerCornerRadius:30 borderWidth:1 borderColor:[UIColor whiteColor]];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(0);
            make.centerY.equalTo(0);
            make.width.equalTo(60);
            make.height.equalTo(60);
            
        }];

    }else if (indexPath.row == 1){
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *nickLb = [UILabel new];
        nickLb.textColor = [UIColor lightGrayColor];
        nickLb.textAlignment = NSTextAlignmentCenter;
        nickLb.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:nickLb];
        nickLb.text = userInfo.nickName;
        [nickLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-38);
            make.height.equalTo(20);
            make.centerY.equalTo(0);
        }];
    }else if (indexPath.row == 2){
        UILabel *accountLb = [UILabel new];
        accountLb.textColor = [UIColor lightGrayColor];
        accountLb.textAlignment = NSTextAlignmentCenter;
        accountLb.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:accountLb];
        [accountLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(0);
            make.height.equalTo(20);
            make.centerY.equalTo(0);
        }];
       
        NSRange Range = {3,4};
        NSString *accountStr = [userInfo.phoneAccount stringByReplacingCharactersInRange:Range withString:@"****"];
        accountLb.text = accountStr;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0){
      UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cameraBtn = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
            [self snapImage];
        }];
        UIAlertAction *photoBtn = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self localPhoto];
        }];
        UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           
        }];
        //可以修改按钮的颜色
        [cameraBtn setValue:[UIColor deepSkyBlue] forKey:@"titleTextColor"];
        [photoBtn setValue:[UIColor deepSkyBlue] forKey:@"titleTextColor"];
        [cancelBtn setValue:[UIColor deepSkyBlue] forKey:@"titleTextColor"];
        [alert addAction:cameraBtn];
        [alert addAction:photoBtn];
        [alert addAction:cancelBtn];
        [self presentViewController:alert animated:YES completion:nil];
    }else if (indexPath.row == 1){
         [self.view showWarning:@"昵称不可修改"];
    }else  if (indexPath.row == 2) {
        [self.view showWarning:@"手机号码不可重复绑定"];
    }else if (indexPath.row == 3){
         [self.view showWarning:@"邮箱暂时不绑定"];
      
    }
}
//拍照
- (void) snapImage
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        __block UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        ipc.allowsEditing = YES;

        [self presentViewController:ipc animated:YES completion:^{
            ipc = nil;
        }];
    } else {
        NSLog(@"模拟器无法打开照相机");
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //完成选择
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
   
    if ([type isEqualToString:@"public.image"]) {
        //转换成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //通过 block 把image 传值
        self.myBlock(image);
        TRUserInfo *userInfo = [TRUserInfo new];
        userInfo.iconImageStr = [Factory UIImageToBase64Str:image];
        [userInfo saveUserInfoToSandox];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            //设置头像
            self.iconImageView.image = image;
        }];
        
    }
}
//相册
-(void)localPhoto
{
    __block UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        picker = nil;
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }
    return 40;
}
@end
