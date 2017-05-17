//
//  TRCategoryViewController.h
//  TRProject
//
//  Created by jiyingxin on 16/3/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRCategoryViewController : UIViewController
- (instancetype)initWithSlug:(NSString *)slug categoryName:(NSString *)categoryName;
@property (nonatomic) NSString *slug;
@property (nonatomic) NSString *categoryName;
@end
