//
//  TRLoginViewController.m
//  TRProject
//
//  Created by 郑文青 on 16/8/3.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRLoginViewController.h"
#import "TRRegisterViewController.h"
#import "TRForgetPasswdController.h"
@interface TRLoginViewController ()
/** 电池栏背景 */
@property (nonatomic,strong)UIView *topView;
/** 背景 */
@property (nonatomic,strong)UIView *bgView;
/** 用户名输入框 */
@property (nonatomic,strong)UITextField *userTextField;
/** 密码输入框 */
@property (nonatomic,strong)UITextField *passwdTextField;

/** 保存用户信息类 */
@property (nonatomic,strong)TRUserInfo *userInfo;
@end

@implementation TRLoginViewController
-(TRUserInfo *)userInfo
{
    if (!_userInfo) {
        _userInfo = [TRUserInfo sharedTRUserInfo];
    }
    return _userInfo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBGColor;
    if(!self.isModel){
        [Factory addBackItemToVC:self];
    }else{
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 50, 44);
        [btn setImage:[UIImage imageNamed:@"返回_默认"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"返回_按下"] forState:UIControlStateHighlighted];
        
        [btn bk_addEventHandler:^(id sender) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } forControlEvents:UIControlEventTouchUpInside];
        //把视图的边角变为圆形, cornerRadius圆角半径
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        //弹簧控件, 修复边距
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceItem.width = -15;
        self.navigationItem.leftBarButtonItems = @[spaceItem,backItem];

    }
   
    self.title = @"登录";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(clickRegisterBtn)];
    self.navigationItem.rightBarButtonItem = rightItem;

    [self createButtons];
    [self createTextFields];

}
-(void)clickRegisterBtn
{
    TRRegisterViewController *registerVC = [TRRegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.userInfo loadUserInfoToSandox];
    self.passwdTextField.text = self.userInfo.passwd;
    self.userTextField.text = self.userInfo.phoneAccount;
    //自定义一个view 做电池栏的背景色
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, kScreenW, 20)];
    topView.backgroundColor = kRGBA(255, 86, 142, 1.0);
    self.topView = topView;
    [self.navigationController.navigationBar addSubview:topView];
    [self.navigationController.navigationBar setBackgroundColor: kRGBA(255, 86, 142, 1.0)];
    NSLog(@"登录界面将要出现");
}
-(void)viewWillDisappear:(BOOL)animated
{
    //把电池栏和导航栏颜色清掉
    self.topView.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackgroundColor: [UIColor clearColor]];
    NSLog(@"登录界面已经消失");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.userTextField resignFirstResponder];
    [self.passwdTextField resignFirstResponder];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userTextField resignFirstResponder];
    [self.passwdTextField resignFirstResponder];
}

-(void)createTextFields
{
    CGRect frame=[UIScreen mainScreen].bounds;
    self.bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 75, frame.size.width-20, 100)];
    self.bgView.layer.cornerRadius=3.0;
    self.bgView.alpha=0.7;
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview: self.bgView];
    
    self.userTextField =[Factory createTextFielfFrame:CGRectMake(60, 10, 271, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入您手机号码"];
    
    self.userTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.passwdTextField=[Factory createTextFielfFrame:CGRectMake(60, 60, 271, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"密码" ];
    self.passwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //密文样式
    self.passwdTextField.secureTextEntry=YES;
    
    
    
    UIImageView *userImageView=[Factory createImageViewFrame:CGRectMake(20, 10, 25, 25) imageName:@"ic_landing_nickname" color:nil];
    UIImageView *pwdImageView=[Factory createImageViewFrame:CGRectMake(20, 60, 25, 25) imageName:@"mm_normal" color:nil];
    UIImageView *line1=[Factory createImageViewFrame:CGRectMake(20, 50, self.bgView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
    
    [self.bgView addSubview:self.userTextField];
    [self.bgView addSubview:self.passwdTextField];
    
    [self.bgView addSubview:userImageView];
    [self.bgView addSubview:pwdImageView];
    [self.bgView addSubview:line1];
}



-(void)createButtons
{
    UIButton *loginBtn=[Factory createButtonFrame:CGRectMake(10, 190, self.view.frame.size.width-20, 37) backImageName:nil title:@"登录" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:19] target:self action:@selector(clickLoginBtn)];
    loginBtn.backgroundColor= [UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];;
    loginBtn.layer.cornerRadius=5.0f;
    
    
    UIButton *forgotPwdBtn=[Factory createButtonFrame:CGRectMake(self.view.frame.size.width-75, 235, 60, 30) backImageName:nil title:@"找回密码" titleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] target:self action:@selector(clickFogetPwd)];
    [self.view addSubview:loginBtn];
   
    [self.view addSubview:forgotPwdBtn];
}
//判断账号和密码是否为空
- (BOOL)isEmpty{
    BOOL ret = NO;
    NSString *username = self.userTextField.text;
    NSString *passwd = self.passwdTextField.text;
   
    if (username.length == 0 || passwd.length == 0 ) {
        ret = YES;
    }
    
    return ret;
}
//点击登录处理
-(void)clickLoginBtn
{
    
    if (![self isEmpty]) {
        
        [self.view showBusyHUD];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (![self.userTextField.text isEqualToString:self.userInfo.phoneAccount] ) {
                [self.view showWarning:@"账号错误"];
                return ;
            }else if(![self.passwdTextField.text isEqualToString:self.userInfo.passwd]){
                [self.view showWarning:@"密码错误"];
                return ;
            }else{
                [self.view showSuccess:@"登录成功"];
                [self.userInfo loadUserInfoToSandox];
                self.userInfo.login = YES;
                [[NSUserDefaults standardUserDefaults]setObject:@"autoLogin" forKey:@"autoLogin"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                WK(weakSelf);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (weakSelf.isModel) {
                        [weakSelf dismissViewControllerAnimated:YES completion:nil];
                    }
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
                
            }
        });
        
    }else{
        if(self.userTextField.text.length == 0){
              [self.view showWarning:@"请输入用户名"];
        }else{
              [self.view showWarning:@"请输入密码"];
        }
    }
    
}
-(void)clickFogetPwd
{
    TRForgetPasswdController *forgetVC = [TRForgetPasswdController new];
    [self.navigationController pushViewController:forgetVC animated:YES];
    
}



@end
