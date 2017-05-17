//
//  TRSearchViewModel.m
//  TRProject
//
//  Created by jiyingxin on 16/3/9.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRSearchViewModel.h"

@implementation TRSearchViewModel

- (NSInteger)rowNumber{
    return self.items.count;
}

- (NSMutableArray<TRSearchDataItemsModel *> *)items{
    if (!_items) {
        _items = [NSMutableArray new];
    }
    return _items;
}

- (TRSearchDataItemsModel *)modelForRow:(NSInteger)row{
    return self.items[row];
}

- (NSURL *)iconURLForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].thumb];
}

- (NSString *)titleForRow:(NSInteger)row{
    return [self modelForRow:row].title;
}
- (NSString *)nickForRow:(NSInteger)row{
    return [self modelForRow:row].nick;
}
- (NSString *)viewForRow:(NSInteger)row{
    NSString *views = [self modelForRow:row].view;
    if (views.doubleValue >= 10000) {
        views = [NSString stringWithFormat:@"%.2f万", views.doubleValue/10000.0];
    }
    return views;
}
- (NSURL *)videoURLForRow:(NSInteger)row{
    NSString *path = [NSString stringWithFormat:kVideoPath, [self modelForRow:row].uid];
    return [NSURL URLWithString:path];
}

- (void)getDataWithRequestMode:(RequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler{
    if (_words.length == 0) {
        completionHandler(nil);
        return;
    }
    NSInteger tmpPage = 0;
    switch (requestMode) {
        case RequestModeRefresh: {
            tmpPage = 0;
            break;
        }
        case RequestModeMore: {
            tmpPage = _page + 1;
            break;
        }
    }
    self.dataTask = [TRLiveNetManager search:_words page:tmpPage completionHandler:^(TRSearchModel *model, NSError *error) {
        if (!error) {
            if (requestMode == RequestModeRefresh) {
                [self.items removeAllObjects];
            }
            self.total = model.data.total;
            self.page = tmpPage;
            [self.items addObjectsFromArray:model.data.items];
            self.hasMore = _items.count >= self.total;
        }
        completionHandler(error);
    }];
}

@end
