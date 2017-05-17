//
//  TRUserInfo.h
//  TRProject
//
//  Created by 郑文青 on 16/8/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface TRUserInfo : NSObject
singleton_interface(TRUserInfo)

/** 手机账号 */
@property (nonatomic,copy)NSString *phoneAccount;
/** 密码 */
@property (nonatomic,copy)NSString *passwd;
/** 昵称 */
@property (nonatomic,copy)NSString *nickName;
/** 头像 */
@property (nonatomic,copy)NSString *iconImageStr;
/** 是否登录 */
@property (nonatomic,assign,getter=isLogin)BOOL login;

-(void)saveUserInfoToSandox;
-(void)loadUserInfoToSandox;
@end
