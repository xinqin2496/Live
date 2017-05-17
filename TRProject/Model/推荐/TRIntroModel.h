//
//  TRIntroModel.h
//  TRProject
//
//  Created by jiyingxin on 16/3/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRBaseModel.h"

@class TRIntroMobileLinkModel, TRIntroLinkModel,TRIntroMobileModel, TRIntroListModel;
@interface TRIntroModel : TRBaseModel
@property (nonatomic, strong) NSArray<TRIntroMobileLinkModel *> *moblieWebgame;
@property (nonatomic, strong) NSArray<TRIntroMobileLinkModel *> *moblieMinecraft;
@property (nonatomic, strong) NSArray<TRIntroMobileLinkModel *> *mobileTvgame;
@property (nonatomic, strong) NSArray<TRIntroMobileLinkModel *> *moblieSport;
@property (nonatomic, strong) NSArray<TRIntroMobileModel *> *mobileStar;
@property (nonatomic, strong) NSArray<TRIntroMobileModel *> *mobileRecommendation;
@property (nonatomic, strong) NSArray<TRIntroMobileLinkModel *> *mobileLol;
@property (nonatomic, strong) NSArray<TRIntroMobileLinkModel *> *mobileHeartstone;
@property (nonatomic, strong) NSArray<TRIntroMobileLinkModel *> *moblieBlizzard;
@property (nonatomic, strong) NSArray<TRIntroMobileLinkModel *> *mobileBeauty;
@property (nonatomic, strong) NSArray<TRIntroMobileModel *> *mobileIndex;
@property (nonatomic, strong) NSArray<TRIntroListModel *> *list;
@property (nonatomic, strong) NSArray<TRIntroMobileLinkModel *> *mobileDota2;
@property (nonatomic, strong) NSArray<TRIntroMobileLinkModel *> *moblieDnf;

@end

@interface TRIntroMobileLinkModel : TRBaseModel
//link_objcet -> linkObject
@property (nonatomic, strong) TRIntroLinkModel *linkObject;

@end

@interface TRIntroLinkModel : TRBaseModel

@property (nonatomic, strong) NSString *nick;
@property (nonatomic, strong) NSString *weightAdd;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *followAdd;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, strong) NSString *lastPlayAt;
@property (nonatomic, strong) NSString *check;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *playCount;
@property (nonatomic, strong) NSString *negativeView;
@property (nonatomic, strong) NSString *view;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *lastThumb;
@property (nonatomic, strong) NSString *coin;
@property (nonatomic, strong) NSString *coinAdd;
@property (nonatomic, strong) NSString *defaultImage;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSString *createAt;
@property (nonatomic, assign) double charm;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *recommendImage;
@property (nonatomic, strong) NSString *lockedView;
@property (nonatomic, strong) NSString *lastEndAt;
@property (nonatomic, strong) NSString *videoQuality;
@property (nonatomic, strong) NSString *firstPlayAt;
@property (nonatomic, strong) NSString *follow;
@property (nonatomic, strong) NSString *followBak;
@property (nonatomic, strong) NSString *playAt;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *categorySlug;
@property (nonatomic, strong) NSString *appShufflingImage;

@end

@interface TRIntroMobileModel : TRBaseModel

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) NSInteger slotId;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, strong) TRIntroLinkModel *linkObject;
@property (nonatomic, copy) NSString *ext;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *fk;

@end

@interface TRIntroListModel : TRBaseModel

@property (nonatomic, copy) NSString *slug;
@property (nonatomic, copy) NSString *name;

@end


