//
//  TRRoomListModel.h
//  TRProject
//  游戏房间列表,对应直播分页
//  Created by jiyingxin on 16/3/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRBaseModel.h"
#import "TRCategoryModel.h"

@class TRRoomListRecommendModel,TRRoomListRecommendDataModel;
@interface TRRoomListModel : TRBaseModel

@property (nonatomic, strong) TRRoomListRecommendModel *recommend;

@property (nonatomic, strong) NSArray<TRCategoryDataModel *> *data;

@property (nonatomic, assign) NSInteger pageCount;

@property (nonatomic, assign) NSInteger size;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, copy) NSString *icon;

@end
@interface TRRoomListRecommendModel : TRBaseModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, strong) NSArray<TRRoomListRecommendDataModel *> *data;

@end

@interface TRRoomListRecommendDataModel : TRBaseModel

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) NSInteger slotId;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, assign) NSInteger priority;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *createAt;

@property (nonatomic, strong) TRCategoryDataModel *linkObject;

@property (nonatomic, copy) NSString *ext;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *fk;

@end

