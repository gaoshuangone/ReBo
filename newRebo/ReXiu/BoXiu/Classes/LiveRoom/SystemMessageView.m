//
//  SystemMessageView.m
//  BoXiu
//
//  Created by andy on 15/6/17.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "SystemMessageView.h"
#import "StarRoomGiftRank.h"
#import "UIImage+RTTint.h"
#import "UIImageView+WebCache.h"
#import "GetOneFieldModel.h"

#define HeadImageWidth         36.0f
#define LabelMarginWidth       10.0f
#define VerticalSpace          7.0f

@interface SystemMessageView ()

@property (nonatomic,strong) NSMutableArray *messageLableMArray;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIButton *giftRankBtn;
@property (nonatomic,strong) StarRoomGiftRank *starGiftRank;

@property (nonatomic,strong) NSMutableArray *starGiftRankMArray;

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSLock  *lock;
@property (nonatomic,strong) NSMutableArray *chatmessageBufferMArray;
@property (nonatomic,strong) NSArray *userArray;
@property (nonatomic,strong) NSArray *imgArray;
@end

@implementation SystemMessageView

- (void)viewWillAppear
{
    [super viewWillAppear];
    
}

- (void)viewwillDisappear
{
    [super viewwillDisappear];
}

- (void)initView:(CGRect)frame
{
    self.backgroundColor = [UIColor yellowColor];
    _messageLableMArray = [NSMutableArray array];
    
    _chatmessageBufferMArray = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = [UIColor clearColor];
    //    _tableView.tableHeaderView.backgroundColor = [UIColor redColor];
    //    _tableView.tableFooterView.backgroundColor = [UIColor yellowColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.clipsToBounds = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:_tableView];
    
    _lock = [[NSLock alloc] init];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.08 target:self selector:@selector(getChatMessage) userInfo:nil repeats:YES];
    
    
}

- (void)queryGiftRankData
{
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"staruserid"];
    StarGiftRankModel *model = [[StarGiftRankModel alloc] init];
    [model requestDataWithParams:param success:^(id object) {
        if (model.result == 0)
        {
            if (_starGiftRankMArray == nil)
            {
                _starGiftRankMArray = [NSMutableArray array];
            }
            [_starGiftRankMArray removeAllObjects];
            [_starGiftRankMArray addObjectsFromArray:model.dataMArray];
            [_starGiftRank reloadData:_starGiftRankMArray];
        }
    } fail:^(id object) {
        
    }];
}

