
//
//  LiveRoomLeftView.m
//  BoXiu
//
//  Created by andy on 15/6/11.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "LiveRoomLeftView.h"
#import "AudienceViewController.h"
#import "AudienceCell.h"
#import "AudieceToolCell.h"
#import "UMSocial.h"
#import "WXApi.h"
#import "StartView.h"
#import "AddAttentModel.h"
#import "DelAttentionModel.h"
#import "LiveRoomViewController.h"
@interface LiveRoomLeftView ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,BaseTableViewDataSoure,BaseTableViewDelegate,AudienceToolDelegate,UMSocialUIDelegate,AudienceViewControllerDelegate>

@property (nonatomic,assign) NSInteger maxViewerCount;
@property (nonatomic,assign) int nCount;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *blankView;//透明
//@property (nonatomic,strong) UIView *bkView;
//@property (nonatomic,strong) BaseTableView *tableView;
@property (nonatomic,assign) int currentSelectIndex;
@property (nonatomic,assign) int totalPage;
@property (nonatomic,strong) NSMutableArray *chatMemberMArray;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIButton* buttonHeadImage;
@property (nonatomic,strong) UIButton* guanZhuBtn;
@property (nonatomic,strong) UILabel* nickName;
@property (nonatomic,strong) UIImageView* level;
@property (nonatomic,strong) UIImageView* headImage;
@property (nonatomic,strong) UILabel* countLabel;

@end

@implementation LiveRoomLeftView

- (void)initView:(CGRect)frame
{
    

    
    self.delegate = self;
    _currentSelectIndex = -2;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(14, 150 + 5, SCREEN_WIDTH - 28, SCREEN_HEIGHT - 150)];
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
//    _blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, 300)];
//    [_scrollView addSubview:_blankView];
    
//    _bkView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        _bkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    _bkView.backgroundColor     = [CommonFuction colorFromHexRGB:@"FFFFFF"];
    _bkView.layer.masksToBounds = YES;
    _bkView.layer.cornerRadius  = 5;
    [_scrollView addSubview:_bkView];
    
    
    _tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 98,_bkView.frame.size.width, _bkView.frame.size.height - 120)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.baseDelegate   = self;
    _tableView.baseDataSource = self;
    


//        self.rootViewController.tableView.frame = CGRectMake(0, 120,_bkView.frame.size.width, _bkView.frame.size.height - 120);
//        self.rootViewController.tableView.baseDelegate   = self;
//        self.rootViewController.tableView.baseDataSource = self;
    
//        AudienceViewController *audienceView = [[AudienceViewController alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    [_bkView addSubview:_tableView];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height + 300);
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.scrollEnabled = NO;
//    [self initData];
    
   }

- (void)initData
{
    //初始化界面数据，包括请求数据。
    [self refreshData];
//   [self initHeadView];
}
-(void)removeNoti{
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"butonGuanZhuPressed" object:nil];
}
//主播信息的View
-(void)initHeadView
{

    StarInfo *star = [UserInfoManager shareUserInfoManager].currentStarInfo;
    if (!_headView) {
//        通知
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(guanZhu) name:@"butonGuanZhuPressed" object:nil];

        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _bkView.frame.size.width, 96)];
        _headView.backgroundColor = [UIColor clearColor];
       _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 15, 47, 47)];
        UIImageView *huan      = [[UIImageView alloc] initWithFrame:CGRectMake(18, 15, 47, 47)];
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.cornerRadius  = 47/2;
        huan.image = [UIImage imageNamed:@"huan"];
        
        huan.center = _headImage.center;
        
        _headImage.backgroundColor = [UIColor yellowColor];
        
//        主播昵称
        _nickName = [[UILabel alloc]initWithFrame:CGRectMake(77, 20, 120, 20)];
     
        NSURL *headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,star.photo]];
        NSData *headIMG = [NSData dataWithContentsOfURL:headUrl];
        _headImage.image = [UIImage imageWithData:headIMG];
        _nickName.text = star.nick;
        _nickName.font = [UIFont systemFontOfSize:14];
