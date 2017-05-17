//
//  oneView.h
//  DouYU
//
//  Created by 郑文青 on 16/7/20.
//  Copyright © 2016年 Alesary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface oneView : UIView
@property(nonatomic,copy)NSString *backName;
@property (weak, nonatomic) IBOutlet UIButton *barrageBtn;
@property (weak, nonatomic) IBOutlet UIButton *top_upBtn;
@property (weak, nonatomic) IBOutlet UIButton *giftBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end
