//
//  PlayerModel.m
//  高仿映客
//
//  Created by JIAAIR on 16/7/2.
//  Copyright © 2016年 JIAAIR. All rights reserved.
//

#import "PlayerModel.h"

@implementation PlayerModel
+(instancetype)parseDailyJSON:(NSDictionary *)dict
{
    PlayerModel *playModel = [[self alloc]init];
    playModel.name = dict[@"creator"][@"description"];
    playModel.portrait = dict[@"creator"][@"portrait"];
    playModel.liveURL = dict[@"stream_addr"];
    return playModel;
}


@end
