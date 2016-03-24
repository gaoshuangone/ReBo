//
//  InviterFriend.m
//  BoXiu
//
//  Created by tongmingyu on 15-5-7.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "InviterFriendViewController.h"
#import<CoreText/CoreText.h>
#import "InviterCell.h"
#import "InviterNumCell.h"
#import "UserInfo.h"
#import "UserInfoManager.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"
#import "InviterFriendModel.h"

@interface InviterFriendViewController () <UITableViewDelegate,UITableViewDataSource,InviterNumCellDelegate>

@property (nonatomic,strong) UILabel *numTitle;

@property (nonatomic,strong) NSString *friend;
@property (nonatomic,assign) NSInteger friendnum;
@property (nonatomic,strong) NSString *successCount;

@property (nonatomic,strong) InviterFriendModel *model;
@end

@implementation InviterFriendViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.baseViewType = kbaseViewType;
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
    
    [self requestDataWithAnalyseModel:[InviterFriendModel class] params:nil success:^(id object)
     {
         /*成功返回数据*/
         InviterFriendModel *model = object;
         if (model.result == 0)
         {
             self.model = model;
             [self.table reloadData];
         }
         else
         {
             [self showNoticeInWindow:model.msg];
         }
     }
                                 fail:^(id object)
     {
         /*失败返回数据*/
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = Invite_Friends_Title;
    
    self.table=[[UITableView alloc] initWithFrame:CGRectMake(0, 9, SCREEN_WIDTH , SCREEN_HEIGHT - 80) style:(UITableViewStyleGrouped)];
    self.table.delegate = self;
    self.table.dataSource = self;
    //    隐藏分割线
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
    self.table.bounces=NO;
    //滚动条
    self.table.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.table];
    
}

#pragma 分享
-(void) shareBoxiu:(id)sender
{
    if ([self showLoginDialog])
    {
        return;
    }
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    if (userInfo)
    {
        NSString *inviteUrl = [NSString stringWithFormat:@"%@/invite/inviteView/%ld.talent",[AppInfo shareInstance].serverBaseUrl,(long)userInfo.userId];
        [UMSocialData defaultData].extConfig.wechatSessionData.url = inviteUrl;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = inviteUrl;
        [UMSocialData defaultData].extConfig.qqData.url = inviteUrl;
        [UMSocialData defaultData].extConfig.qzoneData.url = inviteUrl;
        [UMSocialData defaultData].extConfig.title = @"热波间|全民直播平台";
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:nil
                                          shareText:[NSString stringWithFormat:@"%@%@",InviteText,inviteUrl]
                                         shareImage:[UIImage imageNamed:@"reboLogo"]
                                    shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSms]
                                           delegate:nil];
        
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger nCount = 0;
    if (_model == nil )
    {
        return nCount;
    }
    
    if (section == 0)
    {
        nCount = 1;
    }
    else if (section > _model.inviterRewards.count)
    {
        nCount = 1;
    }
    else
    {
        if (_model && _model.inviterRewards)
        {
            InviterReward *inviterReward = [_model.inviterRewards objectAtIndex:section - 1];
            if (inviterReward && inviterReward.rewards)
            {
                nCount = [inviterReward.rewards count] ;
            }
        }
    }
    return nCount;
}

