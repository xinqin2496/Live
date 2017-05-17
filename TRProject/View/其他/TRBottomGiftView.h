//
//  TRBottomGiftView.h
//  TRProject
//
//  Created by 郑文青 on 16/7/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRBottomGiftView : UIView
//种子
@property (weak, nonatomic) IBOutlet UILabel *seedCountLb;
//平台币
@property (weak, nonatomic) IBOutlet UILabel *platformCountLb;
//赠送
@property (weak, nonatomic) IBOutlet UIButton *giveGiftBtn;
//充值
@property (weak, nonatomic) IBOutlet UIButton *top_upBtn;

@property (weak, nonatomic) IBOutlet UIImageView *bottomIV;

@end
