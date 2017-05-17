//
//  RequestPath.h
//  TRProject
//
//  Created by jiyingxin on 16/3/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#ifndef RequestPath_h
#define RequestPath_h

#define kBasePath @"http://www.quanmin.tv/"

/**直播房间列表*/
#define kRoomsPath @"json/play/list%@.json"

/** 获取房间详细信息 */
#define kRoomDetailPath @"json/rooms/%@/info.json"

/** 直播栏目类型列表 */
#define kCategoriesPath @"json/categories/list.json"

/** 某栏目房间列表 */
#define kCategoryRoomsPath @"json/categories/%@/list%@.json"

/** 搜索功能 */
#define kSearchPath @"api/v1"

/** 推荐页广告 */
#define kADPath @"json/page/ad-slot/info.json"

/** 推荐页面 */
#define kIntroPath @"json/page/app-index/info.json"

/** 直播视频的网址 */

#define kVideoPath @"http://hls.quanmin.tv/live/%@/playlist.m3u8"


#endif /* RequestPath_h */
