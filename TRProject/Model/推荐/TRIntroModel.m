//
//  TRIntroModel.m
//  TRProject
//
//  Created by jiyingxin on 16/3/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRIntroModel.h"

@implementation TRIntroModel
+ (NSDictionary *)objectClassInArray{
    return @{@"moblieWebgame":[TRIntroMobileLinkModel class],
             @"moblieMinecraft":[TRIntroMobileLinkModel class],
             @"mobileTvgame":[TRIntroMobileLinkModel class],
             @"moblieSport":[TRIntroMobileLinkModel class],
             @"mobileStar":[TRIntroMobileModel class],
             @"mobileRecommendation":[TRIntroMobileModel class],
             @"mobileLol":[TRIntroMobileLinkModel class],
             @"mobileHeartstone":[TRIntroMobileLinkModel class],
             @"moblieBlizzard":[TRIntroMobileLinkModel class],
             @"mobileBeauty":[TRIntroMobileLinkModel class],
             @"mobileIndex":[TRIntroMobileModel class],
             @"mobileDota2":[TRIntroMobileLinkModel class],
             @"moblieDnf":[TRIntroMobileLinkModel class],
             @"list":[TRIntroListModel class],};
}
+ (NSString *)replacedKeyFromPropertyName:(NSString *)propertyName{
    propertyName = [super replacedKeyFromPropertyName:propertyName];
    return [propertyName stringByReplacingOccurrencesOfString:@"_" withString:@"-"];
}

@end

@implementation TRIntroMobileLinkModel

@end


@implementation TRIntroLinkModel

@end


@implementation TRIntroMobileModel

@end


@implementation TRIntroListModel

@end


