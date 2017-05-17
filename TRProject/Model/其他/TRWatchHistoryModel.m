//
//  TRWatchHistoryModel.m
//  TRProject
//
//  Created by 郑文青 on 16/7/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRWatchHistoryModel.h"
#import "TRDBManager.h"
#import <sqlite3.h>
@implementation TRWatchHistoryModel

+(BOOL)removeWatchHistory:(NSString *)Hls_name
{
    FMDatabase *db = [TRDBManager sharedDatabaseName:@"watchHistory"];
    BOOL success = [db executeUpdateWithFormat:@"delete from watchHistory where Hls_name = %@", Hls_name];
    
    [db close];
    return success;
}
+(NSArray *)watchHistoryArray
{
    //创建空的数据库
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [cachesPath stringByAppendingPathComponent:@"watchHistory.db"];
    sqlite3 *database;
    //创建/打开数据库文件
    int ret = sqlite3_open([dbPath cStringUsingEncoding:NSUTF8StringEncoding], &database);
    if (ret != SQLITE_OK) {
        NSLog(@"创建数据库文件失败:%s", sqlite3_errmsg(database));
        return 0;
    }
    FMDatabase *db = [TRDBManager sharedDatabaseName:@"watchHistory"];
    FMResultSet *rs = [db executeQuery:@"select * from watchHistory"];
    
    NSMutableArray *dataArr = [NSMutableArray new];
    
    while ([rs next]) {
        TRWatchHistoryModel *model = [self new];
        model.Hls_name = [rs stringForColumn:@"Hls_name"];
        model.Hls_liveStr = [rs stringForColumn:@"Hls_liveStr"];
        model.Hls_title = [rs stringForColumn:@"Hls_title"];
        model.imageStr = [rs stringForColumn:@"imageStr"];
        model.Hls_onlines = [rs stringForColumn:@"Hls_onlines"];
        model.avatarStr = [rs stringForColumn:@"avatarStr"];
        [dataArr addObject:model];
    }
    
    //释放掉搜索出来的内容
    [db closeOpenResultSets];
    [db close];
    
    return [dataArr copy];
    
    
}

@end
