//
//  TRSearchModel.m
//  TRProject
//
//  Created by jiyingxin on 16/3/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRSearchModel.h"

@implementation TRSearchModel

@end
@implementation TRSearchDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"items" : [TRSearchDataItemsModel class]};
}

@end


@implementation TRSearchDataItemsModel

@end


