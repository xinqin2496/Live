//
//  TRADListModel.h
//  TRProject
//
//  Created by jiyingxin on 16/3/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRBaseModel.h"

@class TRADListPlayerGuanggaoModel,TRADListPcBannerModel,TRADListListModel;
@interface TRADListModel : TRBaseModel
//player-guanggao -> playerGuanggao
@property (nonatomic, strong) NSArray<TRADListPlayerGuanggaoModel *> *playerGuanggao;
// app-ad  -> appAd
@property (nonatomic, strong) NSArray *appAd;
//pc-banner -> pcBanner
@property (nonatomic, strong) NSArray<TRADListPcBannerModel *> *pcBanner;

@property (nonatomic, strong) NSArray<TRADListListModel *> *list;
//pc-banner2 -> pcBanner2
@property (nonatomic, strong) NSArray<TRADListPcBannerModel *> *pcBanner2;

@end
@interface TRADListPlayerGuanggaoModel : TRBaseModel

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *ext;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *fk;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, copy) NSString *createAt;

@property (nonatomic, assign) NSInteger slotId;

@property (nonatomic, assign) NSInteger priority;

@end

@interface TRADListPcBannerModel : TRBaseModel

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *ext;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *fk;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, assign) NSInteger slot_id;
@property (nonatomic, assign) NSInteger priority;

@end

@interface TRADListListModel : TRBaseModel

@property (nonatomic, copy) NSString *slug;
@property (nonatomic, copy) NSString *name;

@end

