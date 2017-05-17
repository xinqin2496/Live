//
//  TRGameCell.h
//  TRProject
//
//  Created by 郑文青 on 16/7/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRGameCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLb;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;

@end
