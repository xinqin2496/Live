//
//  TRDBManager.h
//  Petroy
//
//  Created by Xiao on 15/11/25.
//  Copyright © 2015年 Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface TRDBManager : NSObject

//单例模式，返回唯一的数据库对象
+ (FMDatabase *)sharedDatabaseName:(NSString *)name;

@end
