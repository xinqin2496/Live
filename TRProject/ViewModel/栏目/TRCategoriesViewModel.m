//
//  TRCategoriesViewModel.m
//  TRProject
//
//  Created by jiyingxin on 16/3/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRCategoriesViewModel.h"

@implementation TRCategoriesViewModel

- (NSURL *)iconURLForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].thumb];
}

- (TRCategoriesModel *)modelForRow:(NSInteger)row{
    return self.categories[row];
}

- (NSInteger)rowNumber{
    return self.categories.count;
}

- (NSString *)titleForRow:(NSInteger)row{
    return [self modelForRow:row].name;
}

- (NSString *)slugForRow:(NSInteger)row{
    return [self modelForRow:row].slug;
}

- (NSString *)categoryNameForRow:(NSInteger)row{
    return [self modelForRow:row].name;
}

- (void)getDataWithRequestMode:(RequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler{
    self.dataTask = [TRLiveNetManager getCategoriesCompletionHandler:^(id model, NSError *error) {
        if (!error) {
            self.categories = model;
        
        }
        completionHandler(error);
    }];
}
-(NSArray *)categories
{
    if (!_categories) {
        _categories = [NSArray array];
    }
    return _categories;
}
@end