//        [_headView addSubview:huan]; //头像外环
        [_headView addSubview:_headImage]; //头像
        [_headView addSubview:_nickName]; //姓名
        
        self.buttonHeadImage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonHeadImage.frame = _headView.frame;
        [self.buttonHeadImage addTarget:self action:@selector(buttonHeadImagePressed) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:self.buttonHeadImage];
        
        
        NSString *countStr = [NSString stringWithFormat:@"%ld",(long)self.touristCount];
        NSInteger leng = [countStr length];
        NSString *tourStr = [NSString stringWithFormat:@"%@位游客",countStr];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tourStr];
        
        [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"F7C250"] range:NSMakeRange(0, leng)];
        [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"A4A4A4"] range:NSMakeRange(leng, 3)];
        
        
        NSString *countUserStr = [NSString stringWithFormat:@"%ld",(long)self.recordCount];
        NSInteger length = [countUserStr length] ;
        NSString *countUser = [NSString stringWithFormat:@"%@位用户,",countUserStr];
        NSMutableAttributedString *st = [[NSMutableAttributedString alloc] initWithString:countUser];
        [st addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"F7C250"] range:NSMakeRange(0, length )];
        [st addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"A4A4A4"] range:NSMakeRange(length , 4)];
        
        [st appendAttributedString:str];
        
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, CGRectGetMaxY(_headImage.frame) + 15, 200, 20)];
        _countLabel.font = [UIFont systemFontOfSize:13];
        _countLabel.attributedText = st;
        [_headView addSubview:_countLabel];
        _level = [[UIImageView alloc]initWithFrame:CGRectMake(_nickName.frame.origin.x, CGRectGetMaxY(_nickName.frame) + 2, 33, 15)];
        //    level.backgroundColor = [UIColor yellowColor];
        //    NSInteger VipCount = [[UserInfoManager shareUserInfoManager] countOfVip];
        //    level.backgroundColor = [UIColor yellowColor];
        _level.image = [[UserInfoManager shareUserInfoManager] imageOfStar:star.starlevelid];
        [_headView addSubview:_level];
        
        _guanZhuBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width * 2 / 3 - 5, 15, 34, 34)];
        UIButton *shareBtn   = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_guanZhuBtn.frame)+7, 15, 34, 34)];
        _guanZhuBtn.center = CGPointMake(_guanZhuBtn.center.x,_headImage.center.y);
        shareBtn.center = CGPointMake(shareBtn.center.x,_headImage.center.y );
        [shareBtn addTarget:self action:@selector(shareBoxiu) forControlEvents:UIControlEventTouchUpInside];
        [_guanZhuBtn addTarget:self action:@selector(guanZhu) forControlEvents:UIControlEventTouchUpInside];
  
        if (_personData) {
                [AppInfo shareInstance].isGuanZhu =_personData.attented;
            if (_personData.attented) {
             
                [_guanZhuBtn setImage:[UIImage imageNamed:@"yiguanzhu"] forState:UIControlStateNormal];
            }else{
                [_guanZhuBtn setImage:[UIImage imageNamed:@"guanzhu"] forState:UIControlStateNormal];
            }
        }
        [shareBtn   setImage:[UIImage imageNamed:@"share1.png"] forState:UIControlStateNormal];
        [_headView addSubview:_guanZhuBtn];
        [_bkView addSubview:_headView];
//        控制分享
        NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
        if(hideSwitch != 1)
        {
            [_headView addSubview:shareBtn];
        }
        
    }
    NSURL *headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,star.photo]];
    NSData *headIMG = [NSData dataWithContentsOfURL:headUrl];
    _headImage.image = [UIImage imageWithData:headIMG];
      _nickName.text = star.nick;
       _level.image = [[UserInfoManager shareUserInfoManager] imageOfStar:star.starlevelid];
    
    NSString *countStr = [NSString stringWithFormat:@"%ld ",(long)self.touristCount];
    NSInteger leng = [countStr length];
    NSString *tourStr = [NSString stringWithFormat:@"%@位游客",countStr];
    NSLog(@"游客 == %@",tourStr);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tourStr];
    
    [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"F7C250"] range:NSMakeRange(0, leng)];
    [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"A4A4A4"] range:NSMakeRange(leng, 3)];
    
    
    NSString *countUserStr = [NSString stringWithFormat:@"%ld ",(long)self.recordCount];
    NSInteger length = [countUserStr length] ;
    NSString *countUser = [NSString stringWithFormat:@"%@位用户,",countUserStr];
    NSMutableAttributedString *st = [[NSMutableAttributedString alloc] initWithString:countUser];
    [st addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"F7C250"] range:NSMakeRange(0, length )];
    [st addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"A4A4A4"] range:NSMakeRange(length , 4)];
    
    [st appendAttributedString:str];
    _countLabel.attributedText = st;
    
}

