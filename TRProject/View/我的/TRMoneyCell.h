//
//  TRMoneyCell.h
//  TRProject
//
//  Created by 郑文青 on 16/8/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRMoneyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *topUpBtn;
@property (weak, nonatomic) IBOutlet UILabel *platformCountLb;
@property (weak, nonatomic) IBOutlet UILabel *seedCountLb;

@end
