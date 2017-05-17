//
//  oneView.m
//  DouYU
//
//  Created by 郑文青 on 16/7/20.
//  Copyright © 2016年 Alesary. All rights reserved.
//

#import "oneView.h"
#import "oneViewCell.h"
#import "TRTopUpViewController.h"
#import "TRMessage.h"
#import "TRLoginOrRegisterview.h"
#import "TRLoginViewController.h"
#import "TRRegisterViewController.h"
@interface oneView() <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,CardDownAnimationViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//表格要显示的全部信息
@property (nonatomic,strong)NSMutableArray *allMessages;
/** 消息 */
@property (nonatomic,strong)oneViewCell *cell;
/** 用户 */
@property (nonatomic,strong)TRUserInfo *userInfo;

@end

@implementation oneView
-(TRUserInfo *)userInfo
{
    if (!_userInfo) {
        _userInfo = [TRUserInfo sharedTRUserInfo];
    }
    return _userInfo;
}
-(NSMutableArray *)allMessages
{
    if (!_allMessages) {
        _allMessages = [TRMessage messageData].mutableCopy;
    }
    return _allMessages;
}


- (IBAction)textFieldDidEndOnExit:(id)sender
{
  
    if(self.textField.text.length == 0){
        [self showWarning:@"发送的消息不能为空"];
        return;
    }
    [self.userInfo loadUserInfoToSandox];
    //获取内容 发消息
    NSString *newContent = [NSString stringWithFormat:@"%@:%@",self.userInfo.nickName,self.textField.text];
    
    //非空判断
    if (newContent.length == 0) {
        return;
    }
    //创建新的message对象
    TRMessage *newMessage = [[TRMessage alloc]init];
    newMessage.content = newContent;
    
    
    //将数据保存到数组中
    [self.allMessages addObject:newMessage];
    self.textField.text = @"";//一定要清空一下textField
    //刷新表格
//        [self.tableView reloadData];
    //在最后一行插入
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.allMessages.count  -1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom ];

}

-(instancetype)init
{
    
    self=[[[NSBundle mainBundle]loadNibNamed:@"oneView" owner:nil options:nil] firstObject];
    
    
    if (self) {
        int num = arc4random()%4 ;
        switch (num) {
            case 0:
                 _textField.placeholder = @"不发弹幕真的不寂寞吗?";
                break;
            case 1:
                _textField.placeholder = @"骚年,发个弹幕吧!";
                break;
            case 2:
                _textField.placeholder = @"弹幕走一走,活到九十九";
                break;
            case 3:
                _textField.placeholder = @"弹幕吐槽一下吧";
                break;
            default:
                 _textField.placeholder = @"爷,弹幕飞一个";
                break;
        }
    
    
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _textField.delegate = self;
        _tableView.backgroundColor = kRGBA(244, 251, 255,1);
        //把键盘上的工具栏隐藏
        [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    }
    
    return self;
}
//控制表格滚动到最后一行
-(void)scrollToTableViewLastRow
{
    //创建最后一行对应的indexPath
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.allMessages.count  -1 inSection:0];
    //控制表格滚动到最后一行对应的indexpath 位置
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    
    [self scrollToTableViewLastRow];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allMessages.count ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    oneViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    oneViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.cell = cell;
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"oneViewCell" owner:nil options:nil].lastObject;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    TRMessage *message = self.allMessages[indexPath.row];

    
    if (indexPath.row == 0) {
        cell.label.text = @"我嗨直播直播平台严禁直播低俗、侵权、色情、以及反动内容";
        cell.label.textColor = [UIColor redColor];
      
    }else if (indexPath.row == 1){
        cell.label.text =  @"房间正在连接中...";
    }else if(indexPath.row == 2){
        cell.label.text = [NSString stringWithFormat:@"欢迎来到【 %@ 】的直播房间",self.backName];
    }else if (indexPath.row == 3){
        cell.label.text = @"弹幕连接中...";
    }else if (indexPath.row == 4){
        cell.label.text = @"弹幕服务器连接成功";
    }else{
       
        cell.message = message;
        //截取 : 之前的字符串
        NSArray *arr = [cell.label.text componentsSeparatedByString:@":"];
        NSString *arrStr = arr[0];
         //判断一个字符串里面含有 : ,就把名称 改为蓝色
        if([cell.label.text rangeOfString:@":"].location != NSNotFound){
            
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:cell.label.text];
            
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, arrStr.length +1)];
        cell.label.attributedText = AttributedStr;
            
        NSString *messageContent = [cell.label.text substringFromIndex:arrStr.length + 1];
            
        [[NSNotificationCenter defaultCenter]postNotificationName:@"MessageChange" object:self userInfo:@{@"message":messageContent}];
        }
       
        
    }
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 26;
}

@end
