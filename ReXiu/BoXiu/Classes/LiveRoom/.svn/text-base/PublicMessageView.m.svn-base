//
//  PublicMessageView.m
//  BoXiu
//
//  Created by andy on 15/6/17.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "PublicMessageView.h"
#import "StarRoomGiftRank.h"
#import "UIImage+RTTint.h"
#import "UIImageView+WebCache.h"
#import "GetOneFieldModel.h"
#import "UIView+Tools.h"
#import "LiveRoomViewController.h"


#define HeadImageWidth         36.0f
#define LabelMarginWidth       10.0f
#define VerticalSpace          7.0f


@interface PublicMessageView ()

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
@property (nonatomic,strong) NSString* href;
@property (nonatomic,assign) NSInteger hrefnumber;
@end

@implementation PublicMessageView

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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:_tableView];
    
    
    
    
    _lock = [[NSLock alloc] init];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.08 target:self selector:@selector(getChatMessage) userInfo:nil repeats:YES];
    
    
}

#pragma mark 获取直播间礼物排行
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
        userInfo.nick = [NSString stringWithFormat:@"%@:",chatMessageModel.nick];
        userInfo.hidden = chatMessageModel.hidden;
        userInfo.hiddenindex = chatMessageModel.hiddenindex;
        userInfo.issupermanager = chatMessageModel.issupermanager;
        userInfo.photo = chatMessageModel.photo;
        userInfo.isPurpleVip = chatMessageModel.isPurpleVip;
        userInfo.isYellowVip = chatMessageModel.isYellowVip;
        userInfo.userStarlevelid = chatMessageModel.starlevelid;
        userInfo.consumerlevelweight = [UserInfo switchConsumerlevelweight:chatMessageModel.consumerlevelweight];
        
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
        userInfo.isPurpleVip = chatMessageModel.isPurpleVip;
        userInfo.isYellowVip = chatMessageModel.isYellowVip;
        userInfo.userStarlevelid = chatMessageModel.starlevelid;
        userInfo.consumerlevelweight = [UserInfo switchConsumerlevelweight:chatMessageModel.consumerlevelweight];
        
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }

    NSString *headString = nil;
    if (chatMessageModel.targetUserid == 0)
    {
        EWPLog(@"%ld",[UserInfoManager shareUserInfoManager].currentStarInfo.userId);

//        如果是主播发言
        if ([UserInfoManager shareUserInfoManager].currentStarInfo.userId == chatMessageModel.userid) {
            if ([UserInfoManager shareUserInfoManager].currentStarInfo.starlevelid >1) {
                NSString *levelimg;
                if ([UserInfoManager shareUserInfoManager].currentStarInfo.starlevelid <10) {
                    levelimg = [NSString stringWithFormat:@"{star00%ld]",[UserInfoManager shareUserInfoManager].currentStarInfo.starlevelid];
                }else if([UserInfoManager shareUserInfoManager].currentStarInfo.starlevelid >=20){
                    levelimg = [NSString stringWithFormat:@"{star020]"];
                }else{
                    levelimg = [NSString stringWithFormat:@"{star0%ld]",[UserInfoManager shareUserInfoManager].currentStarInfo.starlevelid];
                }
                
                if(chatMessageModel.isYellowVip || chatMessageModel.isPurpleVip)
                {
                    if(chatMessageModel.isPurpleVip)
                    {
                        headString =[NSString stringWithFormat:@"{pvip] %@ {%ld}  ",levelimg,(long)chatMessageModel.userid];
                        
                    }else if(chatMessageModel.isYellowVip){
                        headString =[NSString stringWithFormat:@"{yvip] %@ {%ld}  ",levelimg,(long)chatMessageModel.userid];
                    }
                }
                else{
                    headString =[NSString stringWithFormat:@"%@ {%ld}  ",levelimg,(long)chatMessageModel.userid];
                }
            }else{
                if(chatMessageModel.isYellowVip || chatMessageModel.isPurpleVip)
                {
                    if(chatMessageModel.isPurpleVip)
                    {
                        headString =[NSString stringWithFormat:@"{pvip] {%ld}  ",(long)chatMessageModel.userid];
                    }else if(chatMessageModel.isYellowVip){
                        headString =[NSString stringWithFormat:@"{yvip] {%ld}  ",(long)chatMessageModel.userid];
                    }
                }else{
                    headString =[NSString stringWithFormat:@"{%ld}  ",(long)chatMessageModel.userid];
                }
            }
        }else{
//        如果是用户发言
        
            if ([UserInfo switchConsumerlevelweight:chatMessageModel.consumerlevelweight] > 1) {
//                拼接用户等级
                NSString *levelweightImg;
                if ([UserInfo switchConsumerlevelweight:chatMessageModel.consumerlevelweight] <10) {
                    levelweightImg = [NSString stringWithFormat:@"{V%ld]",[UserInfo switchConsumerlevelweight:chatMessageModel.consumerlevelweight]];
                }else if([UserInfo switchConsumerlevelweight:chatMessageModel.consumerlevelweight] >=24){
                    levelweightImg = [NSString stringWithFormat:@"{V24]"];
                }else{
                    levelweightImg = [NSString stringWithFormat:@"{V%ld]",[UserInfo switchConsumerlevelweight:chatMessageModel.consumerlevelweight]];
                }
                
                if(chatMessageModel.isYellowVip || chatMessageModel.isPurpleVip)
                {
                    if(chatMessageModel.isPurpleVip)
                    {
                        headString =[NSString stringWithFormat:@"{pvip] %@ {%ld}  ",levelweightImg,(long)chatMessageModel.userid];
                    }else if(chatMessageModel.isYellowVip){
                        headString =[NSString stringWithFormat:@"{yvip] %@ {%ld}  ",levelweightImg,(long)chatMessageModel.userid];
                    }
                }
                else
                {
                    headString =[NSString stringWithFormat:@"%@ {%ld}  ",levelweightImg,(long)chatMessageModel.userid];
                }
                
            }else{
                if (chatMessageModel.isYellowVip || chatMessageModel.isPurpleVip) {
                    if(chatMessageModel.isPurpleVip)
                    {
                        headString =[NSString stringWithFormat:@"{pvip] {%ld}  ",(long)chatMessageModel.userid];
                    }else if(chatMessageModel.isYellowVip){
                        headString =[NSString stringWithFormat:@"{yvip] {%ld}  ",(long)chatMessageModel.userid];
                    }
                }else{
                    headString =[NSString stringWithFormat:@"{%ld}  ",(long)chatMessageModel.userid];
                }
            }
            
        }
        
    }
    else
    {
        //   对某个人发言     如果是主播发言
        if ([UserInfoManager shareUserInfoManager].currentStarInfo.userId == chatMessageModel.userid) {
            if ([UserInfo switchConsumerlevelweight:chatMessageModel.consumerlevelweight] >1) {
                NSString *levelimg;
                if ([UserInfo switchConsumerlevelweight:chatMessageModel.consumerlevelweight] <10) {
                    levelimg = [NSString stringWithFormat:@"{star00%ld]",[UserInfo switchConsumerlevelweight:chatMessageModel.consumerlevelweight]];
                }else if([UserInfoManager shareUserInfoManager].currentStarInfo.starlevelid >=20){
                    levelimg = [NSString stringWithFormat:@"{star020]"];
                }else{
                    levelimg = [NSString stringWithFormat:@"{star0%ld]",[UserInfo switchConsumerlevelweight:chatMessageModel.consumerlevelweight]];
                }
                
                if(chatMessageModel.isYellowVip || chatMessageModel.isPurpleVip)
                {
                    if(chatMessageModel.isPurpleVip)
                    {
                        headString =[NSString stringWithFormat:@"{pvip] %@ {%ld} {%ld}",levelimg,(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
                        
                    }else if(chatMessageModel.isYellowVip){
                        headString =[NSString stringWithFormat:@"{yvip] %@ {%ld} {%ld}",levelimg,(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
                    }
                }
                else{
                    headString =[NSString stringWithFormat:@"%@ {%ld} {%ld}",levelimg,(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
                }
            }else{
                if(chatMessageModel.isYellowVip || chatMessageModel.isPurpleVip)
                {
                    if(chatMessageModel.isPurpleVip)
                    {
                        headString =[NSString stringWithFormat:@"{pvip] {%ld} {%ld}",(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
                    }else if(chatMessageModel.isYellowVip){
                        headString =[NSString stringWithFormat:@"{yvip] {%ld} {%ld}",(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
                    }
                }else{
                    headString =[NSString stringWithFormat:@"{%ld} {%ld}",(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
                }
            }
        }else{
            //        如果是用户发言
            
            if ([UserInfo switchConsumerlevelweight:chatMessageModel.consumerlevelweight] > 1) {
                //                拼接用户等级
                NSString *levelweightImg;
                if ([UserInfo switchConsumerlevelweight:chatMessageModel.consumerlevelweight] <10) {
                    levelweightImg = [NSString stringWithFormat:@"{V%ld]",[UserInfo switchConsumerlevelweight:chatMessageModel.consumerlevelweight]];
                }else if([UserInfo switchConsumerlevelweight:chatMessageModel.consumerlevelweight] >=24){
                    levelweightImg = [NSString stringWithFormat:@"{V24]"];
                }else{
                    levelweightImg = [NSString stringWithFormat:@"{V%ld]",[UserInfo switchConsumerlevelweight:chatMessageModel.consumerlevelweight]];
                }
                
                if(chatMessageModel.isYellowVip || chatMessageModel.isPurpleVip)
                {
                    if(chatMessageModel.isPurpleVip)
                    {
                        headString =[NSString stringWithFormat:@"{pvip] %@ {%ld} {%ld} ",levelweightImg,(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
                    }else if(chatMessageModel.isYellowVip){
                        headString =[NSString stringWithFormat:@"{yvip] %@ {%ld} {%ld} ",levelweightImg,(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
                    }
                }
                else
                {
                    headString =[NSString stringWithFormat:@"%@ {%ld} {%ld} ",levelweightImg,(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
                }
                
            }else{
                if (chatMessageModel.isYellowVip || chatMessageModel.isPurpleVip) {
                    if(chatMessageModel.isPurpleVip)
                    {
                        headString =[NSString stringWithFormat:@"{pvip] {%ld} {%ld} ",(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
                    }else if(chatMessageModel.isYellowVip){
                        headString =[NSString stringWithFormat:@"{yvip] {%ld} {%ld} ",(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
                    }
                }else{
                    headString =[NSString stringWithFormat:@"{%ld} {%ld} ",(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
                }
            }
            
        }
    }
    NSString *chatMessage = [NSString stringWithFormat:@"%@%@",headString,chatMessageModel.msg];
    
    [self creatLabelWithChatMessage:chatMessage userInfo:info isEnter:NO isCtrl:NO];
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
        if (globalMessageModel.chatType == 3) {
            self.href = globalMessageModel.href;
            if ([globalMessageModel.href isEqualToString:@" "] || globalMessageModel.href == nil) {
                self.href = @" ";
                self.hrefnumber
                = 1;
            }else{
                self.hrefnumber = 2;
            }
        }else{
            
        }
        globalMessageModel.msg = [NSString stringWithFormat:@"{lab] %@",globalMessageModel.msg];
        
        [self creatLabelWithChatMessage:globalMessageModel.msg userInfo:nil];
    }
}
#pragma mark 送礼信息
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
        userInfo.stargetcoin = giveGiftModel.stargetcoin;
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
        userInfo.stargetcoin = giveGiftModel.stargetcoin;
        [[UserInfoManager shareUserInfoManager] addChatMember:userInfo];
        info = userInfo;
    }
    if (giveGiftModel.stargetcoin >0) {
        [AppInfo shareInstance].coinbackview.hidden = NO;
    }else{
        [AppInfo shareInstance].coinbackview.hidden = YES;
    }
    [AppInfo shareInstance].coin.text = [NSString stringWithFormat:@"%lld",giveGiftModel.stargetcoin];
    CGSize coinSize = [[AppInfo shareInstance].coin sizeThatFits:CGSizeMake(250, MAXFLOAT)];
    [AppInfo shareInstance].coinbackview.frame = CGRectMake(0, 64, coinSize.width + 71, 25);
    [AppInfo shareInstance].coin.frame = CGRectMake(45, 0, coinSize.width, 25);
    [AppInfo shareInstance].coinImg.frame = CGRectMake(coinSize.width + 51, 4, 16, 16);
    CAShapeLayer *confirmButtonLayer1 = [CAShapeLayer layer];
    UIBezierPath *radiusPath1 = [UIBezierPath bezierPathWithRoundedRect:[AppInfo shareInstance].coinbackview.bounds
                                                      byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)
                                                            cornerRadii:CGSizeMake(12.5f, 12.5f)];
    confirmButtonLayer1.path = radiusPath1.CGPath;
    [AppInfo shareInstance].coinbackview.layer.mask = confirmButtonLayer1;
    NSString *headString = nil;
    if (giveGiftModel.useridto != 0 && giveGiftModel.useridfrom != 0)
    {   //送礼信息，显示样式：@送礼用户昵称+空格+送给+@受理用户昵称+空格+礼物名称x礼物数量+礼物图片
        headString = [NSString stringWithFormat:@"{%ld} 送给 {%ld}",(long)giveGiftModel.useridfrom,(long)giveGiftModel.useridto];
    }
    
    NSString *giftUrl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,giveGiftModel.giftimg];
    NSString *chatMessage = [NSString stringWithFormat:@"%@ %@ x%ld <%@>",headString, giveGiftModel.giftname, (long)giveGiftModel.objectnum,giftUrl];
    OHAttributedLabel *label = [self creatLabelWithChatMessage:chatMessage userInfo:info isEnter:NO isCtrl:NO];
    
    NSString *yellowString = [NSString stringWithFormat:@" x%ld ", (long)giveGiftModel.objectnum];
    NSRange yellowRange = [label.attributedText.string rangeOfString:yellowString];
    [label addCustomLink:[NSURL URLWithString:yellowString] inRange:yellowRange color:[CommonFuction colorFromHexRGB:@"F7C520"]];
}

#pragma mark 送赞
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
        
        [self creatLabelWithChatMessage:message userInfo:info isEnter:NO isCtrl:YES];
        
    }
}
#pragma mark 首次点赞消息
-(void)receiveSendNotice:(NSNotification *)userEnterModel
{
        NSDictionary *bodyDic = [userEnterModel userInfo];
        UserInfo *info = nil;
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.nick = [bodyDic objectForKey:@"nick"];
        userInfo.userId = [[bodyDic objectForKey:@"userid"] longLongValue];
        userInfo.consumerlevelweight =  [UserInfo switchConsumerlevelweight:[[bodyDic objectForKey:@"consumerlevelweight"] integerValue]];
        userInfo.isYellowVip = [[bodyDic objectForKey:@"isYellowVip"] boolValue];
        userInfo.isPurpleVip = [[bodyDic objectForKey:@"isPurpleVip"] boolValue];
    [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    NSInteger number = arc4random() % (4 + 1);
    NSString *randomImageName;
    switch (number) {
        case 1:
            randomImageName = @"{bHeart]";
            break;
        case 2:
            randomImageName = @"{gHeart]";
            break;
        case 3:
            randomImageName = @"{rHeart]";
            break;
        case 4:
            randomImageName = @"{yHeart]";
            break;
        default:
            randomImageName = @"{bHeart]";
            break;
    }

        info = userInfo;
        NSString *message = nil;
        if (userInfo.userId == [UserInfoManager shareUserInfoManager].currentUserInfo.userId || userInfo.userId == [UserInfoManager shareUserInfoManager].currentStarInfo.userId) {
                [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
            }
#pragma mark   考虑  主播和用户两种情况  然后再考虑 有没有VIP 和明星等级两种情况
        if(userInfo.isYellowVip || userInfo.isPurpleVip)
        {//判断是主播的情况
            if ([UserInfoManager shareUserInfoManager].currentStarInfo.userId == userInfo.userId) {
                NSString *levelimg;
//                主播等级大于1
                if ([UserInfoManager shareUserInfoManager].currentStarInfo.starlevelid >1) {
                    if ([UserInfoManager shareUserInfoManager].currentStarInfo.starlevelid <10) {
                        levelimg = [NSString stringWithFormat:@"{star00%ld]",[UserInfoManager shareUserInfoManager].currentStarInfo.starlevelid];
                    }else if([UserInfoManager shareUserInfoManager].currentStarInfo.starlevelid >=20){
                        levelimg = [NSString stringWithFormat:@"{star020]"];
                    }else{
                        levelimg = [NSString stringWithFormat:@"{star0%ld]",[UserInfoManager shareUserInfoManager].currentStarInfo.starlevelid];
                    }
                    if(userInfo.isPurpleVip)
                    {
                        message =[NSString stringWithFormat:@"{pvip] %@ {%ld}: 我点亮了 %@",levelimg,(long)userInfo.userId,randomImageName];
                        
                    }else if(userInfo.isYellowVip){
                        message =[NSString stringWithFormat:@"{yvip] %@ {%ld}: 我点亮了 %@",levelimg,(long)userInfo.userId,randomImageName];
                    }
                }else{
                    if(userInfo.isPurpleVip)
                    {
                        message =[NSString stringWithFormat:@"{pvip] {%ld}: 我点亮了 %@",(long)userInfo.userId,randomImageName];
                        
                    }else if(userInfo.isYellowVip){
                        message =[NSString stringWithFormat:@"{yvip] {%ld}: 我点亮了 %@",(long)userInfo.userId,randomImageName];
                    }
                }

            }else{
                if (userInfo.consumerlevelweight > 1) {
                    //                拼接用户等级
                    NSString *levelweightImg;
                    if (userInfo.consumerlevelweight <10) {
                        levelweightImg = [NSString stringWithFormat:@"{V%ld]",userInfo.consumerlevelweight];
                    }else if(userInfo.consumerlevelweight >=24){
                        levelweightImg = [NSString stringWithFormat:@"{V24]"];
                    }else{
                        levelweightImg = [NSString stringWithFormat:@"{V%ld]",userInfo.consumerlevelweight];
                    }
                    
                    if (userInfo.isPurpleVip) {
                        message =[NSString stringWithFormat:@"{pvip] %@ {%ld}: 我点亮了 %@",levelweightImg,(long)userInfo.userId,randomImageName];
                    }else if(userInfo.isYellowVip){
                        message =[NSString stringWithFormat:@"{yvip] %@ {%ld}: 我点亮了 %@",levelweightImg,(long)userInfo.userId,randomImageName];
                    }
                }else{
                    if(userInfo.isPurpleVip)
                    {
                        message =[NSString stringWithFormat:@"{pvip] {%ld}: 我点亮了 %@",(long)userInfo.userId,randomImageName];
                        
                    }else if(userInfo.isYellowVip){
                        message =[NSString stringWithFormat:@"{yvip] {%ld}: 我点亮了 %@",(long)userInfo.userId,randomImageName];
                    }
                }
            }
        }else
        {
            if ([UserInfoManager shareUserInfoManager].currentStarInfo.userId == userInfo.userId) {
                NSString *levelimg;
                //                主播等级大于1
                if ([UserInfoManager shareUserInfoManager].currentStarInfo.starlevelid >1) {
                    if ([UserInfoManager shareUserInfoManager].currentStarInfo.starlevelid <10) {
                        levelimg = [NSString stringWithFormat:@"{star00%ld]",[UserInfoManager shareUserInfoManager].currentStarInfo.starlevelid];
                    }else if([UserInfoManager shareUserInfoManager].currentStarInfo.starlevelid >=20){
                        levelimg = [NSString stringWithFormat:@"{star020]"];
                    }else{
                        levelimg = [NSString stringWithFormat:@"{star0%ld]",[UserInfoManager shareUserInfoManager].currentStarInfo.starlevelid];
                    }
                    message =[NSString stringWithFormat:@"%@ {%ld}: 我点亮了 %@",levelimg,(long)userInfo.userId,randomImageName];

                }else{
                    message =[NSString stringWithFormat:@"{%ld}: 我点亮了 %@",(long)userInfo.userId,randomImageName];
                }
            }else{
                if (userInfo.consumerlevelweight > 1) {
                    //                拼接用户等级
                    NSString *levelweightImg;
                    if (userInfo.consumerlevelweight <10) {
                        levelweightImg = [NSString stringWithFormat:@"{V%ld]",userInfo.consumerlevelweight];
                    }else if(userInfo.consumerlevelweight >=24){
                        levelweightImg = [NSString stringWithFormat:@"{V24]"];
                    }else{
                        levelweightImg = [NSString stringWithFormat:@"{V%ld]",userInfo.consumerlevelweight];
                    }
                    
                        message =[NSString stringWithFormat:@"%@ {%ld}: 我点亮了 %@",levelweightImg,(long)userInfo.userId,randomImageName];
                }else{

                        message =[NSString stringWithFormat:@"{%ld}: 我点亮了 %@",(long)userInfo.userId,randomImageName];
                }
            }
        }

    
    [self creatLabelWithChatMessage:message userInfo:info isEnter:NO isCtrl:NO];
                
}


#pragma mark 进房间信息
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
        userInfo.cardata =userEnterModel.carData;
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
        
        [self creatLabelWithChatMessage:message userInfo:info isEnter:NO isCtrl:NO];
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

#pragma mark 中奖信息
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
        headString = [NSString stringWithFormat:@"恭喜 {%ld} 获得幸运礼物大奖 %ld 倍 %@ 奖励，奖金 %ld 热币，小伙伴们快去试试手气吧。",(long)model.userid,(long)model.rewardbs,model.giftname,(long)model.rewardCoin];
    }
    else
    {
        headString = [NSString stringWithFormat:@"恭喜 {%ld} 获得幸运礼物大奖 %@ 奖励，奖金 %ld 热币，小伙伴们快去试试手气吧。",(long)model.userid,model.giftname,(long)model.rewardCoin];
    }
    
    OHAttributedLabel *label = [self creatLabelWithChatMessage:headString userInfo:info isEnter:NO isCtrl:NO];
    
    //    给中奖信息画颜色
    NSString *PurpleString = [NSString stringWithFormat:@"恭喜 "];
    NSRange PurpleRange = [label.attributedText.string rangeOfString:PurpleString];
    [label addCustomLink:[NSURL URLWithString:PurpleString] inRange:PurpleRange color:[CommonFuction colorFromHexRGB:@"d4abe5"]];
    if (model.userid != 0 && model.rewardtype == 2)
    {
        NSString *PurpleStr = [NSString stringWithFormat:@" 获得幸运礼物大奖 %ld 倍 %@",(long)model.rewardbs,model.giftname];
        NSRange PurpleRa = [label.attributedText.string rangeOfString:PurpleStr];
        [label addCustomLink:[NSURL URLWithString:PurpleStr] inRange:PurpleRa color:[CommonFuction colorFromHexRGB:@"d4abe5"]];
    }
    else
    {
        NSString *PurpleStr = [NSString stringWithFormat:@" 获得幸运礼物大奖 %@",model.giftname];
        NSRange PurpleRa = [label.attributedText.string rangeOfString:PurpleStr];
        [label addCustomLink:[NSURL URLWithString:PurpleStr] inRange:PurpleRa color:[CommonFuction colorFromHexRGB:@"d4abe5"]];
    }
    
    NSString *yellowString = [NSString stringWithFormat:@" 奖励，奖金 %ld 热币，小伙伴们快去试试手气吧。", (long)model.rewardCoin];
    NSRange yellowRange = [label.attributedText.string rangeOfString:yellowString];
    [label addCustomLink:[NSURL URLWithString:yellowString] inRange:yellowRange color:[CommonFuction colorFromHexRGB:@"d4abe5"]];
    
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
        [self creatLabelWithChatMessage:chatMessage userInfo:info isEnter:NO isCtrl:NO];
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

- (void)creatLabelWithChatMessage:(NSString *)chatMessage userInfo:(UserInfo *)userInfo;
{
    if(self.href)
    {
        [self creatLabelWithChatMessage:chatMessage userInfo:userInfo isEnter:NO isCtrl:YES];
    }else{
        [self creatLabelWithChatMessage:chatMessage userInfo:userInfo isEnter:NO isCtrl:NO];
    }
    
}

- (OHAttributedLabel *)creatLabelWithChatMessage:(NSString *)chatMessage userInfo:(UserInfo *)userInfo isEnter:(BOOL)isEnter isCtrl:(BOOL)isCtrl;
{
    /**
     *  返回的是一个label
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:ShowBarAndChat object:nil];
    [_lock lock];
    OHAttributedLabel *messageLabel = [self createMessageLabelWithMessage:chatMessage isEnter:isEnter isCtrl:isCtrl];
    messageLabel.isEnter = isEnter;
    messageLabel.isCtrl = isCtrl;
    messageLabel.info = userInfo;
    if (isCtrl) {
        NSString*  str2 = [messageLabel.attributedText.string substringFromIndex:2];
        NSRange PurpleRange = [messageLabel.attributedText.string rangeOfString:str2];
        [messageLabel addCustomLink:[NSURL URLWithString:str2] inRange:PurpleRange color:[CommonFuction colorFromHexRGB:@"a8fba8"]];

        if (self.href) {//房间公告
            self.href = nil;
            if (self.hrefnumber == 1) {
                messageLabel.underlineLinks = NO;//链接是否带下划线
            }else if(self.hrefnumber == 2){
                messageLabel.underlineLinks = YES;//链接是否带下划线
            }
        }else{
            messageLabel.underlineLinks = NO;//链接是否带下划线
            
        }

    }
    
    NSString *PurpleString = [NSString stringWithFormat:@": "];
    NSRange PurpleRange = [messageLabel.attributedText.string rangeOfString:PurpleString];

    if (userInfo.userId == [UserInfoManager shareUserInfoManager].currentStarInfo.userId) {
        [messageLabel addCustomLink:[NSURL URLWithString:PurpleString] inRange:PurpleRange color:[CommonFuction colorFromHexRGB:@"f792a0"]];
    }else{
        [messageLabel addCustomLink:[NSURL URLWithString:PurpleString] inRange:PurpleRange color:[CommonFuction colorFromHexRGB:@"f7c250"]];
    }
    [_chatmessageBufferMArray addObject:messageLabel];
    //    [self createHeadImageWithMessage:chatMessage];
    [_lock unlock];
    return messageLabel;
}

#pragma mark 处理表情
//根据用户id取得用户名(返回复文本对象)
- (OHAttributedLabel *)createMessageLabelWithMessage:(NSString *)message isEnter:(BOOL)isEnter isCtrl:(BOOL)isCtrl
{
    OHAttributedLabel *messageLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
    
    messageLabel.backgroundColor = [UIColor clearColor];
    //    messageLabel.linkColor = [CommonFuction colorFromHexRGB:@"00c1b9"];
    messageLabel.linkColor = [UIColor redColor];//[CommonFuction colorFromHexRGB:@"f7c250"];
    //    messageLabel.font = [UIFont systemFontOfSize:12.0f];
    
    //处理用户名
    NSMutableArray *outParam = [NSMutableArray array];
      messageLabel.arrayNicks = [[NSMutableArray alloc]initWithCapacity:2];
    NSString *text = message;
    _userArray = [CustomMethod addObjectArr:text beginFlage:@"{" endFlag:@"}"];
    if (_userArray && [_userArray count])
    {
        NSDictionary *chatMemberDic = [[UserInfoManager shareUserInfoManager] allUserIdAndNick];
        int num = 0;
        for (NSString *flagUserId in _userArray)
        {
            NSString *userId ;
            NSString *nick;
            if (num == 0) {
                userId = [[NSString alloc] initWithString:[flagUserId substringWithRange:NSMakeRange(1, [flagUserId length] - 2)]];
                nick = [chatMemberDic objectForKey:[NSNumber numberWithInteger:[userId integerValue]]];
                nick = [NSString stringWithFormat:@"%@",[nick stringByReplacingOccurrencesOfString:@" " withString:@""]];
            }else{
                userId = [[NSString alloc] initWithString:[flagUserId substringWithRange:NSMakeRange(1, [flagUserId length] - 2)]];
                nick = [chatMemberDic objectForKey:[NSNumber numberWithInteger:[userId integerValue]]];
                nick = [NSString stringWithFormat:@"@%@",[nick stringByReplacingOccurrencesOfString:@" " withString:@""]];
            }
            
            
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
                [messageLabel.arrayNicks addObject:nick];
            }
            num ++;
        }
    }
    
//        处理本地图片
        NSArray *localImageArray = [CustomMethod addObjectArr:text beginFlage:@"{" endFlag:@"]"];
        if (localImageArray && [localImageArray count]){
            for (NSString* localImage in localImageArray) {
                NSString *emotion = [[NSString alloc] initWithString:[localImage substringWithRange:NSMakeRange(1, [localImage length] - 2)]];
                if ([[[EmotionManager shareInstance].dictLocalImage allKeys] containsObject:emotion]) {
    
                    NSDictionary* dict =[[EmotionManager shareInstance].dictLocalImage valueForKey:emotion];
                    CGFloat width = [[dict valueForKey:@"wide"] floatValue]/2;
                    CGFloat height =[[dict valueForKey:@"height"] floatValue]/2;
                    NSString* strIamgeName = nil;
                    @try {
                        if ([dict valueForKey:@"otherName"]!= nil && ([AppInfo ip6] || [AppInfo ip6P] )&& [[[dict valueForKey:@"otherName"]valueForKey:@"3x"] isEqualToString:@"1"]) {//3x
                            strIamgeName = [NSString stringWithFormat:@"%@@3x.png",emotion];
                            
                        }else if ([dict valueForKey:@"otherName"]!= nil && ([AppInfo ip4] || [AppInfo ip5] )&&[[[dict valueForKey:@"otherName"]valueForKey:@"2x"] isEqualToString:@"1"]) {//2x
                            strIamgeName = [NSString stringWithFormat:@"%@@2x.png",emotion];
                        } else if ([dict valueForKey:@"otherName"]!= nil && ([AppInfo ip6] || [AppInfo ip6P] )&& [[[dict valueForKey:@"otherName"]valueForKey:@"3x"] isEqualToString:@"0"]) {//2x ,没有3x但是plist有值
                            strIamgeName = [NSString stringWithFormat:@"%@@2x.png",emotion];
                        }
                        else{//
                            strIamgeName = [NSString stringWithFormat:@"%@.png",emotion];
                        }

                    }
                    @catch (NSException *exception) {
                        
                    }
                    @finally {
                        
                    }
                    
                    NSRange emotionRange = [text rangeOfString:localImage];
    
                    NSString *imageHtml = [NSString stringWithFormat:@"<img src='%@' width='%.1f' height='%.1f'>",strIamgeName,width,height];
                    text = [text stringByReplacingCharactersInRange:NSMakeRange(emotionRange.location, [localImage length]) withString:imageHtml];
                    
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
            CGFloat width = emotionData.width;
            CGFloat height = emotionData.height;
            if (height > 13)
            {
                width = width * 13 / height;
                height = 13;
            }
            if (emotionData.emotionType==2) {//VIP表情
                width = 35;
                height =    35;
            }
            if (emotionData)
            {
                NSRange emotionRange = [text rangeOfString:flagEmotion];
                NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,emotionData.mlink];
                NSString *imageHtml = [NSString stringWithFormat:@"<img src='%@' width='%.1f' height='%.1f'>",url,width,height];
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
    if (str3== nil) {//如果有图标
        text = [NSString stringWithFormat:@"%@%@",str2,str1];
    }else{
        text = [NSString stringWithFormat:@"%@%@%@",str2,str1,str3];
    }
    MarkupParser *wk_markupParser = [[MarkupParser alloc] init];
    NSMutableAttributedString* attString = [wk_markupParser attrStringFromMarkup:text];
    
    CGFloat fontSize = 13;
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
    
    if (!isEnter && [outParam count])
    {
        NSRange range = [messageLabel.attributedText.string rangeOfString:[messageLabel.arrayNicks objectAtIndex:0]];
        [attString setFont:[UIFont systemFontOfSize:12] range:range];
    }
    
    [messageLabel setAttString:attString withImages:wk_markupParser.images];
    if (self.href) {//房间公告
        
        NSString *yellowString = message;
        NSRange yellowRange = [message rangeOfString:yellowString];
        [messageLabel addCustomLink:[NSURL URLWithString:self.href] inRange:yellowRange color:[CommonFuction colorFromHexRGB:@"a8fba8"]];
        if (self.hrefnumber == 1) {
            messageLabel.underlineLinks = NO;//链接是否带下划线
        }else if(self.hrefnumber == 2){
            messageLabel.underlineLinks = YES;//链接是否带下划线
        }
    }else{
        messageLabel.underlineLinks = NO;//链接是否带下划线
        
    }
    //增加链接
    if ([outParam count])
    {

        for (int i =0;i<[outParam count];i++ ) {
            NSString *userId = [[outParam objectAtIndex:i] objectForKey:@"userid"];
            NSRange range = [messageLabel.attributedText.string rangeOfString:[messageLabel.arrayNicks objectAtIndex:i]];
            [messageLabel addCustomLink:[NSURL URLWithString:userId] inRange:range];
            
        }
    }
    
    CGFloat headWidth = HeadImageWidth;
//    if (isEnter)
//    {
//        headWidth = 0;
//    }
    
    NSLog(@"%f",self.tableView.frame.size.width);
    messageLabel.delegate = self;
    CGRect labelRect = messageLabel.frame;
    labelRect.size = [messageLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH*0.618, CGFLOAT_MAX)];
    messageLabel.frame = labelRect;
    
    [messageLabel.layer display];
    
    return messageLabel;
}

#pragma mark - OHAttributedLabelDelegate

- (BOOL)attributedLabel:(OHAttributedLabel *)attributedLabel shouldFollowLink:(NSTextCheckingResult *)linkInfo
{
    NSString *requestString = [linkInfo.URL absoluteString];
    if (requestString == nil) {
        return YES;
    }
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
    else
    {
        
        if ([requestString hasPrefix:@"http:"] || [requestString hasPrefix:@"https:"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:requestString]];
            
        }else{
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",requestString]]];
        }
        return YES;
    }
    
    return NO;
}

- (UIColor*)attributedLabel:(OHAttributedLabel *)label colorForLink:(NSTextCheckingResult *)linkInfo underlineStyle:(int32_t *)underlineStyle
{
    
    NSString *linkStr = [linkInfo.URL absoluteString];
    NSInteger userid = [linkStr integerValue];
    EWPLog(@"%@ %ld",linkStr,[UserInfoManager shareUserInfoManager].currentStarInfo.userId);
    UIColor *linkColor;

    if (userid == [UserInfoManager shareUserInfoManager].currentStarInfo.userId) {
        linkColor = [CommonFuction colorFromHexRGB:@"f796a3"];
    }else{
        linkColor = [CommonFuction colorFromHexRGB:@"f7c250"];
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
             //                imageView.image = [self imageWithBackGroundColorForUserId:userId onImage:image];
             imageView.image = [self imageWithBackGroundColorForUserId:indexPath.row onImage:image];
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
                 UserInfo *info = [chatMemberInfoDic objectForKey:[NSString stringWithFormat:@"%ld", (long)userId]];
                 info.photo = model.imageUrl;
                 [chatMemberInfoDic objectForKey:[NSString stringWithFormat:@"%ld", (long)userId]];
                 NSString *baseString = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,model.imageUrl];
                 
                 [imageView sd_setImageWithURL:[NSURL URLWithString:baseString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                  {
                      //                    imageView.image = [self imageWithBackGroundColorForUserId:userId onImage:image];
                      imageView.image = [self imageWithBackGroundColorForUserId:indexPath.row onImage:image];
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
    static NSInteger labelBgTag = 101;
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        UIView *labelBg = [[UIView alloc] init];
        labelBg.tag = labelBgTag;
        
        [cell.contentView addSubview:labelBg];
        cell.contentView.backgroundColor = [UIColor clearColor];
        
    }
    
    OHAttributedLabel *label = (OHAttributedLabel *)[cell.contentView viewWithTag:100000];
    if (label)
    {
        [label.imageInfoArr removeAllObjects];
        [label.arrayNicks removeAllObjects];
        label.arrayNicks = nil;
        [label.rects removeAllObjects];
        label.rects = nil;
        label.info = nil;
        label.linkColor = nil;
        label.highlightedLinkColor = nil;
        [label removeFromSuperview];
    }
    
    
    //view内添加上label视图
    label = [self.messageLableMArray objectAtIndex:indexPath.row];
    label.tag = 100000;
    label.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    
    [CustomMethod drawImage:label isAlpha:label.isEnter];
  
    //label.frame = CGRectMake( 0, VerticalSpace , SCREEN_WIDTH*0.618, label.frame.size.height);
    UIView *labelBg = [cell.contentView viewWithTag:labelBgTag];
   
    labelBg.frame = CGRectMake(0, VerticalSpace / 2, label.frame.size.width + LabelMarginWidth,  label.frame.size.height + VerticalSpace);
    [labelBg addSubview:label];
    
   labelBg.frame = CGRectMake( 0, 0 , SCREEN_WIDTH *0.618, labelBg.frame.size.height);
    labelBg.backgroundColor = [UIColor clearColor];
    
    return cell;
}
-(CGFloat)heightXIamgeWithlabel:(OHAttributedLabel*)label{
    NSString* str =label.attributedText.string;
    if ([str rangeOfString:@"—"].length==0) {
        return  VerticalSpace + 2;
    }else{
        if (label.frameHeight>40+VerticalSpace) {
            return VerticalSpace + 2;
        }else{
            return  label.frameHeight-16+VerticalSpace;
        }
    }
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

- (void)onTap:(UIGestureRecognizer *)recognizer
{
    UIView *view = recognizer.view;
    CGPoint pt = [recognizer locationInView:view];
    
    CGPoint windowPoint = [view convertPoint:pt toView:[UIApplication sharedApplication].keyWindow];
    [[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGPoint(windowPoint) forKey:@"popupPoint"];
    
    NSInteger userId = [view.userId integerValue];
    UserInfo *userInfo = [[[UserInfoManager shareUserInfoManager] allMemberInfo] objectForKey:[NSNumber numberWithInteger:userId]];
    if (userInfo)
    {
        if (self.popupMenudelegate && [self.popupMenudelegate respondsToSelector:@selector(showPopupMenu:)])
        {
            [self.popupMenudelegate showPopupMenu:userInfo];
        }
    }
    
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
        if (indexPath.row == [self.messageLableMArray count] -1) {
            height += 4 ;
        }
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)layoutSubviews
{
    self.tableView.frame = CGRectMake(10, 25, self.frame.size.width , self.frame.size.height-27 );

//    self.tableView.frame = CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 10);
    self.tableView.backgroundColor = [UIColor clearColor];
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
