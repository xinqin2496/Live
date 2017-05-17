//
//  TRLiveNetManager.m
//  TRProject
//
//  Created by jiyingxin on 16/3/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRLiveNetManager.h"

@implementation TRLiveNetManager

+ (id)getRoomListWithPage:(NSInteger)page completionHandler:(void (^)(id, NSError *))completionHandler{
    NSString *pageStr = [NSString stringWithFormat:@"_%ld", page];
    if (page == 0) {
        pageStr = @"";
    }
    NSString *path = [NSString stringWithFormat:kRoomsPath, pageStr];
    return [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([TRRoomListModel parse:responseObj], error);
    }];
}

+ (id)getRoomWithUID:(NSString *)uid completionHandler:(void (^)(id, NSError *))completionHandler{
    NSString *path = [NSString stringWithFormat:kRoomDetailPath, uid];
    return [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([TRRoomModel parse:responseObj], error);
    }];
}

+(id)getCategoriesCompletionHandler:(void (^)(id, NSError *))completionHandler{
    return [self GET:kCategoriesPath parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([TRCategoriesModel parse:responseObj], error);
    }];
}

+ (id)getCategoryWithSlug:(NSString *)slug page:(NSInteger)page completionHandler:(void (^)(id, NSError *))completionHandler{
    NSString *pageStr = [NSString stringWithFormat:@"_%ld", page];
    if (page == 0) {
        pageStr = @"";
    }
    NSString *path = [NSString stringWithFormat:kCategoryRoomsPath, slug, pageStr];
    return [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([TRCategoryModel parse:responseObj], error);
    }];
}

+ (id)search:(NSString *)words page:(NSInteger)page completionHandler:(void (^)(id, NSError *))completionHandler{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:@"site.search" forKey:@"m"];
    [params setObject:@"2" forKey:@"os"];
    [params setObject:@"0" forKey:@"p[categoryId]"];
    [params setObject:words forKey:@"p[key]"];
    [params setObject:@(page) forKey:@"p[page]"];
    [params setObject:@"10" forKey:@"p[size]"];
    [params setObject:@"1.3.2" forKey:@"v"];
    
    return [self POST:kSearchPath parameters:params progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([TRSearchModel parse:responseObj], error);
    }];
}

+ (id)getADListCompletionHandler:(void (^)(id, NSError *))completionHandler{
    return [self GET:kADPath parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([TRADListModel parse:responseObj], error);
    }];
}

+ (id)getIntroCompletionHandler:(void (^)(id, NSError *))completionHandler{
    return [self GET:kIntroPath parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([TRIntroModel parse:responseObj], error);
    }];
}

+(id)getScrollViewCompletionHandler:(void (^)(id, NSError *))completionHandler
{
    NSString *path = [NSString stringWithFormat:@"http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=5&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=5&multiaddr=1"];
      NSDictionary *parameters = @{@"format":@"json"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    manager.requestSerializer.timeoutInterval = 30;
    return [manager GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
        NSLog(@"error %@", error);
    }];
}
@end












