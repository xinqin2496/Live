//
//  TRIntroViewModel.h
//  TRProject
//
//  Created by jiyingxin on 16/3/9.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRBaseViewModel.h"
#import "TRLiveNetManager.h"

@interface TRIntroViewModel : TRBaseViewModel

/* 头部滚动广告部分--Begin */
@property (nonatomic) NSArray *indexList;
@property (nonatomic) NSInteger indexNumber;
- (TRIntroMobileModel *)indexModelForIndex:(NSInteger)index;
- (NSURL *)indexIconURLForIndex:(NSInteger)index;
- (NSString *)indexTitleForIndex:(NSInteger)index;
- (NSURL *)indexURLForIndex:(NSInteger)index;
/* 头部滚动广告部分--End */

/* 明星部分--Begin */
@property (nonatomic) NSArray *starList;
@property (nonatomic) NSInteger starNumber;
- (NSString *)starNameForIndex:(NSInteger)index;
- (NSURL *)starIconURLForIndex:(NSInteger)index;
- (TRIntroMobileModel *)starModelForIndex:(NSInteger)index;
- (NSURL *)starVideoURLForIndex:(NSInteger)index;
/* 明星部分--End */

/* 推荐部分--Begin */
@property (nonatomic) NSInteger recommendNumber;
@property (nonatomic) NSArray *recommentList;
@property (nonatomic) NSArray *currentRecommendList;
/** 当前数据的起始索引值 */
@property (nonatomic) NSInteger recommendStartIndex;
- (void)changeCurrentRecommentList;
- (TRIntroMobileModel *)recommendModelForRow:(NSInteger)row;
- (NSURL *)recommendIconURLForRow:(NSInteger)row;//视频图片
- (NSURL *)recommendAvatarIconURLForRow:(NSInteger)row;//小头像
- (NSString *)recommendTitleForRow:(NSInteger)row;//房间名字
- (NSString *)recommendNickForRow:(NSInteger)row;//主播名字
- (NSString *)recommendViewForRow:(NSInteger)row;//观看人数
- (NSURL *)recommendVideoURLForRow:(NSInteger)row;//直播URL
/* 推荐部分--End*/


/* 其他游戏直播--Begin */
- (TRIntroLinkModel *)linkModelForIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic) NSInteger linkNumber;
@property (nonatomic) NSArray *linkList;
- (NSInteger)linkNumberForSection:(NSInteger)section;
- (NSURL *)linkIconURLForIndexPath:(NSIndexPath *)indexPath;//视频图片
- (NSURL *)linkAvatarIconURLForIndexPath:(NSIndexPath *)indexPath;//小图片
- (NSString *)linkTitleForIndexPath:(NSIndexPath *)indexPath;//房间名
- (NSString *)linkNickForIndexPath:(NSIndexPath *)indexPath;//主播名
- (NSString *)linkViewForIndexPath:(NSIndexPath *)indexPath;//观看人数
- (NSURL *)linkVideoURLForIndexPath:(NSIndexPath *)indexPath;//直播URL
- (NSString *)linkCategoryNameForIndexPath:(NSIndexPath *)indexPath;//分类名
- (NSString *)linkSlugForIndexPath:(NSIndexPath *)indexPath;//分类下面的种类区分
/* 其他游戏直播--End */
@end















