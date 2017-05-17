//
//  TRMessage.m
//  TRProject
//
//  Created by 郑文青 on 16/8/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRMessage.h"

@implementation TRMessage
+(NSArray *)messageData
{
    TRMessage *m1 = [[TRMessage alloc]init];
//    m1.content = @"我嗨直播直播平台严禁直播低俗、侵权、色情、以及反动内容";
    
    TRMessage *m2 = [[TRMessage alloc]init];
//    m2.content = @"房间正在连接中...";
    
    TRMessage *m3 = [[TRMessage alloc]init];
//    m3.content = @"欢迎来到%@的直播房间";
    
    TRMessage *m4 = [[TRMessage alloc]init];
//    m4.content = @"弹幕连接中...";
    
    TRMessage *m5 = [[TRMessage alloc]init];
//    m5.content = @"弹幕连接成功";
    
    return @[m1,m2,m3,m4,m5];
}
@end