- (void)showGiftRankBtn
{
    if (_giftRankBtn == nil)
    {
        _giftRankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _giftRankBtn.frame = CGRectMake(self.frame.size.width - 10 - 40, 5, 40, 65);
        _giftRankBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ReBoRoom_giftrank"]];
        [_giftRankBtn addTarget:self action:@selector(showStarRoomGiftRank:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_giftRankBtn];
    }
}


- (void)showStarRoomGiftRank:(id)sender
{
    if (_starGiftRank == nil)
    {
        UIControl *bkControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        bkControl.backgroundColor = [UIColor clearColor];
        [bkControl addTarget:self action:@selector(hideReBoGiftRank:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:bkControl];
        
        _starGiftRank = [[StarRoomGiftRank alloc] initWithFrame:CGRectMake(self.frame.size.width - 10 - 150, 270, 150, 170) showInView:self.containerView];
        [self.containerView addSubview:_starGiftRank];
        
        [self queryGiftRankData];
    }
    else
    {
        [self hideReBoGiftRank:nil];
    }
}

- (void)hideReBoGiftRank:(id)sender
{
    UIControl *bkControl = (UIControl *)sender;
    [bkControl removeFromSuperview];
    
    [_starGiftRank removeFromSuperview];
    _starGiftRank = nil;
}


- (void)clearAllMessage
{
    if (_messageLableMArray)
    {
        [_messageLableMArray removeAllObjects];
    }
    
    [self.tableView reloadData];
}

//更新明星直播间礼物排行榜
- (void)updateStarGiftRank:(NSArray *)starGiftRankDatas
{
    if (starGiftRankDatas && starGiftRankDatas.count > 0)
    {
        if (_starGiftRankMArray == nil)
        {
            _starGiftRankMArray = [NSMutableArray array];
        }
        [_starGiftRankMArray removeAllObjects];
        [_starGiftRankMArray addObjectsFromArray:starGiftRankDatas];
        [_starGiftRank reloadData:_starGiftRankMArray];
    }
}

- (void)addChatMessage:(ChatMessageModel *)chatMessageModel
{
    UserInfo *info = nil;
    if (chatMessageModel.userid != 0 && [chatMessageModel.nick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = chatMessageModel.userid;
        userInfo.nick = chatMessageModel.nick;
        userInfo.hidden = chatMessageModel.hidden;
        userInfo.hiddenindex = chatMessageModel.hiddenindex;
        userInfo.issupermanager = chatMessageModel.issupermanager;
        userInfo.photo = chatMessageModel.photo;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
        info = userInfo;
    }
    
    if (chatMessageModel.targetUserid != 0 && [chatMessageModel.targetNick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = chatMessageModel.targetUserid;
        userInfo.nick = chatMessageModel.targetNick;
        userInfo.hidden = chatMessageModel.thidden;
        userInfo.hiddenindex = chatMessageModel.thiddenindex;
        userInfo.issupermanager = chatMessageModel.tissupermanager;
        userInfo.photo = chatMessageModel.photo;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
        info = userInfo;
    }
    
    NSString *headString = nil;
    if (chatMessageModel.targetUserid == 0)
    {   //对所有人说：发言用户头像+@发言用户昵称+换行+发言内容
        headString =[NSString stringWithFormat:@"{%ld}\n",(long)chatMessageModel.userid];
    }
    else
    {   //对别人说：发言用户头像+@发言用户昵称+换行+@发言对象昵称+空格+发言内容
        headString = [NSString stringWithFormat:@"{%ld}\n{%ld} ",(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
    }
    NSString *chatMessage = [NSString stringWithFormat:@"%@%@",headString,chatMessageModel.msg];
    
    [self creatLabelWithChatMessage:chatMessage userInfo:info isEnter:NO];
}

- (void)addSofaInfoToChatMessage:(RobSofaModel *)sofaModel
{
    UserInfo *info = nil;
    if (sofaModel.userid != 0 && [sofaModel.nick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = sofaModel.userid;
        userInfo.nick   = sofaModel.nick;
        userInfo.hidden = sofaModel.hidden;
        userInfo.hiddenindex    = sofaModel.hiddenindex;
        userInfo.issupermanager = sofaModel.issupermanager;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
        info = userInfo;
    }
    
    NSString *chatMessage = [NSString stringWithFormat:@"{%ld}\n用%ld个沙发抢得一个贵宾席位",(long)sofaModel.userid,(long)sofaModel.num];
    [self creatLabelWithChatMessage:chatMessage userInfo:info];
}

- (void)addRoomMessage:(NotifyMessageModel *)notifyMessageModel
{
    UserInfo *info = nil;
    if (notifyMessageModel.fromuserid != 0 && [notifyMessageModel.fromusernick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = notifyMessageModel.fromuserid;
        userInfo.nick = notifyMessageModel.fromusernick;
        userInfo.hidden = notifyMessageModel.hidden;
        userInfo.hiddenindex = notifyMessageModel.hiddenindex;
        userInfo.issupermanager = notifyMessageModel.issupermanager;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
        info = userInfo;
    }
    
    if (notifyMessageModel.touserid != 0 && [notifyMessageModel.tousernick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = notifyMessageModel.touserid;
        userInfo.nick = notifyMessageModel.tousernick;
        userInfo.hidden = notifyMessageModel.thidden;
        userInfo.hiddenindex = notifyMessageModel.thiddenindex;
        userInfo.issupermanager = notifyMessageModel.tissupermanager;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
        info = userInfo;
    }
    
    NSString *chatMessage = notifyMessageModel.msg;
    [self creatLabelWithChatMessage:chatMessage userInfo:info];
}

- (void)addGlobalMessage:(GlobalMessageModel *)globalMessageModel
{
    if (globalMessageModel && globalMessageModel.msg)
    {
        [self creatLabelWithChatMessage:globalMessageModel.msg userInfo:nil];
    }
}

- (void)addGiftInfoToChatMessage:(GiveGiftModel *)giveGiftModel
{
    UserInfo *info = nil;
    if (giveGiftModel.useridfrom != 0 && [giveGiftModel.usernickfrom length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = giveGiftModel.useridfrom;
        userInfo.nick = giveGiftModel.usernickfrom;
        userInfo.hidden = giveGiftModel.hidden;
        userInfo.hiddenindex = giveGiftModel.hiddenindex;
        userInfo.issupermanager = giveGiftModel.issupermanager;
        userInfo.staruserid = giveGiftModel.staruserid;
        [[UserInfoManager shareUserInfoManager] addChatMember:userInfo];
        info = userInfo;
    }
    
    if (giveGiftModel.useridto != 0 && [giveGiftModel.usernickto length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = giveGiftModel.useridto;
        userInfo.nick = giveGiftModel.usernickto;
        userInfo.hidden = giveGiftModel.thidden;
        userInfo.hiddenindex = giveGiftModel.thiddenindex;
        userInfo.issupermanager = giveGiftModel.tissupermanager;
        userInfo.staruserid = giveGiftModel.staruserid;
        [[UserInfoManager shareUserInfoManager] addChatMember:userInfo];
        info = userInfo;
    }
    
    NSString *headString = nil;
    if (giveGiftModel.useridto != 0 && giveGiftModel.useridfrom != 0)
    {   //送礼信息，显示样式：@送礼用户昵称+空格+送给+@受理用户昵称+空格+礼物名称x礼物数量+礼物图片
        headString = [NSString stringWithFormat:@"{%ld} 送给 {%ld}",(long)giveGiftModel.useridfrom,(long)giveGiftModel.useridto];
    }
    
    NSString *giftUrl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,giveGiftModel.giftimg];
    NSString *chatMessage = [NSString stringWithFormat:@"%@ %@ x%ld <%@>",headString, giveGiftModel.giftname, (long)giveGiftModel.objectnum,giftUrl];
    OHAttributedLabel *label = [self creatLabelWithChatMessage:chatMessage userInfo:info isEnter:YES];
    
    NSString *yellowString = [NSString stringWithFormat:@" x%ld ", (long)giveGiftModel.objectnum];
    NSRange yellowRange = [label.attributedText.string rangeOfString:yellowString];
    [label addCustomLink:[NSURL URLWithString:yellowString] inRange:yellowRange color:[CommonFuction colorFromHexRGB:@"F7C520"]];
    
}

- (void)addApproveMessage:(SendApproveModel *)sendApproveModel
{
    UserInfo *info = nil;
    if (sendApproveModel)
    {
        if (sendApproveModel.userid != 0 && [sendApproveModel.nick length] > 0)
        {
            UserInfo *userInfo = [[UserInfo alloc] init];
            userInfo.userId = sendApproveModel.userid;
            userInfo.nick = sendApproveModel.nick;
            userInfo.hidden = sendApproveModel.hidden;
            userInfo.hiddenindex = sendApproveModel.hiddenindex;
            userInfo.issupermanager = sendApproveModel.issupermanager;
            [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
            info = userInfo;
            
        }
        
        if (sendApproveModel.staruserid != 0 && [sendApproveModel.starnick length] > 0)
        {
            UserInfo *userInfo = [[UserInfo alloc] init];
            userInfo.userId = sendApproveModel.staruserid;
            userInfo.nick = sendApproveModel.starnick;
            [[UserInfoManager shareUserInfoManager] addGiftMember:userInfo];
            info = userInfo;
        }
        
        NSString *message = nil;
        
        message = [NSString stringWithFormat:@"{%ld}送给{%ld}1个赞",(long)sendApproveModel.userid,(long)sendApproveModel.staruserid];
        
        [self creatLabelWithChatMessage:message userInfo:info];
        
    }
}

- (void)addUserEnterRoomMessage:(UserEnterRoomModel *)userEnterModel
{
    UserInfo *info = nil;
    if (userEnterModel.memberData )
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = userEnterModel.memberData.userId;
        userInfo.nick = userEnterModel.memberData.nick;
        userInfo.hidden = userEnterModel.memberData.hidden;
        userInfo.hiddenindex = userEnterModel.memberData.hiddenindex;
        [[UserInfoManager shareUserInfoManager] addChatMember:userInfo];
        info = userInfo;
        
        NSMutableString *message = [NSMutableString string];
        UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        if(userInfo.userId == currentUserInfo.userId)
        {
            
            [message appendFormat:@"欢迎 {%ld} ",(long)userInfo.userId];
            if (userEnterModel.carData)
            {
                [message appendString:@"开着一辆"];
                [message appendFormat:@"%@",userEnterModel.carData.carname];
                NSString *carUrl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,userEnterModel.carData.carimgsmall];
                [message appendFormat:@" <%@> ",carUrl];
            }
            [message appendString:@"进入了房间"];
        }
        else
        {
            if (userInfo.hidden == 2)
            {
                if (currentUserInfo.issupermanager)
                {
                    if (userInfo.issupermanager)
                    {
                        [message appendString:@"有一位神秘用户进入了房间"];
                    }
                    else
                    {
                        [message appendFormat:@"欢迎 {%ld} ",(long)userInfo.userId];
                        if (userEnterModel.carData)
                        {
                            [message appendString:@"开着一辆"];
                            [message appendFormat:@"%@",userEnterModel.carData.carname];
                            NSString *carUrl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,userEnterModel.carData.carimgsmall];
                            [message appendFormat:@" <%@> ",carUrl];
                        }
                        [message appendString:@"进入了房间"];
                    }
                }
                else
                {
                    [message appendString:@"有一位神秘用户"];
                    if (userEnterModel.carData)
                    {
                        [message appendString:@"开着一辆"];
                        [message appendFormat:@"%@",userEnterModel.carData.carname];
                        NSString *carUrl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,userEnterModel.carData.carimgsmall];
                        [message appendFormat:@" <%@> ",carUrl];
                    }
                    [message appendString:@"进入了房间"];
                }
            }
            else
            {
                [message appendFormat:@"欢迎 {%ld} ",(long)userInfo.userId];
                
                if (userEnterModel.carData)
                {
                    [message appendString:@"开着一辆"];
                    [message appendFormat:@"%@",userEnterModel.carData.carname];
                    NSString *carUrl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,userEnterModel.carData.carimgsmall];
                    [message appendFormat:@" <%@> ",carUrl];
                }
                [message appendString:@"进入了房间"];
            }
        }
        
        [self creatLabelWithChatMessage:message userInfo:info isEnter:YES];
    }
}

- (void)addCrownMessage:(CrownModel *)crownModel
{
    if (crownModel)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = crownModel.userid;
        userInfo.nick = crownModel.nick;
        userInfo.hidden = crownModel.hidden;
        userInfo.hiddenindex = crownModel.hiddenindex;
        userInfo.issupermanager = crownModel.issupermanager;
        [[UserInfoManager shareUserInfoManager] addChatMember:userInfo];
        
        NSString *chatMessage = [NSString stringWithFormat:@"恭喜{%ld}成为最新的皇冠粉丝！",(long)crownModel.userid];
        [self creatLabelWithChatMessage:chatMessage userInfo:userInfo];
        
    }
}


-(void)addGlobalLuckyGiftMessage:(NSDictionary *)dictionay
{
    UserInfo *info = nil;
    GlobaMessageLuckyModel *model = [[GlobaMessageLuckyModel alloc] initWithData:dictionay];
    if (model.userid != 0 && [model.usernick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = model.userid;
        userInfo.nick = model.usernick;
        userInfo.hidden = model.hidden;
        userInfo.hiddenindex = model.hiddenindex;
        userInfo.issupermanager = model.issupermanager;
        [[UserInfoManager shareUserInfoManager] addChatMember:userInfo];
        info = userInfo;
    }
    
    NSString *headString = nil;
    
    if (model.userid != 0 && model.rewardtype == 2)
    {
        headString = [NSString stringWithFormat:@"恭喜{%ld}获得幸运礼物大奖 %ld 倍 %@ 奖励，奖金 %ld 热币，小伙伴们快去试试手气吧。",(long)model.userid,(long)model.rewardbs,model.giftname,(long)model.rewardCoin];
    }
    else
    {
        headString = [NSString stringWithFormat:@"恭喜{%ld}获得幸运礼物大奖 %@ 奖励，奖金 %ld 热币，小伙伴们快去试试手气吧。",(long)model.userid,model.giftname,(long)model.rewardCoin];
    }
    
    OHAttributedLabel *label = [self creatLabelWithChatMessage:headString userInfo:info];
    
    NSString *yellowString = [NSString stringWithFormat:@" %ld ", (long)model.rewardCoin];
    NSRange yellowRange = [label.attributedText.string rangeOfString:yellowString];
    [label addCustomLink:[NSURL URLWithString:yellowString] inRange:yellowRange color:[CommonFuction colorFromHexRGB:@"F7C520"]];
}

- (void)addAttionNotifyMessage:(AttentionNotifyModel *)attentionNotifyModel
{
    if (attentionNotifyModel)
    {
        UserInfo *info = nil;
        if (attentionNotifyModel.userid != 0 && [attentionNotifyModel.usernick length] > 0)
        {
            UserInfo *userInfo = [[UserInfo alloc] init];
            userInfo.userId = attentionNotifyModel.userid;
            userInfo.nick = attentionNotifyModel.usernick;
            userInfo.hidden = attentionNotifyModel.hidden;
            userInfo.issupermanager = attentionNotifyModel.issupermanager;
            [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
            info = userInfo;
        }
        
        if (attentionNotifyModel.staruserid != 0 && [attentionNotifyModel.starnick length] > 0)
        {
            UserInfo *userInfo = [[UserInfo alloc] init];
            userInfo.userId = attentionNotifyModel.staruserid;
            userInfo.nick = attentionNotifyModel.starnick;
            [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
            info = userInfo;
        }
        NSString *chatMessage = [NSString stringWithFormat:@"{%ld}关注了{%ld}",(long)attentionNotifyModel.userid,(long)attentionNotifyModel.staruserid];
        [self creatLabelWithChatMessage:chatMessage userInfo:info];
    }
}

- (void)addMessage:(NSString *)message
{
    if (message && [message length])
    {
        [self creatLabelWithChatMessage:message userInfo:nil];
    }
    
}

- (BOOL)IsScrollToBottom
{
    CGPoint contentOffsetPoint = self.tableView.contentOffset;
    CGRect frame = self.tableView.frame;
    EWPLog(@"tableView.scroolVIew.contentSize.height = %f",self.tableView.contentSize.height);
    
    if (contentOffsetPoint.y <= _tableView.contentSize.height - frame.size.height || _tableView.contentSize.height < frame.size.height)
    {
        return YES;
    }
    else if (contentOffsetPoint.y == 0 && _tableView.contentSize.height > frame.size.height)
    {
        return YES;
    }
    return NO;
    //    if (self.tableView.contentSize.height - frame.size.height - contentOffsetPoint.y > frame.size.height/2)
    //    {
    //        if (contentOffsetPoint.y == 0)
    //        {
    //            return YES;
    //        }
    //        return NO;
    //    }
    //    return YES;
}

- (void)addMessageLabel:(OHAttributedLabel *)messageLabel
{
    if (messageLabel == nil)
    {
        return;
    }
    
    [_messageLableMArray addObject:messageLabel];
    
}


- (OHAttributedLabel *)creatLabelWithChatMessage:(NSString *)chatMessage userInfo:(UserInfo *)userInfo;
{
    return [self creatLabelWithChatMessage:chatMessage userInfo:userInfo isEnter:YES];
    
}

- (OHAttributedLabel *)creatLabelWithChatMessage:(NSString *)chatMessage userInfo:(UserInfo *)userInfo isEnter:(BOOL)isEnter;
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ShowBarAndChat object:nil];
    [_lock lock];
    OHAttributedLabel *messageLabel = [self createMessageLabelWithMessage:chatMessage isEnter:isEnter];
    messageLabel.isEnter = isEnter;
    messageLabel.info = userInfo;
    [_chatmessageBufferMArray addObject:messageLabel];
    //    [self createHeadImageWithMessage:chatMessage];
    [_lock unlock];
    
    return messageLabel;
}

//根据用户id取得用户名(返回复文本对象)
- (OHAttributedLabel *)createMessageLabelWithMessage:(NSString *)message isEnter:(BOOL)isEnter
{
    
    OHAttributedLabel *messageLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
    messageLabel.backgroundColor = [UIColor clearColor];
    //    messageLabel.linkColor = [CommonFuction colorFromHexRGB:@"00c1b9"];
    messageLabel.linkColor = [UIColor redColor];//[CommonFuction colorFromHexRGB:@"f7c250"];
    messageLabel.font = [UIFont systemFontOfSize:13.0f];
    
    //处理用户名
    NSMutableArray *outParam = [NSMutableArray array];
    
    NSString *text = message;
    _userArray = [CustomMethod addObjectArr:text beginFlage:@"{" endFlag:@"}"];
    if (_userArray && [_userArray count])
    {
        NSDictionary *chatMemberDic = [[UserInfoManager shareUserInfoManager] allUserIdAndNick];
        for (NSString *flagUserId in _userArray)
        {
            NSString *userId = [[NSString alloc] initWithString:[flagUserId substringWithRange:NSMakeRange(1, [flagUserId length] - 2)]];
            NSString *nick = [chatMemberDic objectForKey:[NSNumber numberWithInteger:[userId integerValue]]];
            nick = [NSString stringWithFormat:@"@%@",nick];
            if (nick)
            {
                NSRange soureRange = [text rangeOfString:flagUserId];
                text =  [text stringByReplacingCharactersInRange:NSMakeRange(soureRange.location, soureRange.length) withString:nick];
                
                NSInteger nickLength = [nick length];
                NSRange desRange = NSMakeRange(soureRange.location, nickLength);
         
                NSMutableDictionary *userInfoDic = [NSMutableDictionary dictionary];
                [userInfoDic setObject:userId forKey:@"userid"];
                [userInfoDic setObject:NSStringFromRange(desRange) forKey:@"range"];
                [outParam addObject:userInfoDic];
            }
            
        }
    }
    
    
    //处理表情,现在表情都是从网络获取，缓冲到本地。
    NSArray *emotionArray = [CustomMethod addObjectArr:text beginFlage:@"[" endFlag:@"]"];
    if (emotionArray && [emotionArray count])
    {
        for (NSString *flagEmotion in emotionArray)
        {
            NSString *emotion = [[NSString alloc] initWithString:[flagEmotion substringWithRange:NSMakeRange(1, [flagEmotion length] - 2)]];
            EmotionData *emotionData = [[[EmotionManager shareInstance] allEmotion] objectForKey:emotion];
            if (emotionData)
            {
                NSRange emotionRange = [text rangeOfString:flagEmotion];
                NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,emotionData.mlink];
                NSString *imageHtml = [NSString stringWithFormat:@"<img src='%@' width='%.1f' height='%.1f'>",url,emotionData.width,emotionData.height];
                text = [text stringByReplacingCharactersInRange:NSMakeRange(emotionRange.location, [flagEmotion length]) withString:imageHtml];
            }
        }
    }
    
    //处理其他图片，可以根据需求之地鞥大小
    text = [CustomMethod transformStringToWebImage:text imgSize:CGSizeZero];
    text = [NSString stringWithFormat:@"<font color='#7a7a7a' strokeColor='##7a7a7a' face='Palatino-Roman'>%@",text];
    
    NSRange rang = [text rangeOfString:@"'>"];
    NSString * str1 =[text substringFromIndex:rang.location+2] ;
    NSString* str2 = [text substringToIndex:rang.location+2];//'>以前的
    NSRange rang_img = [str1  rangeOfString:@"<img"];
    NSString* str3 = nil;
    if (rang_img.location != NSNotFound) {
        
        str3 = [str1 substringFromIndex:rang_img.location];//<img以后的，图标
        
        str1 = [str1 substringToIndex:rang_img.location];
    }
    str1 =[str1 stringByReplacingOccurrencesOfString:@"<" withString:@"&lt"];//'>与<img之间位置也就是昵称,
    str1 =[str1 stringByReplacingOccurrencesOfString:@">" withString:@"&gt"];//'>与<img之间位置也就是昵称,
    //     str1 =[str1 stringByReplacingOccurrencesOfString:@"^" withString:@"$!,"];//'>与<img之间位置也就是昵称,
    if (str3== nil) {//如果有图标
        text = [NSString stringWithFormat:@"%@%@",str2,str1];
    }else{
        text = [NSString stringWithFormat:@"%@%@%@",str2,str1,str3];
    }
    MarkupParser *wk_markupParser = [[MarkupParser alloc] init];
    NSMutableAttributedString* attString = [wk_markupParser attrStringFromMarkup:text];
    
    
    //    if ([attString.string rangeOfString:@",~,"].location != NSNotFound) {//把原来的“<”替换过来
    //        attString   = [[NSMutableAttributedString alloc]initWithString:[attString.string stringByReplacingOccurrencesOfString:@",~," withString:@"<"]];
    //    }
    //    if ([attString.string rangeOfString:@"!~!"].location != NSNotFound) {//把原来的“<”替换过来
    //        attString   = [[NSMutableAttributedString alloc]initWithString:[attString.string stringByReplacingOccurrencesOfString:@",~," withString:@"<"]];
    //    }
    //    if ([attString.string rangeOfString:@"$!,"].location != NSNotFound) {//把原来的“<”替换过来
    //        attString   = [[NSMutableAttributedString alloc]initWithString:[attString.string stringByReplacingOccurrencesOfString:@",~," withString:@"^"]];
    //    }
    
    CGFloat fontSize = 14;
    if (isEnter)
    {
        fontSize = 12;
    }
    [attString setFont:[UIFont systemFontOfSize:fontSize]];
    [messageLabel setBackgroundColor:[UIColor clearColor]];
    //设置行间距
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:1];
    [attString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attString length])];
    
    [messageLabel setAttString:attString withImages:wk_markupParser.images];
    
    //增加链接
    if ([outParam count])
    {
        for (NSDictionary *userInfo in outParam)
        {
            NSString *strRange = [userInfo objectForKey:@"range"];
            NSRange range = NSRangeFromString(strRange);
            NSString *userId = [userInfo objectForKey:@"userid"];
            [messageLabel addCustomLink:[NSURL URLWithString:userId] inRange:range];
        }
    }
    
    CGFloat headWidth = HeadImageWidth;
    if (isEnter)
    {
        headWidth = 0;
    }
    
    messageLabel.delegate = self;
    CGRect labelRect = messageLabel.frame;
    labelRect.size = [messageLabel sizeThatFits:CGSizeMake(self.tableView.frame.size.width - headWidth - LabelMarginWidth, CGFLOAT_MAX)];
//    labelRect.size.height = [messageLabel sizeThatFits:CGSizeMake(self.tableView.frame.size.width - headWidth, CGFLOAT_MAX)].height;
    messageLabel.frame = labelRect;
    messageLabel.underlineLinks = NO;//链接是否带下划线
    [messageLabel.layer display];
    return messageLabel;
}

#pragma mark - OHAttributedLabelDelegate

- (BOOL)attributedLabel:(OHAttributedLabel *)attributedLabel shouldFollowLink:(NSTextCheckingResult *)linkInfo
{
    NSString *requestString = [linkInfo.URL absoluteString];
    EWPLog(@"%@",requestString);
    if ([CommonFuction isNumText:requestString])
    {
        NSInteger userId = [requestString intValue];
        UserInfo *userInfo = [[[UserInfoManager shareUserInfoManager] allMemberInfo] objectForKey:[NSNumber numberWithInteger:userId]];
        if (userInfo)
        {
            if (self.popupMenudelegate && [self.popupMenudelegate respondsToSelector:@selector(showPopupMenu:)])
            {
                [self.popupMenudelegate showPopupMenu:userInfo];
            }
        }
        return NO;
    }
    else if([requestString hasPrefix:@"http:"])
    {
        return YES;
    }
    
    return NO;
}

- (UIColor*)attributedLabel:(OHAttributedLabel *)label colorForLink:(NSTextCheckingResult *)linkInfo underlineStyle:(int32_t *)underlineStyle
{
    NSString *linkStr = [linkInfo.URL absoluteString];
    EWPLog(@"%@",linkStr);
    UIColor *linkColor;
    if (label.isEnter)
    {
        linkColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    }
    else
    {
        //        linkColor = [CommonFuction colorFromHexRGB:@"00c1b9"];
        linkColor = [CommonFuction colorFromHexRGB:@"a4a4a4"];
    }
    return linkColor;
}

//根据用户id取得用户头像(返回复头像图象)
//- (UIImage *)createHeadImageWithMessage:(NSString *)message
//{
//    UIImage *headImage;
//    //处理用户名
//    NSString *text = message;
//    _userArray = [CustomMethod addObjectArr:text beginFlage:@"{" endFlag:@"}"];
//    if (_userArray && [_userArray count])
//    {
//        for (NSString *flagUserId in _userArray)
//        {
//            NSDictionary *chatMemberInfoDic = [[UserInfoManager shareUserInfoManager] allMemberInfo];
//            NSString *string = [[chatMemberInfoDic objectForKey:flagUserId] photo];
//            if (string.length) {
//                headImage = [UIImage imageNamed:string];
//            }
//            else
//            {
//                headImage = [UIImage imageNamed:@"getProgram"];
//            }
//        }
//    }
//    return headImage;
//}

- (void)setImageView:(UIImageView *)imageView withUserId:(NSInteger)userId indexPath:(NSIndexPath *)indexPath
{
    __block NSDictionary *chatMemberInfoDic = [[UserInfoManager shareUserInfoManager] allMemberInfo];
    NSString *string = [[chatMemberInfoDic objectForKey:[NSString stringWithFormat:@"%ld", userId]] photo];
    if (string)
    {
        string = [[AppInfo shareInstance].resourceBaseUrl stringByAppendingPathComponent:string];
        [imageView sd_setImageWithURL:[NSURL URLWithString:string] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             imageView.image = [self imageWithBackGroundColorForUserId:userId onImage:image];
         }];
    }
    else
    {
        NSDictionary *params = @{@"userid" : @(userId), @"key" : @"photo" };
        [self.rootViewController requestDataWithAnalyseModel:[GetOneFieldModel class] params:params success:^(id object)
         {
             /*成功返回数据*/
             GetOneFieldModel *model = object;
             if (model.imageUrl)
             {
                 UserInfo *info = [chatMemberInfoDic objectForKey:[NSString stringWithFormat:@"%ld", userId]];
                 info.photo = model.imageUrl;
                 [chatMemberInfoDic objectForKey:[NSString stringWithFormat:@"%ld", userId]];
                 NSString *baseString = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,model.imageUrl];
                 
                 [imageView sd_setImageWithURL:[NSURL URLWithString:baseString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                  {
                      imageView.image = [self imageWithBackGroundColorForUserId:userId onImage:image];
                      
                  }];
             }
             else
             {
                 NSLog(@"error!!!");
             }
         }
                                                        fail:^(id object)
         {
             /*失败返回数据*/
             
         }];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger nCount = 0;
    if (_messageLableMArray)
    {
        nCount = [_messageLableMArray count];
    }
    return nCount;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    NSInteger nCount = 0;
    //    if (_messageLableMArray)
    //    {
    //        nCount = [_messageLableMArray count];
    //    }
    //    return nCount;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSInteger hedImageTag = 100;
      static NSInteger labelBgTag = 101;
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        UIImageView *headImgeView = [[UIImageView alloc]init];
        headImgeView.frame = CGRectMake(0, 5, 40, 0);
        headImgeView.tag = 100;
        headImgeView.backgroundColor = [UIColor clearColor];
        headImgeView.contentMode = UIViewContentModeScaleAspectFill;
        headImgeView.clipsToBounds = YES;
//        [cell.contentView addSubview:headImgeView];
        
        
        UIView *labelBg = [[UIView alloc] init];
        labelBg.tag = labelBgTag;
        
        [cell.contentView addSubview:headImgeView];
        [cell.contentView addSubview:labelBg];
    }
    OHAttributedLabel *label = (OHAttributedLabel *)[cell.contentView viewWithTag:100000];
    if (label)
    {
        [label removeFromSuperview];
    }
    //view内添加上label视图
    label = [self.messageLableMArray objectAtIndex:indexPath.row];
    label.tag = 100000;
    if (label.isEnter)
    {
        label.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    }
    else
    {
        label.textColor = [CommonFuction colorFromHexRGB:@"424242"];
    }
    
    [label setCenter:cell.contentView.center];
    label.frame = CGRectMake(LabelMarginWidth / 2, VerticalSpace / 2, label.frame.size.width, label.frame.size.height);
    [CustomMethod drawImage:label isAlpha:label.isEnter];
    [cell.contentView addSubview:label];
    
    UIView *labelBg = [cell.contentView viewWithTag:labelBgTag];
    labelBg.frame = CGRectMake(0, 0, label.frame.size.width + LabelMarginWidth,  label.frame.size.height + VerticalSpace);
    [labelBg addSubview:label];
    

    UIImageView *headImgeView = (UIImageView *)[cell.contentView viewWithTag:hedImageTag];
    
    //    UIImage *image = [UIImage imageNamed:@"getProgram"];
    //    [headImgeView setImage:[self setImgBackGroundColorWithIndexPath:indexPath.row onImage:image]];
    
    //    headImgeView.tag = hedImageTag;
    if (label.isEnter)
    {
        labelBg.frame = CGRectMake( 0, VerticalSpace / 2, labelBg.frame.size.width, labelBg.frame.size.height);
        labelBg.backgroundColor = [UIColor colorWithWhite:0  alpha:0.15];
        headImgeView.hidden = YES;
        
    }
    else
    {
        headImgeView.hidden = NO;
         labelBg.backgroundColor = [UIColor whiteColor];
        labelBg.frame = CGRectMake(HeadImageWidth, 5, labelBg.frame.size.width, labelBg.frame.size.height);
        headImgeView.frame = CGRectMake(0, 5, HeadImageWidth, label.frame.size.height + VerticalSpace);
        NSString *baseString = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,label.info.photo];
        [headImgeView sd_setImageWithURL:[NSURL URLWithString:baseString] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!image) {
                headImgeView.image = [self imageWithBackGroundColorForUserId:label.info.userId onImage:[UIImage imageNamed:@"default_photo.png"]];
            }else{
                headImgeView.image = [self imageWithBackGroundColorForUserId:label.info.userId onImage:image];
            };
        }];
        //        [self setImageView:headImgeView withUserId:label.info.userId indexPath:indexPath];
    }
    
    return cell;
    
}

