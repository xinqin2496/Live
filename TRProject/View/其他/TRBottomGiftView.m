//
//  TRBottomGiftView.m
//  TRProject
//
//  Created by 郑文青 on 16/7/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRBottomGiftView.h"

@implementation TRBottomGiftView

-(void)layoutSubviews
{
    [self.top_upBtn setRoundRectLayerCornerRadius:15 borderWidth:1 borderColor:[UIColor whiteColor]];
    [self.giveGiftBtn setRoundRectLayerCornerRadius:15 borderWidth:1 borderColor:[UIColor whiteColor]];
}
- (IBAction)clickBottomIVBtn:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 81:
            self.bottomIV.image = [UIImage imageNamed:@"100种子"];
            break;
        case 82:
            self.bottomIV.image = [UIImage imageNamed:@"我爱你"];
            break;
        case 83:
            self.bottomIV.image = [UIImage imageNamed:@"去污丸"];
            break;
        case 84:
            self.bottomIV.image = [UIImage imageNamed:@"小黄瓜"];
            break;
        case 85:
            self.bottomIV.image = [UIImage imageNamed:@"小鲍鱼"];
            break;
        case 86:
            self.bottomIV.image = [UIImage imageNamed:@"求合体"];
            break;
        default:
            self.bottomIV.image = [UIImage imageNamed:@"100种子"];
            break;
    }
}

@end
