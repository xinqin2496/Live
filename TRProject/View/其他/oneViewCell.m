//
//  oneViewCell.m
//  DouYU
//
//  Created by 郑文青 on 16/7/20.
//  Copyright © 2016年 Alesary. All rights reserved.
//

#import "oneViewCell.h"

@interface oneViewCell()

@end

@implementation oneViewCell
//重写set方法
-(void)setMessage:(TRMessage *)message
{

    _message = message;
    //只要message 一有数据,就将内容显示到标签上
    
    _label.text = _message.content;
  
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
