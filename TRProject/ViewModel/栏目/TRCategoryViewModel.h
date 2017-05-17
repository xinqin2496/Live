//
//  TRCategoryViewModel.h
//  TRProject
//
//  Created by jiyingxin on 16/3/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRBaseViewModel.h"
#import "TRLiveNetManager.h"


@interface TRCategoryViewModel : TRBaseViewModel

- (id)initWithSlug:(NSString *)slug;
@property (nonatomic) NSString *slug;

@property (nonatomic) NSInteger rowNumber;
@property (nonatomic) NSMutableArray *roomList;

@property (nonatomic) NSInteger page;
@property (nonatomic) NSInteger pageCount;
@property (nonatomic) NSInteger size;
@property (nonatomic) NSInteger total;

- (TRCategoryDataModel *)modelForRow:(NSInteger)row;
- (NSURL *)iconURLForRow:(NSInteger)row;//视频图片
- (NSURL *)avatarURLForRow:(NSInteger)row;//小头像
- (NSString *)titleForRow:(NSInteger)row;//房间名
- (NSString *)nickForRow:(NSInteger)row;//主播名
- (NSString *)viewForRow:(NSInteger)row;//观看人数
- (NSURL *)videoURLForRow:(NSInteger)row;//直播网址
@end