-(UIImage *)imageWithBackGroundColorForUserId:(NSInteger)userId onImage:(UIImage *)image
{
    if (!image)
    {
        return nil;
    }
    UIImage *colorImage;
    NSInteger i = userId % 4;
    switch (i) {
        case 0:
            colorImage = [image rt_tintedImageWithColor:[CommonFuction colorFromHexRGB:@"37ef74"] level:.5f];
            break;
        case 1:
            colorImage = [image rt_tintedImageWithColor:[CommonFuction colorFromHexRGB:@"ff6666"] level:.5f];
            break;
        case 2:
            colorImage = [image rt_tintedImageWithColor:[CommonFuction colorFromHexRGB:@"12a1ff"] level:.5f];
            break;
        case 3:
            colorImage = [image rt_tintedImageWithColor:[CommonFuction colorFromHexRGB:@"f7c250"] level:.5f];
            break;
        default:
            break;
    }
    
    return colorImage;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 18.0;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 18.0;
//}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 40;
    OHAttributedLabel *label = [self.messageLableMArray objectAtIndex:indexPath.row];
    if (label)    {
        height = label.frame.size.height;
        height += VerticalSpace * 2;;
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)layoutSubviews
{
    self.tableView.frame = CGRectMake(10, 9, self.frame.size.width - 10, self.frame.size.height - 10 - 9);
    if (_giftRankBtn)
    {
        _giftRankBtn.frame = CGRectMake(self.frame.size.width - 10 - 40, 5, 40, 65);
    }
    
}

- (void)getChatMessage
{
    BOOL update = NO;
    [_lock lock];
    if (_chatmessageBufferMArray.count > 0)
    {
        update = YES;
        [_messageLableMArray addObjectsFromArray:_chatmessageBufferMArray];
        [_chatmessageBufferMArray removeAllObjects];
        
        if (_messageLableMArray.count > 200)
        {
            [_messageLableMArray removeObjectsInRange:NSMakeRange(0, _messageLableMArray.count - 50)];
        }
        
        
    }
    [_lock unlock];
    
    if (update)
    {
        [self.tableView reloadData];
        if ([self IsScrollToBottom])
        {
            if (_messageLableMArray.count)
            {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[_messageLableMArray count] - 1 inSection:0]
                                      atScrollPosition: UITableViewScrollPositionBottom
                                              animated:YES];
            }
            
            
        }
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ShowBarAndChat object:nil];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
