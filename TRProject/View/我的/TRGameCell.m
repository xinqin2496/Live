//
//  TRGameCell.m
//  TRProject
//
//  Created by 郑文青 on 16/7/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRGameCell.h"

@implementation TRGameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconIV.layer.masksToBounds = YES;
    self.iconIV.layer.cornerRadius = 5;
    self.iconIV.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconIV.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
