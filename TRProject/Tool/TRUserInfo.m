//
//  TRUserInfo.m
//  TRProject
//
//  Created by 郑文青 on 16/8/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRUserInfo.h"

@implementation TRUserInfo

singleton_implementation(TRUserInfo)
//解档
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    if ([super init]) {
//        self.phoneAccount = [aDecoder decodeObjectForKey:@"phoneAccount"];
//        self.passwd = [aDecoder decodeObjectForKey:@"passwd"];
//        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
//        self.iconImageStr = [aDecoder decodeObjectForKey:@"iconImageStr"];
//        self.login = [aDecoder decodeBoolForKey:@"login"];
//    }
//    return self;
//}
////归档
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:self.phoneAccount forKey:@"phoneAccount"];
//    [aCoder encodeObject:self.passwd forKey:@"passwd"];
//    [aCoder encodeObject:self.iconImageStr forKey:@"iconImageStr"];
//    [aCoder encodeObject:self.nickName forKey:@"nickName"];
//    [aCoder encodeBool:self.login forKey:@"login"];
//}

//将数据保存的沙箱中
-(void)saveUserInfoToSandox {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.phoneAccount forKey:@"phoneAccount"];
    [userDefaults setObject:self.passwd forKey:@"passwd"];
    [userDefaults setObject:self.nickName forKey:@"nickName"];
    [userDefaults setObject:self.iconImageStr forKey:@"iconImageStr"];
    //将对象中的数据 写入到沙箱
    [userDefaults synchronize];
}

//把数据从沙箱中取出来
-(void)loadUserInfoToSandox {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.phoneAccount = [userDefaults objectForKey:@"phoneAccount"];
    self.passwd = [userDefaults objectForKey:@"passwd"];
    self.nickName = [userDefaults objectForKey:@"nickName"];
    self.iconImageStr = [userDefaults objectForKey:@"iconImageStr"];
}

@end
