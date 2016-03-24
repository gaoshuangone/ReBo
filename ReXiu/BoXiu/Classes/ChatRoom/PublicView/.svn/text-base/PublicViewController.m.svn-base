//
//  PublicViewController.m
//  BoXiu
//
//  Created by andy on 15-1-9.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "PublicViewController.h"
#import "EWPTabMenuControl.h"

@class ChatRoomViewController;
@interface PublicViewController ()

@property (nonatomic,strong) PublicView *publicView;
@property (nonatomic) NSInteger publicUnreadMessage;

@end

@implementation PublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _publicView = [[PublicView alloc] initWithFrame:CGRectZero showInView:self.rootViewController.view];
    _publicView.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
    _publicView.popupMenudelegate = self;
    [self.view addSubview:_publicView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    _publicView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 81);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUnReadMessage];
    if (_chatToolBar && self.rootViewController)
    {
        [_chatToolBar viewWillAppear];
        if (self.baseTabMenuControl)
        {
            [self.rootViewController.view insertSubview:_chatToolBar aboveSubview:self.baseTabMenuControl];
        }
        _chatToolBar.hidden = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_chatToolBar)
    {
        [_chatToolBar viewwillDisappear];
        _chatToolBar.hidden = YES;
    }
}

- (void)initData:(NSInteger)showType
{
    _publicUnreadMessage = 0;
    if (_publicView)
    {
        [_publicView clearAllMessage];
        if (showType == 3)
        {
            [_publicView showGiftRankBtn];
        }
    }
}

- (void)addUserEnterRoomMessage:(id)userEnterModel
{
    if (userEnterModel && _publicView)
    {
        [_publicView addUserEnterRoomMessage:userEnterModel];
    }
}


- (void)addApproveMessage:(SendApproveModel *)sendApproveModel
{
    if (sendApproveModel && _publicView)
    {
        [_publicView addApproveMessage:sendApproveModel];
    }
}

- (void)addSofaInfoToChatMessage:(RobSofaModel *)sofaModel
{
    if (sofaModel && _publicView)
    {
        [_publicView addSofaInfoToChatMessage:sofaModel];
    }
}

- (void)addRoomMessage:(NotifyMessageModel *)notifyMessageModel
{
    if (notifyMessageModel && _publicView)
    {
        [_publicView addRoomMessage:notifyMessageModel];
    }
}

- (void)addCrownMessage:(CrownModel *)crownModel
{
    if (crownModel && _publicView)
    {
        [_publicView addCrownMessage:crownModel];
    }
}

- (void)addGlobalMessage:(GlobalMessageModel *)globalMessageModel
{
    if (globalMessageModel && _publicView)
    {
        [_publicView addGlobalMessage:globalMessageModel];
    }
}

-(void)addGlobalLuckyGiftMessage:(GlobaMessageLuckyModel *)globaLuckyModel
{
    if (globaLuckyModel && _publicView)
    {
        [_publicView addGlobalLuckyGiftMessage:globaLuckyModel];
    }
}

- (void)addGiftInfoToChatMessage:(GiveGiftModel *)giveGiftModel
{
    if (giveGiftModel && _publicView)
    {
        [_publicView addGiftInfoToChatMessage:giveGiftModel];
    }
}

- (void)addChatMessage:(ChatMessageModel *)chatMessageModel
{
    if (chatMessageModel && _publicView)
    {
        [self updateUnReadMessage];
        [_publicView addChatMessage:chatMessageModel];
    }
   
}

- (void)addAttionNotifyMessage:(AttentionNotifyModel *)attentionNotifyModel
{
    if (attentionNotifyModel && _publicView)
    {
        [_publicView addAttionNotifyMessage:attentionNotifyModel];
    }
}

- (void)updateUnReadMessage
{
    EWPTabMenuControl *tabMenuControl = (EWPTabMenuControl *)self.baseTabMenuControl;
    if (tabMenuControl)
    {
        if (tabMenuControl.currentSelectedSegmentIndex != 0)
        {
            _publicUnreadMessage++;
            
        }
        else
        {
            _publicUnreadMessage = 0;
        }
        //现在需求公聊框不显示未读消息小图片，暂时屏蔽
        //[_tabMenuBar setBadge:_publicUnreadMessage atIndex:0];
    }
}

- (void)updateBigStarGiftRankMessage:(GiveGiftModel *)giveGiftModel
{
    if (giveGiftModel && _publicView)
    {
        [_publicView updateStarGiftRank:giveGiftModel.bigStargiftList];
    }
}

- (void)addMessage:(NSString *)message
{
    if (message && [message length])
    {
        [_publicView addMessage:message];
    }
}

#pragma mark -PopupMenuDelegate
- (void)showPopupMenu:(UserInfo *)userInfo
{
    if (userInfo)
    {
        if (self.popupMenuDelegate && [self.popupMenuDelegate respondsToSelector:@selector(showPopupMenu:)])
        {
            [self.popupMenuDelegate showPopupMenu:userInfo];
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