#pragma mark- 分享
-(void) shareBoxiu
{
    NSString *sharelink = [NSString stringWithFormat:@"http://www.51rebo.cn/%ld",(long)[UserInfoManager shareUserInfoManager].currentStarInfo.idxcode];
    NSString *shareContent = [NSString stringWithFormat:@"“%@”正在直播，快来玩#热波间#在热波搞男神，搞女神，搞笑话，搞怪，搞逗B，热波Star搞一切！最“搞”的全民星直播互动平台，更有千万豪礼大回馈。马上去围观：http://www.51rebo.cn/%ld",[UserInfoManager shareUserInfoManager].currentStarInfo.nick,(long)[UserInfoManager shareUserInfoManager].currentStarInfo.idxcode];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = sharelink;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = sharelink;
    [UMSocialData defaultData].extConfig.qqData.url = sharelink;
    [UMSocialData defaultData].extConfig.qzoneData.url = sharelink;
    [UMSocialData defaultData].extConfig.title = @"#热波间#最火的全民娱乐直播在线平台，潮人聚集地";
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.title =shareContent;
    UIImage* image = nil;
    if (_headImage) {
        image = _headImage.image;
    }else{
        image =[UIImage imageNamed:@"reboLogo"];
    }
    
    [UMSocialSnsService presentSnsIconSheetView:self.rootViewController
                                         appKey:nil
                                      shareText:shareContent
                                     shareImage:image
                                shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSms]
                                       delegate:self];

}
-(void)setPersonData:(PersonData *)personData{
    _personData = personData;

}

