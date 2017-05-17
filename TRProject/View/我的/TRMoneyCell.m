//
//  TRMoneyCell.m
//  TRProject
//
//  Created by 郑文青 on 16/8/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRMoneyCell.h"

@implementation TRMoneyCell

- (void)setFrame:(CGRect)frame {
   
    frame.origin.x += 30;

    frame.size.width -= 2 * 30;
    
     [super setFrame:frame];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setRoundRectLayerCornerRadius:5 borderWidth:1 borderColor:kRGBA(214, 215, 220, 1.0)];
    [self.topUpBtn setRoundRectLayerCornerRadius:10 borderWidth:1 borderColor:[UIColor whiteColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
