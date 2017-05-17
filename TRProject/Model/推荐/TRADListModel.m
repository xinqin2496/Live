//
//  TRADListModel.m
//  TRProject
//
//  Created by jiyingxin on 16/3/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRADListModel.h"

@implementation TRADListModel

+ (NSDictionary *)objClassInArray{
    return @{@"playerGuanggao" : [TRADListPlayerGuanggaoModel class], @"pcBanner" : [TRADListPcBannerModel class], @"list" : [TRADListListModel class], @"pcBanner2" : [TRADListPcBannerModel class]};
}

+ (NSString *)replacedKeyFromPropertyName:(NSString *)propertyName{
    if ([propertyName isEqualToString:@"playerGuanggao"]) propertyName = @"player-guanggao";
    if ([propertyName isEqualToString:@"appAd"]) propertyName = @"app-ad";
    if ([propertyName isEqualToString:@"pcBanner"]) propertyName = @"pc-banner";
    if ([propertyName isEqualToString:@"pcBanner2"]) propertyName = @"pc-banner2";
    return propertyName;
}

@end

@implementation TRADListPlayerGuanggaoModel

@end

@implementation TRADListPcBannerModel

@end

@implementation TRADListListModel

@end


