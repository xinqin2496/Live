//
//  TRRoomListModel.m
//  TRProject
//
//  Created by jiyingxin on 16/3/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRRoomListModel.h"

@implementation TRRoomListModel

+ (NSDictionary *)objClassInArray{
    return @{@"data" : [TRCategoryDataModel class]};
}

+ (NSString *)replacedKeyFromPropertyName:(NSString *)propertyName{
    //pageCount特殊, 本身就是驼峰 ,不需要转化
    if ([propertyName isEqualToString:@"pageCount"]) return propertyName;
    return [super replacedKeyFromPropertyName:propertyName];
}

@end

@implementation TRRoomListRecommendModel

+ (NSDictionary *)objClassInArray{
    return @{@"data" : [TRRoomListRecommendDataModel class]};
}

@end

@implementation TRRoomListRecommendDataModel

@end


