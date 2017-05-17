//
//  TRBaseModel.m
//  TRProject
//
//  Created by jiyingxin on 16/3/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRBaseModel.h"

@implementation TRBaseModel
MJCodingImplementation

+ (NSString *)replacedKeyFromPropertyName:(NSString *)propertyName{
    //进行一些统一的变化
    if ([propertyName isEqualToString:@"ID"]) propertyName = @"id";
    if ([propertyName isEqualToString:@"desc"]) propertyName = @"description";
    return [propertyName mj_underlineFromCamel];
}
@end
