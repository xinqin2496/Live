//
//  oneViewCell.h
//  DouYU
//
//  Created by 郑文青 on 16/7/20.
//  Copyright © 2016年 Alesary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRMessage.h"
@interface oneViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic,strong)TRMessage *message;
@end
