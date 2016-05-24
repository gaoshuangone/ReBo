//
//  PublicView.m
//  BoXiu
//
//  Created by Andy on 14-3-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "PublicView.h"
#import "ChatRoomViewController.h"
#import "AppDelegate.h"
#import "ChatMessageModel.h"
#import "UIPopoverListView.h"
#import "ExpressionManager.h"
#import "UserInfoManager.h"
#import "UIImageView+WebCache.h"
#import "AppInfo.h"
#import "RightMenuCell.h"
#import "EmotionManager.h"
#import "StarRoomGiftRank.h"
#import "StarGiftRankModel.h"
#import "GiftDataManager.h"
#import "UserInfo.h"

@interface PublicView ()
@property (nonatomic,strong) NSMutableArray *messageLableMArray;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIButton *giftRankBtn;
@property (nonatomic,strong) StarRoomGiftRank *starGiftRank;

@property (nonatomic,strong) NSMutableArray *starGiftRankMArray;

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSLock *lock;
@property (nonatomic,strong) NSMutableArray *chatmessageBufferMArray;

@end

@implementation PublicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

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
    _messageLableMArray = [NSMutableArray array];
    
    _chatmessageBufferMArray = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
    if (chatMessageModel.userid != 0 && [chatMessageModel.nick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = chatMessageModel.userid;
        userInfo.nick = chatMessageModel.nick;
        userInfo.hidden = chatMessageModel.hidden;
        userInfo.hiddenindex = chatMessageModel.hiddenindex;
        userInfo.issupermanager = chatMessageModel.issupermanager;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }
    
    if (chatMessageModel.targetUserid != 0 && [chatMessageModel.targetNick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = chatMessageModel.targetUserid;
        userInfo.nick = chatMessageModel.targetNick;
        userInfo.hidden = chatMessageModel.thidden;
        userInfo.hiddenindex = chatMessageModel.thiddenindex;
        userInfo.issupermanager = chatMessageModel.tissupermanager;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }
    
    NSString *headString = nil;
    if (chatMessageModel.targetUserid == 0)
    {
        headString =[NSString stringWithFormat:@"{%ld}说: ",(long)chatMessageModel.userid];
    }
    else
    {
        headString = [NSString stringWithFormat:@"{%ld}对{%ld}说: ",(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
    }
    NSString *chatMessage = [NSString stringWithFormat:@"%@%@",headString,chatMessageModel.msg];

    [self creatLabelWithChatMessage:chatMessage];
}

- (void)addSofaInfoToChatMessage:(RobSofaModel *)sofaModel
{
    if (sofaModel.userid != 0 && [sofaModel.nick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = sofaModel.userid;
        userInfo.nick = sofaModel.nick;
        userInfo.hidden = sofaModel.hidden;
        userInfo.hiddenindex = sofaModel.hiddenindex;
        userInfo.issupermanager = sofaModel.issupermanager;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }
    
    NSString *chatMessage = [NSString stringWithFormat:@"{%ld}用%ld个沙发抢得一个贵宾席位",(long)sofaModel.userid,(long)sofaModel.num];
    [self creatLabelWithChatMessage:chatMessage];
}

- (void)addRoomMessage:(NotifyMessageModel *)notifyMessageModel
{
    if (notifyMessageModel.fromuserid != 0 && [notifyMessageModel.fromusernick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = notifyMessageModel.fromuserid;
        userInfo.nick = notifyMessageModel.fromusernick;
        userInfo.hidden = notifyMessageModel.hidden;
        userInfo.hiddenindex = notifyMessageModel.hiddenindex;
        userInfo.issupermanager = notifyMessageModel.issupermanager;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
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
    }
    
    NSString *chatMessage = notifyMessageModel.msg;
    [self creatLabelWithChatMessage:chatMessage];
}

- (void)addGlobalMessage:(GlobalMessageModel *)globalMessageModel
{
    if (globalMessageModel && globalMessageModel.msg)
    {
        [self creatLabelWithChatMessage:globalMessageModel.msg];
    }
}

- (void)addGiftInfoToChatMessage:(GiveGiftModel *)giveGiftModel
{
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
    }
    
    NSString *headString = nil;
    if (giveGiftModel.useridto != 0 && giveGiftModel.useridfrom != 0)
    {
        headString = [NSString stringWithFormat:@"{%ld}送给{%ld}",(long)giveGiftModel.useridfrom,(long)giveGiftModel.useridto];
    }
   
    NSString *giftUrl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,giveGiftModel.giftimg];
    NSString *chatMessage = [NSString stringWithFormat:@"%@%ld%@<%@>",headString,(long)giveGiftModel.objectnum,giveGiftModel.giftunit,giftUrl];
    [self creatLabelWithChatMessage:chatMessage];

}

- (void)addApproveMessage:(SendApproveModel *)sendApproveModel
{
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
        }
        
        if (sendApproveModel.staruserid != 0 && [sendApproveModel.starnick length] > 0)
        {
            UserInfo *userInfo = [[UserInfo alloc] init];
            userInfo.userId = sendApproveModel.staruserid;
            userInfo.nick = sendApproveModel.starnick;
            [[UserInfoManager shareUserInfoManager] addGiftMember:userInfo];
        }
        
        NSString *message = nil;

        message = [NSString stringWithFormat:@"{%ld}送给{%ld}1个赞",(long)sendApproveModel.userid,(long)sendApproveModel.staruserid];

        [self creatLabelWithChatMessage:message];

    }
}

- (void)addUserEnterRoomMessage:(UserEnterRoomModel *)userEnterModel
{
    if (userEnterModel.memberData )
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = userEnterModel.memberData.userId;
        userInfo.nick = userEnterModel.memberData.nick;
        userInfo.hidden = userEnterModel.memberData.hidden;
        userInfo.hiddenindex = userEnterModel.memberData.hiddenindex;
        [[UserInfoManager shareUserInfoManager] addChatMember:userInfo];
        
        NSMutableString *message = [NSMutableString string];
        UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        if(userInfo.userId == currentUserInfo.userId)
        {

            [message appendFormat:@"欢迎 {%ld}",(long)userInfo.userId];
            if (userEnterModel.carData)
            {
                [message appendString:@"开着一辆"];
                [message appendFormat:@"%@",userEnterModel.carData.carname];
                NSString *carUrl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,userEnterModel.carData.carimgsmall];
                [message appendFormat:@"<%@>",carUrl];
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
                            [message appendFormat:@"<%@>",carUrl];
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
                        [message appendFormat:@"<%@>",carUrl];
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
                    [message appendFormat:@"<%@>",carUrl];
                }
                [message appendString:@"进入了房间"];
            }
        }
        
        [self creatLabelWithChatMessage:message];
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
        [self creatLabelWithChatMessage:chatMessage];

    }
}


