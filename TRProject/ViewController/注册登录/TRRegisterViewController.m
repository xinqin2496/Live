//
//  TRRegisterViewController.m
//  TRProject
//
//  Created by 郑文青 on 16/8/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRRegisterViewController.h"

@interface TRRegisterViewController ()
/** 电池栏背景 */
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIView *bgView;
/** 手机号 */
@property (nonatomic,strong)UITextField *phoneTextField;
/** 验证码 */
@property (nonatomic,strong)UITextField *codeTextField;
/** 昵称 */
@property (nonatomic,strong)UITextField *nicktextField;
/** 密码 */
@property (nonatomic,strong)UITextField *passwdtextField;
/** 获取验证码按钮 */
@property (nonatomic,strong)UIButton *codeBtn;
/** 定时时间 */
@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;
@end

@implementation TRRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

    self.title = @"手机注册";
    [self createTextFields];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createTextFields
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 75, self.view.frame.size.width-90, 30)];
    label.text=@"请输入您的手机号码";
    label.textColor=[UIColor grayColor];
    label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:13];
    
    [self.view addSubview:label];
    
    
    CGRect frame=[UIScreen mainScreen].bounds;
    self.bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 110, frame.size.width-20, 200)];
    self.bgView.layer.cornerRadius=3.0;
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.bgView];
    
    self.phoneTextField = [Factory createTextFielfFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"11位手机号"];
    self.phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTextField .keyboardType=UIKeyboardTypeNumberPad;
    
    
    self.codeTextField =[Factory createTextFielfFrame:CGRectMake(100, 60, 90, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"4位数字" ];
    self.codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeTextField.keyboardType=UIKeyboardTypeNumberPad;
    
    self.nicktextField =[Factory createTextFielfFrame:CGRectMake(100, 110, 200, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"请输入昵称" ];
    self.nicktextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.passwdtextField =[Factory createTextFielfFrame:CGRectMake(100, 160, 200, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"请输入密码" ];
    self.passwdtextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
    phonelabel.text=@"手机号";
    phonelabel.textColor=[UIColor blackColor];
    phonelabel.textAlignment=NSTextAlignmentLeft;
    phonelabel.font=[UIFont systemFontOfSize:14];
    
    UILabel *codelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 62, 50, 25)];
    codelabel.text=@"验证码";
    codelabel.textColor=[UIColor blackColor];
    codelabel.textAlignment=NSTextAlignmentLeft;
    codelabel.font=[UIFont systemFontOfSize:14];
    
    UILabel *nicklabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 112, 50, 25)];
    nicklabel.text=@"昵称";
    nicklabel.textColor=[UIColor blackColor];
    nicklabel.textAlignment=NSTextAlignmentLeft;
    nicklabel.font=[UIFont systemFontOfSize:14];
    
    UILabel *passedLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 162, 50, 25)];
    passedLabel.text=@"密码";
    passedLabel.textColor=[UIColor blackColor];
    passedLabel.textAlignment=NSTextAlignmentLeft;
    passedLabel.font=[UIFont systemFontOfSize:14];
    
    
    self.codeBtn =[[UIButton alloc]initWithFrame:CGRectMake(self.bgView.frame.size.width-100-20, 62, 100, 30)];
    
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:kRGBA(248, 144, 34, 1.0) forState:UIControlStateNormal];
    
    self.codeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.codeBtn addTarget:self action:@selector(getValidCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.codeBtn];
    
    UIImageView *line1=[Factory createImageViewFrame:CGRectMake(20, 50, self.bgView.frame.size.width-40, 1) imageName:nil color:kRGBA(180, 180, 180, 0.3)];
    UIImageView *line2=[Factory createImageViewFrame:CGRectMake(20, 100, self.bgView.frame.size.width-40, 1) imageName:nil color:kRGBA(180, 180, 180, 0.3)];
    UIImageView *line3=[Factory createImageViewFrame:CGRectMake(20, 150, self.bgView.frame.size.width-40, 1) imageName:nil color:kRGBA(180, 180, 180, 0.3)];
    
    UIButton *registerBtn=[Factory createButtonFrame:CGRectMake(10, self.bgView.frame.size.height+ self.bgView.frame.origin.y+30,self.view.frame.size.width-20, 37) backImageName:nil title:@"注册" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:17] target:self action:@selector(clickRegisterBtn)];
    registerBtn.backgroundColor = [UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];;
    registerBtn.layer.cornerRadius=5.0f;
    
    UIButton *agreeBtn = [Factory createButtonFrame:CGRectMake(130, registerBtn.frame.origin.y + registerBtn.frame.size.height + 22, 20, 20) backImageName:@"同意按钮" title:nil titleColor:nil font:nil target:self action:nil];
    UILabel *agreeLabel = [[UILabel alloc]initWithFrame:CGRectMake(155, registerBtn.frame.origin.y + registerBtn.frame.size.height + 20, 50, 25)];
    agreeLabel.textColor = [UIColor grayColor];
    agreeLabel.text = @"同意";
    agreeLabel.font = [UIFont systemFontOfSize:12];
    agreeLabel.textAlignment = NSTextAlignmentLeft;
    
    UILabel *agreementLabel = [[UILabel alloc]initWithFrame:CGRectMake(175, registerBtn.frame.origin.y + registerBtn.frame.size.height + 20, 200, 25)];
    agreementLabel.textColor = kRGBA(248, 144, 34, 1.0);
    agreementLabel.text = @"《注册协议及版权申明》";
    agreementLabel.font = [UIFont systemFontOfSize:12];
    agreementLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.bgView addSubview:self.phoneTextField];
    [self.bgView addSubview:self.codeTextField];
    [self.bgView addSubview:self.nicktextField];
    [self.bgView addSubview:self.passwdtextField];
    [self.bgView addSubview:phonelabel];
    [self.bgView addSubview:codelabel];
    [self.bgView addSubview:nicklabel];
    [self.bgView addSubview:passedLabel];
    [self.bgView addSubview:line1];
    [self.bgView addSubview:line2];
    [self.bgView addSubview:line3];
    [self.view addSubview:registerBtn];
    [self.view addSubview:agreeBtn];
    [self.view addSubview:agreeLabel];
    [self.view addSubview:agreementLabel];
}
//判断账号和密码是否为空
- (BOOL)isEmpty{
    BOOL ret = NO;
    NSString *username = self.phoneTextField.text;
    NSString *passwd = self.passwdtextField.text;
    NSString *nickName = self.nicktextField.text;
    NSString *securityCode = self.codeTextField.text;
    if (username.length == 0 || passwd.length == 0 ||securityCode == 0 || nickName == 0) {
        ret = YES;
    }
    
    return ret;
}
//获取验证码
- (void)getValidCode:(UIButton *)sender
{
    if ([self.phoneTextField.text isEqualToString:@""]){
        [self.view showWarning:@"请输入手机号码"];
        return;
    }else if (self.phoneTextField.text.length <11){
        [self.view showWarning:@"请输入正确的手机号码"];
        return;
    }
   
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneTextField.text  zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (error) {
            NSLog(@"error %@",error);
            
        }else{
            sender.userInteractionEnabled = NO;
            self.timeCount = 60;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
        }
    }];
}