//分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)TableView
{
    NSInteger count = 0;
    if (_model && _model.inviterRewards && _model.inviterRewards.count > 0)
    {
        
        count = [_model.inviterRewards count] + 2;
    }
    return count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
    
    if (section == 0)
    {
        return view;
    }
    else if (_model && section > _model.inviterRewards.count)
    {
        return view;
    }
    else
    {
        //设置section
        if (_model && _model.inviterRewards)
        {
            UILabel *friendlabel = [[UILabel alloc] initWithFrame:CGRectMake(9, 10, SCREEN_WIDTH, 15)];
            InviterReward *inviteReward = [_model.inviterRewards objectAtIndex:section - 1];
            if (inviteReward)
            {
                
                _friend=[NSString stringWithFormat:@"%ld",(long)inviteReward.count];
                NSInteger lengNum = [_friend length];
                _friend=[NSString stringWithFormat:@"%@ %ld %@",@"邀请好友",(long)inviteReward.count,@"位"];
                
                NSMutableAttributedString *rankPosStr = [[NSMutableAttributedString alloc] initWithString:_friend];
                
                [rankPosStr addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"454a4d"] range:NSMakeRange(0,5)];
                [rankPosStr addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"f7c250"] range:NSMakeRange(5,lengNum)];
                [rankPosStr addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"454a4d"] range:NSMakeRange(lengNum+5+1,1)];
                
                [rankPosStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.f] range:NSMakeRange(0, 5)];
                [rankPosStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15.f] range:NSMakeRange(5, lengNum)];
                [rankPosStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.f] range:NSMakeRange(lengNum+5+1, 1)];
                
                friendlabel.attributedText=rankPosStr;
                
                [view addSubview:friendlabel];
            }
        }
    }
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *generaCellIdentifier =  @"GeneraCellIdentifier";
    static NSString *inviteNumCellIdentifier = @"inviteNumCellIdentifier";
    static NSString *tipCellIdentifier = @"tipCellIdentifier";
    
    UITableViewCell *cell = nil;
    if (indexPath.section == 0)
    {
        
        InviterNumCell *inviterNumcell = [tableView dequeueReusableCellWithIdentifier:inviteNumCellIdentifier];
        if (inviterNumcell == nil)
        {
            inviterNumcell = [[InviterNumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inviteNumCellIdentifier];
            inviterNumcell.backgroundColor = [UIColor whiteColor];
            inviterNumcell.accessoryType = UITableViewCellAccessoryNone;
            inviterNumcell.selectionStyle = UITableViewCellSelectionStyleNone;
            inviterNumcell.delegate = self;
        }
        inviterNumcell.successCount = _model.successCount;
        cell = inviterNumcell;
    }
    else if (indexPath.section > _model.inviterRewards.count)
    {
        UITableViewCell *tipCell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
        if (tipCell == nil)
        {
            tipCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tipCellIdentifier];
            tipCell.backgroundColor = [UIColor clearColor];
            tipCell.contentView.backgroundColor = [UIColor clearColor];
            tipCell.accessoryType = UITableViewCellAccessoryNone;
            tipCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        UIImageView *warnimgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6.5, 13.5, 13.5)];
        [warnimgView setImage:[UIImage imageNamed:@"tanYQ"]];
        [tipCell.contentView addSubview:warnimgView];
        
        UILabel *warnLabel = [[UILabel alloc] initWithFrame:CGRectMake(17.5+10, 3.5, SCREEN_WIDTH, 20)];
        warnLabel.font = [UIFont systemFontOfSize:12.0f];
        warnLabel.textColor=[CommonFuction colorFromHexRGB:@"959596"];
        warnLabel.text=warn_message;
        [tipCell.contentView addSubview:warnLabel];
        cell = tipCell;
        
    }
    else
    {
        InviterCell *inviteCell = [tableView dequeueReusableCellWithIdentifier:generaCellIdentifier];
        if (inviteCell == nil)
        {
            inviteCell = [[InviterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:generaCellIdentifier];
            inviteCell.backgroundColor = [UIColor whiteColor];
            inviteCell.accessoryType = UITableViewCellAccessoryNone;
            inviteCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        if ((indexPath.section == 3 ||indexPath.section == 4) && indexPath.row == 0) {
            [inviteCell setViewLine];
        }
        InviterReward *inviterReward = [_model.inviterRewards objectAtIndex:indexPath.section - 1];
        if (inviterReward)
        {
            
            inviteCell.successCount = _model.successCount;
            inviteCell.count=inviterReward.count;
            
            Reward *reward = [inviterReward.rewards objectAtIndex:indexPath.row];
            inviteCell.reward = reward;
        }
        cell = inviteCell;
    }
    return  cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
//    return [InviterCell height];
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
 
    CGFloat height = 1;
    if (section == 0)
    {
        return height;
    }
    else if (_model && section > _model.inviterRewards.count)
    {
        return 10;
    }
    else
    {
        height = 38;
    }
    return height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(void)drawRect:(CGRect)rect
{
    //    [super drawRect:rect];
    
}

#pragma mark - InviteNumCellDelegate
- (void)inviteFriend
{
    
    
    if ([self showLoginDialog])
    {
        return;
    }
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    if (userInfo)
    {
        NSString *inviteUrl = [NSString stringWithFormat:@"%@/invite/inviteView/%ld.talent",[AppInfo shareInstance].serverBaseUrl,(long)userInfo.userId];
        [UMSocialData defaultData].extConfig.wechatSessionData.url = inviteUrl;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = inviteUrl;
        [UMSocialData defaultData].extConfig.qqData.url = inviteUrl;
        [UMSocialData defaultData].extConfig.qzoneData.url = inviteUrl;
        
        
   
        [UMSocialData defaultData].extConfig.title = @"#热波间#最火的全民娱乐直播在线平台，潮人聚集地";
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = [NSString stringWithFormat:@"%@%@",InviteText,inviteUrl];
        [UMSocialSnsService presentSnsIconSheetView:[AppDelegate shareAppDelegate].lrSliderMenuViewController
                                             appKey:nil
                                          shareText:[NSString stringWithFormat:@"%@%@",InviteText,inviteUrl]
                                         shareImage:[UIImage imageNamed:@"reboLogo"]
                                    shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSms]
                                           delegate:nil];
    }
    
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
