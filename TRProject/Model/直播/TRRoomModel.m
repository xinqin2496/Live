//
//  TRRoomModel.m
//  TRProject
//
//  Created by jiyingxin on 16/3/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRRoomModel.h"

@implementation TRRoomModel

+ (NSDictionary *)objClassInArray{
    return @{@"rankTotal" : [TRRoomRankTotalModel class], @"cross" : [TRCategoryDataModel class], @"admins" : [TRRoomAdminsModel class], @"rankWeek" : [TRRoomRankTotalModel class]};
}

+ (NSString *)replacedKeyFromPropertyName:(NSString *)propertyName{
    //进行一些统一的变化
    if ([propertyName isEqualToString:@"ID"]) propertyName = @"id";
    if ([propertyName isEqualToString:@"desc"]) propertyName = @"description";
    return [propertyName mj_underlineFromCamel];
}

@end

@implementation TRRoomLiveModel
@end
@implementation TRRoomLiveWsModel
@end

@implementation TRRoomLiveWsHlsModel
+ (NSString *)replacedKeyFromPropertyName:(NSString *)propertyName{
    if ([propertyName isEqualToString:@"three"]) propertyName = @"3";
    if ([propertyName isEqualToString:@"four"]) propertyName = @"4";
    return [super replacedKeyFromPropertyName:propertyName];
}
@end

@implementation TRRoomLiveWsHlsThreeModel
@end

@implementation TRRoomRankTotalModel
@end

@implementation TRRoomAdminsModel
@end


