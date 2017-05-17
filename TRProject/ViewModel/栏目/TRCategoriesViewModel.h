//
//  TRCategoriesViewModel.h
//  TRProject
//
//  Created by jiyingxin on 16/3/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRBaseViewModel.h"
#import "TRLiveNetManager.h"

@interface TRCategoriesViewModel : TRBaseViewModel
@property (nonatomic) NSInteger rowNumber;
@property (nonatomic) NSArray *categories;

- (NSURL *)iconURLForRow:(NSInteger)row;
- (NSString *)titleForRow:(NSInteger)row;
- (TRCategoriesModel *)modelForRow:(NSInteger)row;
- (NSString *)slugForRow:(NSInteger)row;
- (NSString *)categoryNameForRow:(NSInteger)row;
@end