#pragma mark 关注
-(void)guanZhu
{
    if (![AppInfo shareInstance].bLoginSuccess)
    {
        [self showNotice:@"需要先登录哦"];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:self.personData.userId]forKey:@"staruserid"];
    
    __weak LiveRoomLeftView *weakSelf = self;
    if (self.personData.attented)
    {
     
        //取消关注
        DelAttentionModel *delAttentionModel = [[DelAttentionModel alloc] init];
        [delAttentionModel requestDataWithParams:dict success:^(id object) {
            __strong LiveRoomLeftView *strongSelf = weakSelf;
            /*成功返回数据*/
            if (delAttentionModel.result == 0)
            {
                strongSelf.personData.attented = NO;
                [_guanZhuBtn setImage:[UIImage imageNamed:@"guanzhu"] forState:UIControlStateNormal];
                if (self.delegate&&[self.delegate respondsToSelector:@selector(guanZhuStartView:)] )
                {
                    [self.delegate guanZhuStartView:YES];
                    [AppInfo shareInstance].isGuanZhu = NO;
                }
                [strongSelf showNotice:@"已取消对TA的关注"];
            }
            else
            {
//                EWPAlertView *alerView = [[EWPAlertView alloc] initWithTitle:delAttentionModel.title message:delAttentionModel.msg confirmBlock:^(id sender) {
//                    
//                } cancelBlock:nil];
//                [alerView show];
                
                if (delAttentionModel.code == 403)
                {
                  
                    if (self.delegate&&[self.delegate respondsToSelector:@selector(pressedShowOherTerminalLoggedDialog)] )
                    {
                        [[AppInfo shareInstance] loginOut];
                        [self.delegate pressedShowOherTerminalLoggedDialog];
                    }
                }
            

            }
        } fail:^(id object) {
            
        }];
    }
    else
    {
        //添加关注
        StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
        NSString *serverIp= [NSString stringWithFormat:@"http://%@:%ld/mobile/dispatch.mobile",starInfo.serverip,(long)starInfo.serverport];
        if (starInfo.serverip == nil)
        {
            serverIp = [AppInfo shareInstance].requestServerBaseUrl;
        }
        
        AddAttentModel *addAttentionModel = [[AddAttentModel alloc] init];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict addEntriesFromDictionary:[addAttentionModel signParamWithMethod:AddAttention_Method]];
        [dict setObject:[NSNumber numberWithInteger:self.personData.userId]forKey:@"staruserid"];
        __weak typeof(self) weakSelf = self;
        [addAttentionModel requestDataWithBaseUrl:serverIp requestType:nil method:AddAttention_Method httpHeader:[addAttentionModel httpHeaderWithMethod:AddAttention_Method] params:dict success:^(id object) {
            __strong typeof(self) strongSelf = weakSelf;
            /*成功返回数据*/
            if (addAttentionModel.result == 0)
            {
                strongSelf.personData.attented = YES;
                [AppInfo shareInstance].isGuanZhu = YES;
       [_guanZhuBtn setImage:[UIImage imageNamed:@"yiguanzhu"] forState:UIControlStateNormal];
                [strongSelf showNotice:@"已成功关注TA"];
                if (self.delegate&&[self.delegate respondsToSelector:@selector(guanZhuStartView:)] ) {
                    [self.delegate guanZhuStartView:NO];
                       [AppInfo shareInstance].isGuanZhu = YES;
                }
            }
            else
            {
//                EWPAlertView *alerView = [[EWPAlertView alloc] initWithTitle:addAttentionModel.title message:addAttentionModel.msg confirmBlock:^(id sender) {
//                    
//                } cancelBlock:nil];
//                [alerView show];
                if (addAttentionModel.code == 403)
                {
                    
                    if (self.delegate&&[self.delegate respondsToSelector:@selector(pressedShowOherTerminalLoggedDialog)] )
                    {
                        [[AppInfo shareInstance] loginOut];
                        [self.delegate pressedShowOherTerminalLoggedDialog];
                    }
                }
                else
                {
                    [strongSelf showNotice:@"需要先登录哦"];
                }
                
            }
            
        } fail:^(id object) {
            
        }];
        
    }

}



