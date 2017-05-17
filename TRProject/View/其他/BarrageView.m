//
//  BarrageView.m
//  TRProject
//
//  Created by 郑文青 on 16/7/25.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BarrageView.h"

@interface BarrageView()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *titleArr;
@end

@implementation BarrageView
-(NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"二营长,老子的意大利炮呢?",@"📢营长别开炮,是我!",@"☏喂,妖妖灵吗,这里有人装逼",@"☏先让他先装一会,我们的人马上就到",@"🚣划船不用浆,一生全靠浪",@"因吹思婷",@"主播自己人",@"666666666666666666",@"色情主播我要报警了"];
    }
    return _titleArr;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = kRGBA(230, 230, 230, 0.4);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = kRGBA(230, 230, 230, 0.4);
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"barrageMessageChange" object:self userInfo:@{@"barrageMessage":self.titleArr[indexPath.row]}];
    
    [UIView animateWithDuration:5 animations:^{
        self.hidden = YES;
    }];
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
@end
