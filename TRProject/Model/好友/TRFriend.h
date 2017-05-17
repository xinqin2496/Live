//
//  TRFriend.h
//  TRProject
//
//  Created by jiyingxin on 16/3/11.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRFriend : NSObject

@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *message;
//保存用户到列表
- (void)saveUser;

//获取用户列表
+ (NSMutableArray<TRFriend *> *)getFriendInvatations;
//删除某用户
- (void)removeUser;

+ (NSString *)userListPath;
@end
