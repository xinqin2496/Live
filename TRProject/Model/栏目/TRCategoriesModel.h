//
//  TRCategoriesModel.h
//  TRProject
//
//  Created by jiyingxin on 16/3/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRBaseModel.h"
@interface TRCategoriesModel : TRBaseModel

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *firstLetter;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger prompt;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *name;

@end


