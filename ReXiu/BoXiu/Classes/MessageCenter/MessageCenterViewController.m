       //
//  MessageCenterViewController.m
//  BoXiu
//
//  Created by tongmingyu on 14-11-19.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "MessageCenterCell.h"
#import "MessageCenter.h"
#import "UserInfoManager.h"

@interface MessageCenterViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *messageTableView;
@property (nonatomic, strong) NSMutableArray *messageMary;

@end

@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息中心";

    _messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _messageTableView.dataSource = self;
    _messageTableView.delegate = self;
    _messageTableView.delaysContentTouches = NO;
    _messageTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _messageTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_messageTableView];
    
    _messageMary = [[NSMutableArray alloc] initWithArray:[[MessageCenter shareMessageCenter] getMessageData]];
   
    if (_messageMary.count != 0)
    {
         NSMutableArray *messageId = [[NSMutableArray alloc] init];
        for (MessageData *msgData in _messageMary)
        {
            if (msgData.messageId && msgData.readed == NO)
            {
                NSString *strMsgID = [NSString stringWithFormat:@"%ld",(long)msgData.messageId];
                [messageId addObject:strMsgID];
            }
        }

        if (messageId.count != 0)
        {
            [[MessageCenter shareMessageCenter] markMoreMessageReadFlag:messageId];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf = self;
    [self setNavigationBarRightItem:nil itemNormalImg:[UIImage imageNamed:@"deleteMessage_normal"] itemHighlightImg:[UIImage imageNamed:@"deleteMessage_normal"] withBlock:^(id sender) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf deleteAllMessage];
    }];
    
    __weak typeof(self) weakself = self;
    [self setNavigationBarLeftItem:nil itemNormalImg:[UIImage imageNamed:@"navBack_normal"] itemHighlightImg:nil withBlock:^(id sender) {
        __strong typeof(self) strongself = weakself;
        if (strongself)
        {
            NSString *className = NSStringFromClass([weakself class]);
            NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
            [strongself popCanvasWithArgment:param];
        }
    }];

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageMary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    MessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MessageCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    cell.messageData = [self.messageMary objectAtIndex:indexPath.row];

    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        MessageData *msgData = [self.messageMary objectAtIndex:indexPath.row];
        [self.messageMary removeObjectAtIndex:indexPath.row];
        [[MessageCenter shareMessageCenter] deleteMessage:msgData.messageId];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageData *msgData = [self.messageMary objectAtIndex:indexPath.row];
    if (msgData.messageType == 1)
    {
        if (msgData.actionLink == 1)
        {
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setObject:msgData.data forKey:@"pageurlmobile"];
            [param setObject:msgData.title forKey:@"title"];
            
            [self pushCanvas:ActivityUrl_Canvas withArgument:param];
        }
        else if (msgData.actionLink == 2)
        {
            NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:[msgData.data integerValue]] forKey:@"staruserid"];
             [AppDelegate shareAppDelegate].isSelfWillLive = NO;
            [self pushCanvas:LiveRoom_CanVas withArgument:param];
        }
        else if (msgData.actionLink == 3)
        {
            NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
            if (hideSwitch == 2)
            {//商城显示的时候才可以进入商城界面
                [self pushCanvas:Mall_Canvas withArgument:nil];
            }
        }
        else if (msgData.actionLink == 4)
        {
            if (![AppInfo shareInstance].bLoginSuccess)
            {
                if ([self showLoginDialog])
                {
                    return;
                }
            }
            else
            {
                [self pushCanvas:SelectModePay_Canvas withArgument:nil];
            }
        }
        else if (msgData.actionLink == 5)
        {
            //跳转到邀请界面
            [self pushCanvas:Invite_Canvas withArgument:nil];

        }
    }
    else if(msgData.messageType == 2)
    {
        [self pushCanvas:PersonInfo_Canvas withArgument:nil];
    }
    else if(msgData.messageType == 3)
    {
        NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:msgData.staruserId] forKey:@"staruserid"];
        [self pushCanvas:LiveRoom_CanVas withArgument:param];
    }
    else if (msgData.messageType == 4)
    {
        if (![AppInfo shareInstance].bLoginSuccess)
        {
            if ([self showLoginDialog])
            {
                return;
            }
        }
        else
        {
            [self pushCanvas:SelectModePay_Canvas withArgument:nil];
        }

    }
    else if (msgData.messageType == 5)
    {
        //跳转到邀请界面
        [self pushCanvas:Invite_Canvas withArgument:nil];

    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MessageCenterCell height];
}


-(void)deleteAllMessage
{
    EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"提示" message:@"删除所有消息" confirmBlock:^(id sender)
                               {
                                   [self.messageMary removeAllObjects];
                                   [[MessageCenter shareMessageCenter] deleteAllMessage];
                                   [self.messageTableView reloadData];
                               } cancelBlock:^(id sender) {
                                   
                               }];
    [alertView show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