- (void)reduceTime:(NSTimer *)codeTimer {
    self.timeCount--;
    if (self.timeCount == 0) {
        [self.codeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [self.codeBtn setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        self.codeBtn.userInteractionEnabled = YES;
        [self.timer invalidate];
        self.timer = nil;
    } else {
        NSString *str = [NSString stringWithFormat:@"%lu秒后重新获取", (long)self.timeCount];
        [self.codeBtn setTitle:str forState:UIControlStateNormal];
        self.codeBtn.userInteractionEnabled = NO;
        
    }
}
-(void)clickRegisterBtn
{
    
    if (![self isEmpty]) {//注册信息不为空

        //验证码验证
        [SMSSDK commitVerificationCode:self.codeTextField.text phoneNumber:self.phoneTextField.text zone:@"86" result:^(NSError *error) {
            if (error) {
                [self.view showWarning:@"验证码不正确"];
                return ;
            }else{
                //验证码正确 开始注册
                TRUserInfo *userInfo = [TRUserInfo new];
                userInfo.phoneAccount = self.phoneTextField.text;
                userInfo.passwd = self.passwdtextField.text;
                userInfo.nickName = self.nicktextField.text;
                [userInfo saveUserInfoToSandox];
            
                [self.view showSuccess:@"注册成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (self.isModel) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        }];
    }else{
        
        [self.view showWarning:@"注册信息不能为空"];
        
    }
    

}
@end
