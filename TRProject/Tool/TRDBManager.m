//
//  TRDBManager.m
//  Petroy
//
//  Created by Xiao on 15/11/25.
//  Copyright © 2015年 Xiao. All rights reserved.
//

#import "TRDBManager.h"

@implementation TRDBManager

+ (FMDatabase *)sharedDatabaseName:(NSString *)name
{
    
    static FMDatabase *database = nil;
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        //数据库对象初始化，需要数据库路径
    
     
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *nameStr = [NSString stringWithFormat:@"%@.db",name];
        NSString *targetDBPath = [documentsPath stringByAppendingPathComponent:nameStr];
        
        //获取数据文件的路径
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:name ofType:@"bundle"];
        //拼接数据库文件的路径
        NSString *sourceDBPath = [bundlePath stringByAppendingPathComponent:nameStr];
        
        NSError *error = nil;
        if (![[NSFileManager defaultManager] fileExistsAtPath:targetDBPath]) {
            [[NSFileManager defaultManager] copyItemAtPath:sourceDBPath toPath:targetDBPath error:&error];
        }
        
        if (!error) {
            //初始化/创建database对象
            database = [FMDatabase databaseWithPath:targetDBPath];
        } else {
            NSLog(@"拷贝失败:%@", error.userInfo);
        }
//    });
    
    //在使用对象之前，要打开数据库。
    [database open];
    return database;
}




@end