- (void)refreshData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isPagination"];//是不是页码
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"pageIndex"];  //页面索引
    [dict setObject:[NSNumber numberWithInt:Count_Per_Page] forKey:@"pageSize"];//页面大小
    [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];//当前主播的id
    
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo; //当前主播信息
    ChatmemberModel *model = [[ChatmemberModel alloc] init];    //聊天者信息
    NSString *serverIp= [NSString stringWithFormat:@"http://%@:%ld/mobile/dispatch.mobile",starInfo.serverip,(long)starInfo.serverport];
    
    if (starInfo.serverip == nil)
    {
        serverIp = [AppInfo shareInstance].requestServerBaseUrl;
    }
    [dict addEntriesFromDictionary:[model signParamWithMethod:Get_ChatMember_Method]];
    [model requestDataWithBaseUrl:serverIp requestType:nil method:Get_ChatMember_Method httpHeader:[model httpHeaderWithMethod:Get_ChatMember_Method] params:dict success:^(id object)
     {
         
//         LiveRoomViewController *liveRoomViewController = (LiveRoomViewController *)self.rootViewController;
//         [liveRoomViewController refreshAudience];
         

         if (_chatMemberMArray == nil)
         {
             _chatMemberMArray = [NSMutableArray array];
         }
         [self.chatMemberMArray removeAllObjects];
         [self.chatMemberMArray addObjectsFromArray:[self deleteHidenUserInfo:model.chatMemberMArray]];
         self.touristCount = model.touristCount;
         self.maxViewerCount = model.maxViewerCount;
         self.recordCount = model.recordCount+1;
         self.currentSelectIndex = -2;
         if (self.chatMemberMArray.count!=0) {
             if ([UserInfoManager shareUserInfoManager].currentStarInfo.onlineflag) {//如果主播在开播
                 
            
                [self.chatMemberMArray removeObjectAtIndex:0];
                 --self.recordCount;
             }else{
                    LiveRoomViewController *liveRoomViewController = (LiveRoomViewController *)self.rootViewController;
                 if ([AppInfo shareInstance].userInfoSingle.userId == liveRoomViewController.staruserid) {//如果主播没有开播，自己又是主播
                     for (UserInfo* userInfo in model.chatMemberMArray) {
                         if (userInfo.staruserid == liveRoomViewController.staruserid) {
                             [self.chatMemberMArray removeObject:userInfo];
                                --self.recordCount;
                             
                         }
                         
                         
                     }
                 }else{
                         --self.recordCount;
                 }
             }
             
             
         }
    
         if ([model.chatMemberMArray count] < Count_Per_Page||model.pageIndex*model.pageSize>=model.recordCount)
         {
             //             －1 去掉第一行数据，主播！！
             self.tableView.totalPage = [model.chatMemberMArray count]/Count_Per_Page + ([model.chatMemberMArray count]%Count_Per_Page? 1:0)-1;
         }
         else
         {
             self.tableView.totalPage = 999;
             
         }
                [self initHeadView];
         
         
//         if (self.delegate && [self.delegate respondsToSelector:@selector(updateTouristCount:recordCountshowGift:)])
//         {
//             [self.delegate updateTouristCount:self.touristCount recordCountshowGift:self.recordCount];
//         }
         [self.tableView reloadData];
     } fail:^(id object) {
         [self.tableView reloadData];
     }];
    [model autAddNumber];//在外面调用此函数要手动调用增肌计数，
    
}

- (NSArray *)deleteHidenUserInfo:(NSArray *)chatMemberArray       //将隐身用户移出用户列表，显示最终的列表
{
    UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    NSMutableArray *userInfoArray = [NSMutableArray arrayWithArray:chatMemberArray];
    for (UserInfo *userInfo in chatMemberArray)
    {
        if (currentUserInfo && currentUserInfo.userId == userInfo.userId)
        {
            //如果隐身用户为当前用户，则显示。           如果此用户即为当前用户，跳过判断(无论是否隐身都显示)
            continue;
        }
        
        if (userInfo.hidden == 2)
        {
            if (currentUserInfo.issupermanager) //超管看不到隐身的超管，但可以看到隐身的用户
            {
                if (userInfo.issupermanager)
                {
                    [userInfoArray removeObject:userInfo];
                }
                else
                {
                    continue;
                }
            }
            else                    //普通用户看不到隐身用户
            {
                [userInfoArray removeObject:userInfo];
            }
        }
    }
    return userInfoArray;           //最终得到的用户列表
}


