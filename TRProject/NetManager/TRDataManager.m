//
//  TRDataManager.m
//  TRProject
//
//  Created by 郑文青 on 16/7/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRDataManager.h"
#import "PlayerModel.h"
@implementation TRDataManager
+(NSArray *)getAllTopScrollViewData:(id)responseObject
{
    NSArray *livesArray =  responseObject[@"lives"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in livesArray) {
        PlayerModel *playModel = [PlayerModel parseDailyJSON:dict];
        [array addObject:playModel];
    }
    return array;
}
@end
