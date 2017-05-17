//
//  TRCategoryModel.h
//  TRProject
//
//  Created by jiyingxin on 16/3/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRBaseModel.h"

@class TRCategoryDataModel;
@interface TRCategoryModel : TRBaseModel

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSArray<TRCategoryDataModel *> *data;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, assign) NSInteger size;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger pageCount;


@end
@interface TRCategoryDataModel : TRBaseModel

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *weightAdd;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *followAdd;

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *check;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *playCount;

@property (nonatomic, copy) NSString *negativeView;

@property (nonatomic, copy) NSString *view;

@property (nonatomic, copy) NSString *grade;

@property (nonatomic, copy) NSString *coin;

@property (nonatomic, copy) NSString *coinAdd;

@property (nonatomic, copy) NSString *defaultImage;

@property (nonatomic, copy) NSString *createAt;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSString *categoryName;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *recommendImage;

@property (nonatomic, copy) NSString *lockedView;

@property (nonatomic, copy) NSString *lastEndAt;

@property (nonatomic, copy) NSString *videoQuality;

@property (nonatomic, copy) NSString *firstPlayAt;

@property (nonatomic, assign) NSInteger follow;

@property (nonatomic, copy) NSString *followBak;

@property (nonatomic, copy) NSString *playAt;

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, copy) NSString *appShufflingImage;

@property (nonatomic, copy) NSString *categoryId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *categorySlug;

@end