#pragma mark -BaseTableViewDataSource

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    int nCount =  [self.chatMemberMArray count] + (self.currentSelectIndex == -2? 0:1);//如果currentSelectIndex不为 -2 则增加一个cell
    if ( self.touristCount > 0)
    {
        //所有游客只用1个Cell来表示
        nCount += 1;
    }
    return nCount;
}
- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return 1;
}
- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EWPLog(@"indexPath:%ld",(long)indexPath.row);
    static NSString *cellIdentifier = @"Cell";
    static NSString *toolCellIdentifier = @"ToolCell";
    static NSString *touristCellIdentifier = @"touristCellIdentifier";
    UITableViewCell *cell = nil;
    if (self.currentSelectIndex == indexPath.row - 1)//生成的操作的cell应该与其上一个cell关联起来（点击的是currentSelectIndex的cell，生成的是indexPth.row的cell）
    {
        AudieceToolCell *audienceToolCell = [baseTableView dequeueReusableCellWithIdentifier:toolCellIdentifier];
        if (audienceToolCell == nil)
        {
            audienceToolCell = [[AudieceToolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:toolCellIdentifier];
            audienceToolCell.accessoryType = UITableViewCellAccessoryNone; //cell无样式(右边无箭头等 )
            audienceToolCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        EWPLog(@"count = %lu;indexPath.Row=%ld",(unsigned long)[self.chatMemberMArray count],(long)indexPath.row);
        audienceToolCell.userInfo = [self.chatMemberMArray objectAtIndex:self.currentSelectIndex];
        audienceToolCell.delegate = self;
        audienceToolCell.showType = 3;
        audienceToolCell.delegate = self;
        cell = audienceToolCell;
    }
    else
    {
        int nCount =  [self.chatMemberMArray count] + (self.currentSelectIndex == -2? 0:1); // currentSelectectIndex不为-2时，cell增加一个
        if ( self.touristCount > 0)//只要有游客，游客都显示为一个Cell即可
        {
            nCount += 1;
        }
        if (indexPath.row == nCount - 1) //如果当前的Cell是最后一个
        {
            if (self.touristCount > 0)  //且有游客
            {
                UITableViewCell *touristCell = [baseTableView dequeueReusableCellWithIdentifier:touristCellIdentifier];
                if (touristCell == nil)
                {
                    touristCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:touristCellIdentifier];
                    touristCell.backgroundColor = [UIColor clearColor];
                    touristCell.accessoryType = UITableViewCellAccessoryNone;
                    touristCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    touristCell.textLabel.font = [UIFont systemFontOfSize:15.0f];
                }
                
                NSString *countStr = [NSString stringWithFormat:@"%ld",(long)self.touristCount];
                NSInteger leng = [countStr length];
                NSString *tourStr = [NSString stringWithFormat:@"%@位游客",countStr];
                
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tourStr];
                //                [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"ff6666"] range:NSMakeRange(0,leng)];
                //                [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"575757"] range:NSMakeRange(leng,3)];
                [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"F7C250"] range:NSMakeRange(0,leng)];
                [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"A4A4A4"] range:NSMakeRange(leng,3)];
                touristCell.textLabel.attributedText = str;
                
                cell = touristCell;
            }
            else    //没有游客
            {
                AudienceCell *audienceCell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (audienceCell == nil)
                {
                    audienceCell = [[AudienceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    audienceCell.backgroundColor = [UIColor whiteColor];
                    audienceCell.accessoryType = UITableViewCellAccessoryNone;
                    audienceCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                if (self.currentSelectIndex == -2 || indexPath.row <= self.currentSelectIndex)
                {
                    audienceCell.userInfo = [self.chatMemberMArray objectAtIndex:indexPath.row];
                }
                else
                {
                    audienceCell.userInfo = [self.chatMemberMArray objectAtIndex:indexPath.row - 1];
                }
                
                
                if (self.currentSelectIndex == indexPath.row)
                {
                    audienceCell.IsOpen = YES;
                }
                else
                {
                    audienceCell.IsOpen = NO;
                }
                cell = audienceCell;
                
            }
        }
        else
        {
            AudienceCell *audienceCell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (audienceCell == nil)
            {
                audienceCell = [[AudienceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                audienceCell.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
                audienceCell.accessoryType = UITableViewCellAccessoryNone;
                audienceCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if (self.currentSelectIndex == -2 || indexPath.row <= self.currentSelectIndex)
            {
                audienceCell.userInfo = [self.chatMemberMArray objectAtIndex:indexPath.row];
            }
            else
            {
                audienceCell.userInfo = [self.chatMemberMArray objectAtIndex:indexPath.row - 1];
            }
            
            
            if (self.currentSelectIndex == indexPath.row)
            {
                audienceCell.IsOpen = YES;
            }
            else
            {
                audienceCell.IsOpen = NO;
            }
            cell = audienceCell;
            
        }
    }
    cell.backgroundColor = [CommonFuction colorFromHexRGB:@"FFFFFF"];

    return cell;
    
}

#pragma mark - AudienceToolDelegate
- (void)audieceToolCell:(AudieceToolCell *)audieceToolCell didSelectIndex:(int)index
{
    UserInfo *chatMember = [self.chatMemberMArray objectAtIndex:self.currentSelectIndex];
    NSInteger nIndex = index;
//    nIndex += 1;
    switch (nIndex)
    {
        case 1:
        {
            //送ta礼物
            if (self.delegate && [self.delegate respondsToSelector:@selector(showGiftLeft:)])
            {
                [self.delegate  showGiftLeft:chatMember];
            }
            
        }
            break;
        case 0:
        {
            //与他聊天
            if (self.delegate && [self.delegate respondsToSelector:@selector(chatWithUserLeft:)])
            {
       
                [self.delegate  chatWithUserLeft:chatMember];
            }
            
        }
            break;
        case 3:
        {
            //踢出房间
            if (self.delegate && [self.delegate respondsToSelector:@selector(kickPersonLeft:)])
            {
                [self.delegate  kickPersonLeft:chatMember];
            }
        }
            break;
        case 2:
        {
            //禁言5分钟
            if (self.delegate && [self.delegate respondsToSelector:@selector(forbidSpeakLeft:)])
            {
                [self.delegate  forbidSpeakLeft:chatMember];
            }
        }
            break;
        case 4:
        {
            //举报TA
            if (self.delegate && [self.delegate respondsToSelector:@selector(reportLeft:)])
            {
                [self.delegate  reportLeft:chatMember];
            }
        }
            break;
        default:
            break;
    }
}


#pragma mark baseTableViewDelegate
- (void)loadMorData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isPagination"]; //是否为页码的标记
    [dict setObject:[NSNumber numberWithInteger:self.tableView.curentPage] forKey:@"pageIndex"];
    [dict setObject:[NSNumber numberWithInteger:Count_Per_Page] forKey:@"pageSize"]; //每页的pageSize == 20
    [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];//当前主播的id
    
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;//当前主播信息
    ChatmemberModel *model = [[ChatmemberModel alloc] init]; //聊天人
    NSString *serverIp = [NSString stringWithFormat:@"http://%@:%ld/mobile/dispatch.mobile",starInfo.serverip,(long)starInfo.serverport];
    
    if (starInfo.serverip == nil)           //当前主播的 serverip （标识符？）
    {
        serverIp = [AppInfo shareInstance].requestServerBaseUrl;
    }
    
    [dict addEntriesFromDictionary:[model signParamWithMethod:Get_ChatMember_Method]]; //获取聊天者信息（添加进dict）
    
    NSDictionary *header = [model httpHeaderWithMethod:Get_ChatMember_Method]; //获取聊天者信息（存入dict？）
    /*模块向网络层请求数据*/
    [model requestDataWithBaseUrl:serverIp requestType:nil method:Get_ChatMember_Method httpHeader:header params:dict
                          success:^(id object) {
                              
//                              LiveRoomViewController *liveRoomViewController = (LiveRoomViewController *)self.rootViewController;
//                              [liveRoomViewController refreshAudience];
                              
                              
                              if (_chatMemberMArray == nil)
                              {
                                  _chatMemberMArray = [NSMutableArray array];
                              }
                              
                              [self.chatMemberMArray addObjectsFromArray:[self deleteHidenUserInfo:model.chatMemberMArray]];
                              if ([model.chatMemberMArray count] < Count_Per_Page||model.pageIndex*model.pageSize>=model.recordCount)    //当前聊天的人数不足一页时(20人)
                              {
                                  self.tableView.totalPage = [model.chatMemberMArray count]/Count_Per_Page + ([model.chatMemberMArray count]%Count_Per_Page? 1:0);
                                  
                                  
                              }  //计算出总页数
                              else //否则有999页
                              {
                                  self.tableView.totalPage = 999;

                              }
                              self.touristCount = model.touristCount;
                              self.maxViewerCount = model.maxViewerCount;
                              self.recordCount = model.recordCount+1;
                              
                           
                              
                              
                              if (self.chatMemberMArray.count!=0) {
                                  if ([UserInfoManager shareUserInfoManager].currentStarInfo.onlineflag) {//如果主播在开播
                                      
                                      --self.recordCount;
                                  }else{
                                      LiveRoomViewController *liveRoomViewController = (LiveRoomViewController *)self.rootViewController;
                                      
                                      if ([AppInfo shareInstance].userInfoSingle.userId == liveRoomViewController.staruserid) {//如果主播没有开播，自己又是主播
                                          for (UserInfo* userInfo in model.chatMemberMArray) {
                                              if (userInfo.staruserid == liveRoomViewController.staruserid) {
                                          
                                                  --self.recordCount;
                                                  
                                              }
                                              
                                              
                                          }
                                      }  else{
                                          --self.recordCount;
                                      }
                                  }
                              }
                              
//                              if (self.delegate && [self.delegate respondsToSelector:@selector(updateTouristCount:recordCountshowGift:)])
//                              {
//                                  [self.delegate updateTouristCount:self.touristCount recordCountshowGift:self.recordCount];
//                              }
                          
                              [self.tableView reloadData];
                          } fail:^(id object) {
                              [self.tableView reloadData];
                          }];
}

#pragma mark - BaseTableViewDelegate
- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EWPLog(@"indexPath:%ld",(long)indexPath.row);
    
    if (self.currentSelectIndex == indexPath.row - 1)
    {
        return [AudieceToolCell heightOfShowType:3];
    }
    else
    {
        int nCount =  [self.chatMemberMArray count] + (self.currentSelectIndex == -2? 0:1);
        if ([self.chatMemberMArray count] == self.recordCount && self.touristCount > 0)
        {
            //游客累计显示一个cell
            nCount += 1;
        }
        if (indexPath.row == nCount - 1)
        {
            if (self.touristCount > 0)
            {
                return 60.0f;
            }
            else
            {
                return [AudienceCell height];
            }
        }
        else
        {
            return [AudienceCell height];
        }
    }
    return [AudienceCell height];
}



//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0;
//    //    return 100;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
//    return headerView;
//}

- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EWPLog(@"didSelectIndex:%ld",(long)indexPath.row);
    int nOldSelectIndex = self.currentSelectIndex;
    
    UITableViewCell *cell = [baseTableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[AudienceCell class]])
    {
        AudienceCell *audienceCell = (AudienceCell *)cell;
        if (audienceCell.IsOpen)
        {
            self.currentSelectIndex = -2;
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationBottom];
        }
        else
        {
            if (self.currentSelectIndex != -2)
            {
                NSIndexPath *deleteIndexPath = [NSIndexPath indexPathForRow:self.currentSelectIndex inSection:0];
                self.currentSelectIndex = -2;
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:deleteIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
                
                if (indexPath.row > nOldSelectIndex + 1)//????????????
                {
                    self.currentSelectIndex = indexPath.row - 1;
                    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationBottom];
                }
                else                                    //?????????????
                {
                    self.currentSelectIndex = indexPath.row;
                    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationBottom];
                }
            }
            else
            {
                self.currentSelectIndex = indexPath.row;//?????????????
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationBottom];
            }
        }
        //更新currentSelectIndex
        [baseTableView reloadData];
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >=_bkView.frame.origin.y)
    {
        scrollView.bounces = NO;
    }
    else
    {
        scrollView.bounces = YES;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint covertPoint = [self convertPoint:point toView:_blankView];
    BOOL result = [_blankView pointInside:covertPoint withEvent:event];//CGRectContainsPoint(_blankView.frame, point);
    if (result)
    {
        return nil;
    }
    
    return [super hitTest:point withEvent:event];
}
-(void)buttonHeadImagePressed{//用户点击主播头像
    self.buttonHeadImage.userInteractionEnabled = NO;


    
    //与他聊天
    if (self.delegate && [self.delegate respondsToSelector:@selector(pressedStartHeadImage)])
    {
        [self.delegate  pressedStartHeadImage];
            [self performSelector:@selector(userInterEnabledTimer) withObject:nil afterDelay:2];
    }
 
    
}
-(void)userInterEnabledTimer{
      self.buttonHeadImage.userInteractionEnabled = YES;
}
- (void)showNotice:(NSString *)message
{
    if (message != nil)
    {
        if (self.rootViewController)
        {
            [self.rootViewController showNoticeInWindow:message];
        }
    }
}

     

@end