-(void)addGlobalLuckyGiftMessage:(GlobaMessageLuckyModel *)globaLuckyModel
{
    if (globaLuckyModel.userid != 0 && [globaLuckyModel.usernick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = globaLuckyModel.userid;
        userInfo.nick = globaLuckyModel.usernick;
        userInfo.hidden = globaLuckyModel.hidden;
        userInfo.hiddenindex = globaLuckyModel.hiddenindex;
        userInfo.issupermanager = globaLuckyModel.issupermanager;
        [[UserInfoManager shareUserInfoManager] addChatMember:userInfo];
    }

    NSString *headString = nil;
    
    if (globaLuckyModel.userid != 0 && globaLuckyModel.rewardtype == 2)
    {
        headString = [NSString stringWithFormat:@"恭喜{%ld}获得幸运礼物大奖 %ld 倍 %@ 奖励，奖金 %ld 热币，小伙伴们快去试试手气吧。",(long)globaLuckyModel.userid,(long)globaLuckyModel.rewardbs,globaLuckyModel.giftname,(long)globaLuckyModel.rewardCoin];
    }
    else
    {
        headString = [NSString stringWithFormat:@"恭喜{%ld}获得幸运礼物大奖 %@ 奖励，奖金 %ld 热币，小伙伴们快去试试手气吧。",(long)globaLuckyModel.userid,globaLuckyModel.giftname,(long)globaLuckyModel.rewardCoin];
    }
    
    [self creatLabelWithChatMessage:headString];

}

- (void)addAttionNotifyMessage:(AttentionNotifyModel *)attentionNotifyModel
{
    if (attentionNotifyModel)
    {
        if (attentionNotifyModel.userid != 0 && [attentionNotifyModel.usernick length] > 0)
        {
            UserInfo *userInfo = [[UserInfo alloc] init];
            userInfo.userId = attentionNotifyModel.userid;
            userInfo.nick = attentionNotifyModel.usernick;
            userInfo.hidden = attentionNotifyModel.hidden;
            userInfo.issupermanager = attentionNotifyModel.issupermanager;
            [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
        }

        if (attentionNotifyModel.staruserid != 0 && [attentionNotifyModel.starnick length] > 0)
        {
            UserInfo *userInfo = [[UserInfo alloc] init];
            userInfo.userId = attentionNotifyModel.staruserid;
            userInfo.nick = attentionNotifyModel.starnick;
            [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
        }
        NSString *chatMessage = [NSString stringWithFormat:@"{%ld}关注了{%ld}",(long)attentionNotifyModel.userid,(long)attentionNotifyModel.staruserid];
        [self creatLabelWithChatMessage:chatMessage];
    }
}

- (void)addMessage:(NSString *)message
{
    if (message && [message length])
    {
        [self creatLabelWithChatMessage:message];
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


- (void)creatLabelWithChatMessage:(NSString *)chatMessage
{
    [_lock lock];
    OHAttributedLabel *messageLabel = [self createMessageLabelWithMessage:chatMessage];
    [_chatmessageBufferMArray addObject:messageLabel];
    [_lock unlock];
   
}

- (OHAttributedLabel *)createMessageLabelWithMessage:(NSString *)message
{
    OHAttributedLabel *messageLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.linkColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    messageLabel.font = [UIFont systemFontOfSize:14.0f];
    
    //处理用户名
    NSMutableArray *outParam = [NSMutableArray array];
    NSString *text = message;
    NSArray *userArray = [CustomMethod addObjectArr:text beginFlage:@"{" endFlag:@"}"];
    if (userArray && [userArray count])
    {
        NSDictionary *chatMemberDic = [[UserInfoManager shareUserInfoManager] allUserIdAndNick];
        for (NSString *flagUserId in userArray)
        {
            NSString *userId = [[NSString alloc] initWithString:[flagUserId substringWithRange:NSMakeRange(1, [flagUserId length] - 2)]];
            NSString *nick = [chatMemberDic objectForKey:[NSNumber numberWithInteger:[userId integerValue]]];
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
    
    MarkupParser *wk_markupParser = [[MarkupParser alloc] init];
    NSMutableAttributedString* attString = [wk_markupParser attrStringFromMarkup: text];
    [attString setFont:[UIFont systemFontOfSize:14]];
    [messageLabel setBackgroundColor:[UIColor clearColor]];
    //设置行间距
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
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
    
    messageLabel.delegate = self;
    CGRect labelRect = messageLabel.frame;
    labelRect.size.width = [messageLabel sizeThatFits:CGSizeMake(self.tableView.frame.size.width, CGFLOAT_MAX)].width;
    labelRect.size.height = [messageLabel sizeThatFits:CGSizeMake(self.tableView.frame.size.width, CGFLOAT_MAX)].height;
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

- (UIColor*)colorForLink:(NSTextCheckingResult*)linkInfo underlineStyle:(int32_t*)underlineStyle
{
    NSString *linkStr = [linkInfo.URL absoluteString];
    EWPLog(@"%@",linkStr);
    UIColor *linkColor;
    if (linkStr == nil)
    {
        linkColor = [CommonFuction colorFromHexRGB:@"575757"];;
    }
    else
    {
        linkColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    }
    return linkColor;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    OHAttributedLabel *label = (OHAttributedLabel *)[cell.contentView viewWithTag:11];
    if (label)
    {
        [label removeFromSuperview];
    }
    //view内添加上label视图
    label = [self.messageLableMArray objectAtIndex:indexPath.row];
    label.tag = 11;
    label.textColor = [CommonFuction colorFromHexRGB:@"7a7a7a"];
    [label setCenter:cell.contentView.center];
    label.frame = CGRectMake(0, 5, label.frame.size.width, label.frame.size.height);
     [CustomMethod drawImage:label];
    UIImageView *hLineImgeView = (UIImageView *)[cell viewWithTag:22];;
    if (hLineImgeView)
    {
        [hLineImgeView removeFromSuperview];
    }
    hLineImgeView = [[UIImageView alloc] init];
    hLineImgeView.frame = CGRectMake(0, label.frame.size.height + 9.5, self.frame.size.width, 0.5);
    hLineImgeView.tag = 22;
    hLineImgeView.backgroundColor = [CommonFuction colorFromHexRGB:@"dfdfdf"];
    [cell.contentView addSubview:hLineImgeView];
    [cell.contentView addSubview:label];
    
    return cell;

}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 40;
    OHAttributedLabel *label = [self.messageLableMArray objectAtIndex:indexPath.row];
    if (label)
    {
        height = label.frame.size.height;
        height += 10;
    }

    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)layoutSubviews
{
    self.tableView.frame = CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 10);
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

@end
