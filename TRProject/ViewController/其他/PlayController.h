//
//  PlayController.h
//  TRProject
//
//  Created by 郑文青 on 16/7/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayController : UIViewController
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
 *   视频头像
 */
@property(nonatomic,copy)NSURL *Hls_imageURL;
/**
 *   主播头像
 */
@property(nonatomic,copy)NSURL *Hls_avatarURL;
/**
 *  房间名
 */
@property(nonatomic,copy)NSString *Hls_title;

@end
