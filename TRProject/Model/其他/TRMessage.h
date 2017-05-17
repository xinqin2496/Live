//
//  TRMessage.h
//  TRProject
//
//  Created by 郑文青 on 16/8/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRMessage : NSObject
/** 聊天内容 */
@property (nonatomic,copy)NSString *content;

+(NSArray *)messageData;
@end
