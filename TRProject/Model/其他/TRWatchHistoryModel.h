//
//  TRWatchHistoryModel.h
//  TRProject
//
//  Created by 郑文青 on 16/7/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRWatchHistoryModel : NSObject

/**
 *  直播的url
 */
@property(nonatomic,copy)NSString *Hls_liveStr;
/**
 *  在线人数
 */
@property(nonatomic,copy)NSString *Hls_onlines;
/**
 *  主播名
 */
@property(nonatomic,copy)NSString *Hls_name;
/**
 *  图片名称
 */
@property(nonatomic,copy)NSString *imageStr;
/**
 *  房间名
 */
@property(nonatomic,copy)NSString *Hls_title;
/** 小图片 */
@property (nonatomic,copy)NSString *avatarStr;
/**
 *   观看历史的数据
 */
//删除当前数据
+ (BOOL)removeWatchHistory:(NSString *)Hls_name;
//所有数据
+(NSArray *)watchHistoryArray;
@end
