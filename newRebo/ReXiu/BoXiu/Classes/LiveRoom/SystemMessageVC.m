//
//  SystemMessageVC.m
//  BoXiu
//
//  Created by andy on 15/6/19.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "SystemMessageVC.h"
#import "SystemMessageView.h"
#import "LiveRoomViewController.h"

@interface SystemMessageVC ()

@property (strong, nonatomic) SystemMessageView *systemView;
@property (nonatomic) NSInteger systemUnreadMessage;
@end

@implementation SystemMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    _systemView = [[SystemMessageView alloc] initWithFrame:CGRectZero showInView:self.rootViewController.view];
    self.popupMenuDelegate = self;
    _systemView.popupMenudelegate = self;
    [self.view addSubview:_systemView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    _systemView.backgroundColor = [UIColor clearColor];
    //    _privateView.frame = CGRectMake(0, 0, self.view.frame.size.width - 90, self.view.frame.size.height - 81);
    _systemView.frame = CGRectMake(0, 0, self.view.frame.size.width * 0.63f, self.view.frame.size.height);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUnReadMessage];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)initData:(NSInteger)showType
{
    _systemUnreadMessage = 0;
    if (_systemView)
    {
        [_systemView clearAllMessage];
        if (showType == 3)
        {
            [_systemView showGiftRankBtn];
        }
    }
}

- (void)addUserEnterRoomMessage:(id)userEnterModel
{
    if (userEnterModel && _systemView)
    {
        [_systemView addUserEnterRoomMessage:userEnterModel];
    }
}


- (void)addApproveMessage:(SendApproveModel *)sendApproveModel
{
    if (sendApproveModel && _systemView)
    {
        [_systemView addApproveMessage:sendApproveModel];
    }
}

- (void)addSofaInfoToChatMessage:(RobSofaModel *)sofaModel
{
    if (sofaModel && _systemView)
    {
        [_systemView addSofaInfoToChatMessage:sofaModel];
    }
}

- (void)addRoomMessage:(NotifyMessageModel *)notifyMessageModel
{
    if (notifyMessageModel && _systemView)
    {
        [_systemView addRoomMessage:notifyMessageModel];
    }
}

- (void)addCrownMessage:(CrownModel *)crownModel
{
    if (crownModel && _systemView)
    {
        [_systemView addCrownMessage:crownModel];
    }
}

- (void)addGlobalMessage:(GlobalMessageModel *)globalMessageModel
{
    if (globalMessageModel && _systemView)
    {
        [_systemView addGlobalMessage:globalMessageModel];
    }
}

-(void)addGlobalLuckyGiftMessage:(NSDictionary *)dictionay
{
    if (dictionay && _systemView)
    {
        [_systemView addGlobalLuckyGiftMessage:dictionay];
    }
}

- (void)addGiftInfoToChatMessage:(GiveGiftModel *)giveGiftModel
{
    if (giveGiftModel && _systemView)
    {
        [_systemView addGiftInfoToChatMessage:giveGiftModel];
    }
}

- (void)addChatMessage:(ChatMessageModel *)chatMessageModel
{
    if (chatMessageModel && _systemView)
    {
        [self updateUnReadMessage];
        [_systemView addChatMessage:chatMessageModel];
    }
    
}

- (void)addAttionNotifyMessage:(AttentionNotifyModel *)attentionNotifyModel
{
    if (attentionNotifyModel && _systemView)
    {
        [_systemView addAttionNotifyMessage:attentionNotifyModel];
    }
}

- (void)updateUnReadMessage
{
    //    EWPTabMenuControl *tabMenuControl = (EWPTabMenuControl *)self.baseTabMenuControl;
    //    if (tabMenuControl)
    //    {
    //        if (tabMenuControl.currentSelectedSegmentIndex != 0)
    //        {
    //            _publicUnreadMessage++;
    //
    //        }
    //        else
    //        {
    //            _publicUnreadMessage = 0;
    //        }
    //        //现在需求公聊框不显示未读消息小图片，暂时屏蔽
    //        //[_tabMenuBar setBadge:_publicUnreadMessage atIndex:0];
    //    }
}

- (void)updateBigStarGiftRankMessage:(GiveGiftModel *)giveGiftModel
{
    if (giveGiftModel && _systemView)
    {
        [_systemView updateStarGiftRank:giveGiftModel.bigStargiftList];
    }
}

- (void)addMessage:(NSString *)message
{
    if (message && [message length])
    {
        [_systemView addMessage:message];
    }
}

#pragma mark -PopupMenuDelegate
- (void)showPopupMenu:(UserInfo *)userInfo
{
    if (userInfo)
    {
        LiveRoomViewController *lr = (LiveRoomViewController *)self.rootViewController;
        if ([lr respondsToSelector:@selector(showPopupMenu:)])
        {
            [lr showPopupMenu:userInfo];
        }
    }
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
