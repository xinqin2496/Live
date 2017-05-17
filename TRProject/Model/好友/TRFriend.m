//
//  TRFriend.m
//  TRProject
//
//  Created by jiyingxin on 16/3/11.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRFriend.h"

@implementation TRFriend
MJCodingImplementation


+ (NSString *)userListPath{
    return [kDocPath stringByAppendingPathComponent:@"userInvationList"];
}

- (void)saveUser{
    NSMutableArray *userList = [NSKeyedUnarchiver unarchiveObjectWithFile:[TRFriend userListPath]];
    if (!userList) {
        userList = [NSMutableArray new];
    }
    if ([userList containsObject:self]) {
        return;
    }
    [userList addObject:self];
    BOOL success = [NSKeyedArchiver archiveRootObject:userList toFile:[TRFriend userListPath]];
    if (success) {
        NSLog(@"%@", success?@"归档成功":@"归档失败");
    }
    
}

- (void)removeUser{
    NSMutableArray *userList = [NSKeyedUnarchiver unarchiveObjectWithFile:[TRFriend userListPath]];
    [userList removeObject:self];
    [NSKeyedArchiver archiveRootObject:userList toFile:[TRFriend userListPath]];
}

+ (NSMutableArray<TRFriend *> *)getFriendInvatations{
    NSMutableArray *arr =[NSKeyedUnarchiver unarchiveObjectWithFile:[TRFriend userListPath]];
    return arr;
}


@end
