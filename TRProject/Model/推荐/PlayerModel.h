//
//  PlayerModel.h
//  高仿映客
//
//  Created by JIAAIR on 16/7/2.
//  Copyright © 2016年 JIAAIR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerModel : NSObject

@property (nonatomic, strong)NSString * name;

@property (nonatomic, strong)NSString * portrait;//封面

@property (nonatomic, strong)NSString * liveURL;//直播图片

+(instancetype)parseDailyJSON:(NSDictionary*)dict;

@end
