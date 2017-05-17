//
//  TRUserInfoViewController.h
//  TRProject
//
//  Created by 郑文青 on 16/8/5.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PHOTO_BLOCK)(UIImage *photoImage);

@interface TRUserInfoViewController : TRBaseViewController

-(instancetype)initWithBlock:(PHOTO_BLOCK)block saveImage:(UIImage *)saveImage;

@end
