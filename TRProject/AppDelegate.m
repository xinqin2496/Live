//
//  AppDelegate.m
//  TRProject
//
//  Created by jiyingxin on 16/2/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+System.h"


@interface AppDelegate ()
@end

@implementation AppDelegate

#pragma mark - Life Circle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //全局默认配置
    [self setupGlobalConfig];

 
    //掌淘科技 短信验证
    [SMSSDK registerApp:kMobSDKAppKey withSecret:kMobSDKAppSecret];


    //设置友盟分享    
    [self setUMSharedAppKey];
    
    TRUserInfo *userInfo = [TRUserInfo sharedTRUserInfo];
    
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"autoLogin"];
   
    if (str.length != 0) {
        userInfo.login = YES;
    }
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
     [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    return YES;
}


@end
