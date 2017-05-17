//
//  TRIntroViewModel.m
//  TRProject
//
//  Created by jiyingxin on 16/3/9.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRIntroViewModel.h"

@implementation TRIntroViewModel

- (id)init{
    if (self = [super init]) {
        _recommendStartIndex = 0;
    }
    return self;
}

- (NSInteger)indexNumber{
    return self.indexList.count;
}

- (TRIntroMobileModel *)indexModelForIndex:(NSInteger)index{
    return self.indexList[index];
}

- (NSURL *)indexIconURLForIndex:(NSInteger)index{
    return [NSURL URLWithString:[self indexModelForIndex:index].thumb];
}

- (NSString *)indexTitleForIndex:(NSInteger)index{
    return [self indexModelForIndex:index].title;
}

- (NSURL *)indexURLForIndex:(NSInteger)index{
    NSString *uid = [self indexModelForIndex:index].linkObject.uid;
    return [NSURL URLWithString:[NSString stringWithFormat:kVideoPath, uid]];
}

- (void)getDataWithRequestMode:(RequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler{
    self.dataTask = [TRLiveNetManager getIntroCompletionHandler:^(TRIntroModel *model, NSError *error) {
        if (!error) {
            self.indexList = model.mobileIndex;
            self.starList = model.mobileStar;
            self.recommentList = model.mobileRecommendation;
            /*所有类型是TRIntroMobileLinkModel类型的, 样式一致
             通过runtime获取属性, 查看属性数组中的元素是什么类型
             */
            unsigned int outCount = 0;
            Ivar *varList = class_copyIvarList([model class], &outCount);
            NSMutableArray *tmpList = [NSMutableArray new];
            for (int i = 0; i < outCount; i++) {
                Ivar ivar = varList[i];
                const char *name = ivar_getName(ivar);
                NSString *propertyName = [[NSString alloc] initWithUTF8String:name];
                id obj = [model valueForKey:propertyName];
                if ([obj isKindOfClass:[NSArray class]]) {
                    id firstObj = [(NSArray *)obj firstObject];
                    if ([firstObj isKindOfClass:[TRIntroMobileLinkModel class]]) {
                        [tmpList addObject:obj];
                    }
                }
            }
            self.linkList = tmpList;
        }
        completionHandler(error);
    }];
}


- (NSInteger)starNumber{
    return self.starList.count;
}
- (TRIntroMobileModel *)starModelForIndex:(NSInteger)index{
    return self.starList[index];
}
- (NSString *)starNameForIndex:(NSInteger)index{
    return [self starModelForIndex:index].title;
}
- (NSURL *)starIconURLForIndex:(NSInteger)index{
    return [NSURL URLWithString:[self starModelForIndex:index].thumb];
}
- (NSURL *)starVideoURLForIndex:(NSInteger)index{
    NSString *uid = [self starModelForIndex:index].linkObject.uid;
    return [NSURL URLWithString:[NSString stringWithFormat:kVideoPath, uid]];
}

- (NSInteger)recommendNumber{
    if (self.currentRecommendList.count < 2) {
        return _currentRecommendList.count;
    }
    return 2;
}

- (NSArray *)currentRecommendList{
    if (_currentRecommendList.count == 0 && self.recommentList.count > 0) {
        [self changeCurrentRecommentList];
    }
    return _currentRecommendList;
}

- (void)changeCurrentRecommentList{
    if (self.recommentList.count > 0) {
        NSMutableArray *tmpArr = [NSMutableArray new];
        [tmpArr addObject:[self getNextRecommend]];
        [tmpArr addObject:[self getNextRecommend]];
        self.currentRecommendList = tmpArr;
    }
}

- (TRIntroMobileModel *)getNextRecommend{
    if (self.recommentList.count > 0) {
        if (self.recommentList.count - 1 >= _recommendStartIndex) {
            return self.recommentList[_recommendStartIndex++];
        }else{
            _recommendStartIndex = 1;
            return self.recommentList.firstObject;
        }
    }
    return nil;
    
}

- (TRIntroMobileModel *)recommendModelForRow:(NSInteger)row{
    return self.currentRecommendList[row];
}
- (NSString *)recommendTitleForRow:(NSInteger)row{
    return [self recommendModelForRow:row].linkObject.title;
}
- (NSURL *)recommendIconURLForRow:(NSInteger)row{
    return [NSURL URLWithString:[self recommendModelForRow:row].linkObject.thumb];
}
- (NSURL *)recommendAvatarIconURLForRow:(NSInteger)row
{
    return [NSURL URLWithString:[self recommendModelForRow:row].linkObject.avatar];
}
- (NSString *)recommendNickForRow:(NSInteger)row{
    return [self recommendModelForRow:row].linkObject.nick;
}
- (NSString *)recommendViewForRow:(NSInteger)row{
    NSString *views = [self recommendModelForRow:row].linkObject.view;
    if (views.doubleValue >= 10000) {
        views = [NSString stringWithFormat:@"%.2f万", views.doubleValue/10000.0];
    }
    return views;
}
- (NSURL *)recommendVideoURLForRow:(NSInteger)row{
    NSString *path = [NSString stringWithFormat:kVideoPath, [self recommendModelForRow:row].linkObject.uid];
    return [NSURL URLWithString:path];
}




- (TRIntroLinkModel *)linkModelForIndexPath:(NSIndexPath *)indexPath{
    NSArray *tmpMobileLinks = self.linkList[indexPath.section];
    TRIntroMobileLinkModel *mlModel = tmpMobileLinks[indexPath.row];
    return mlModel.linkObject;
}

- (NSInteger)linkNumber{
    return self.linkList.count;
}

- (NSInteger)linkNumberForSection:(NSInteger)section{
    NSArray *tmpMobileLinks = self.linkList[section];
    return tmpMobileLinks.count;
}

- (NSURL *)linkIconURLForIndexPath:(NSIndexPath *)indexPath{
    return [NSURL URLWithString:[self linkModelForIndexPath:indexPath].thumb];
}
- (NSURL *)linkAvatarIconURLForIndexPath:(NSIndexPath *)indexPath
{
    return [NSURL URLWithString:[self linkModelForIndexPath:indexPath].avatar];
}
- (NSString *)linkTitleForIndexPath:(NSIndexPath *)indexPath{
    return [self linkModelForIndexPath:indexPath].title;
}
- (NSString *)linkNickForIndexPath:(NSIndexPath *)indexPath{
    return [self linkModelForIndexPath:indexPath].nick;
}
- (NSString *)linkViewForIndexPath:(NSIndexPath *)indexPath{
    NSString *views = [self linkModelForIndexPath:indexPath].view;
    if (views.doubleValue >= 10000) {
        views = [NSString stringWithFormat:@"%.2f万", views.doubleValue/10000.0];
    }
    return views;
}
- (NSURL *)linkVideoURLForIndexPath:(NSIndexPath *)indexPath{
    NSString *path = [NSString stringWithFormat:kVideoPath, [self linkModelForIndexPath:indexPath].uid];
    return [NSURL URLWithString:path];
}
- (NSString *)linkCategoryNameForIndexPath:(NSIndexPath *)indexPath{
    return [self linkModelForIndexPath:indexPath].categoryName;
}
- (NSString *)linkSlugForIndexPath:(NSIndexPath *)indexPath{
    return [self linkModelForIndexPath:indexPath].categorySlug;
}
@end





