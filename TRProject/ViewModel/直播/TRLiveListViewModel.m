//
//  TRLiveListViewModel.m
//  TRProject
//
//  Created by jiyingxin on 16/3/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRLiveListViewModel.h"

@implementation TRLiveListViewModel
- (NSInteger)rowNumber{
    return self.roomList.count;
}

- (TRCategoryDataModel *)modelForRow:(NSInteger)row{
    return self.roomList[row];
}

- (NSString *)titleForRow:(NSInteger)row{
    return [self modelForRow:row].title;
}

- (NSURL *)iconURLForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].thumb];
}
- (NSURL *)avatarURLForRow:(NSInteger)row
{
    return [NSURL URLWithString:[self modelForRow:row].avatar];
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
    
    self.dataTask = [TRLiveNetManager getRoomListWithPage:tmpPage completionHandler:^(TRRoomListModel *model, NSError *error) {
        if (!error) {
            self.page = model.page;
            self.size = model.size;
            self.total = model.total;
            self.pageCount = model.pageCount;
            if (model.page == 0) {
                [self.roomList removeAllObjects];
            }
            [self.roomList addObjectsFromArray:model.data];
        }
        completionHandler(error);
    }];
}

- (NSMutableArray *)roomList{
    if (!_roomList) {
        _roomList = [NSMutableArray new];
    }
    return _roomList;
}
@end
