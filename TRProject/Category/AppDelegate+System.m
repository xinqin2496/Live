//
//  AppDelegate+System.m
//  TRProject
//
//  Created by jiyingxin on 16/2/25.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "AppDelegate+System.h"
#import <MLTransition.h>

const void *netStatusKey = &netStatusKey;
@implementation AppDelegate (System)

- (void)setupGlobalConfig{
    //电池条显示菊花,监测网络活动
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //网络状态监测
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"网络状态监测: %@", AFStringFromNetworkReachabilityStatus(status));
        if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            [self.window.rootViewController.view showWarning:@"当前使用的是蜂窝移动数据"];
        }else if(status == AFNetworkReachabilityStatusNotReachable){
            [self.window.rootViewController.view showWarning:@"无网络"];
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    //自定义左上角返回按钮, 导致右划返回失效
    [MLTransition validatePanPackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypeScreenEdgePan];
    

    
    [self setupGlobalUI];
}

- (void)setupGlobalUI{
    //为了让电池条呈现白色
    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
//    [UINavigationBar appearance].translucent = YES;
    [UINavigationBar appearance].barTintColor = kRGBA(255, 86, 142, 1.0);
  
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20]}];
    [UIBarButtonItem appearance].tintColor = [UIColor whiteColor];
    
    [UITabBar appearance].translucent = NO;
    [UITabBar appearance].barTintColor = kRGBA(237, 236, 235, 1.0);
    self.window.tintColor = kNaviBarBGColor;
    
}
//设置友盟分享
-(void)setUMSharedAppKey
{
    [UMSocialData setAppKey:K_UM_AppKey];
    //微信
    [UMSocialWechatHandler setWXAppId:K_WX_AppID appSecret:K_WX_AppSecret url:K_Share_Url];
    //朋友圈
    [UMSocialWechatHandler setWXAppId:K_WX_AppID appSecret:K_WX_AppSecret url:K_Share_Url];
    // 新浪
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:K_Sina_AppKey secret:K_Sina_AppSecret RedirectURL:K_Share_Url];
    // QQ
    [UMSocialQQHandler setQQWithAppId:K_QQ_AppId appKey:K_QQ_AppKey url:K_Share_Url];
    // QQ空间
    [UMSocialQQHandler setQQWithAppId:K_QQ_AppId appKey:K_QQ_AppKey url:K_Share_Url];
}

- (BOOL)isOnLine{
    switch (self.netReachStatus) {
        case AFNetworkReachabilityStatusUnknown:
        case AFNetworkReachabilityStatusNotReachable: {
            return NO;
            break;
        }
        case AFNetworkReachabilityStatusReachableViaWWAN:
        case AFNetworkReachabilityStatusReachableViaWiFi: {
            return YES;
            break;
        }
    }
}

- (AFNetworkReachabilityStatus)netReachStatus{
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

// App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
  
}

// App将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}
@end
