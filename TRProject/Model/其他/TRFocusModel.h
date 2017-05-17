//
//  TRFocusModel.h
//  TRProject
//
//  Created by 郑文青 on 16/7/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRFocusModel : NSObject

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
/** 小图片
 */
@property (nonatomic,copy)NSString *avatarStr;
/**
 *  房间名
 */
@property(nonatomic,copy)NSString *Hls_title;
/**
 *  关注的数据
 */
//删除当前数据
+ (BOOL)removeFocus:(NSString *)Hls_name;
//所有数据
+(NSArray *)focusArray;



@end
