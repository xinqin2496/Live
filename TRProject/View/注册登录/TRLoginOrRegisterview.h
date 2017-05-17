//
//  TRLoginOrRegisterview.h
//  TRProject
//
//  Created by 郑文青 on 16/8/3.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CardDownAnimationView.h"

@interface TRLoginOrRegisterview : CardDownAnimationView

/** 微信登录 */
@property (nonatomic,strong)UIButton *weChatBtn;
/** QQ登录 */
@property (nonatomic,strong)UIButton *QQBtn;
/** 微博登录 */
@property (nonatomic,strong)UIButton *weiboBtn;
/** 账号登录 */
@property (nonatomic,strong)UIButton *accountBtn;
/** 注册 */
@property (nonatomic,strong)UIButton *registerBtn;
@end
