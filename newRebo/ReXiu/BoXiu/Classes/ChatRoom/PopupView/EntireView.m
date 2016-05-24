//
//  EntireView.m
//  BoXiu
//
//  Created by tongmingyu on 15-5-25.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "EntireView.h"
#import "UserInfoManager.h"
#import "AppDelegate.h"
#import "EWPScrollLable.h"
#import "GetRoomInfoModel.h"
#import "DelAttentionModel.h"
#import "AddAttentModel.h"
#import "UserInfo.h"
#import "UserInfoManager.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"
#import "ChatRoomViewController.h"
#import "SofaListModel.h"
#import "WXApi.h"

@interface EntireView ()<SofaCellDelegate>

@property (nonatomic,strong) UILabel *nick;
@property (nonatomic,strong) UILabel *introductionLabel;
@property (nonatomic,strong) EWPScrollLable *Notice;
@property (nonatomic,strong) UIImageView *VIPBox;
@property (nonatomic,strong) UIImageView *rollImg;
@property (nonatomic,strong) UIImageView *defaultHead;
@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UIImageView *detailedImg;
@property (nonatomic,strong) UIImageView *starlevelGrade;
@property (nonatomic,strong) EWPButton *starBtn;
@property (nonatomic,strong) UIButton *attentionBtn;
@property (nonatomic,strong) EWPButton *shareBtn;
@property (nonatomic,strong) EWPButton *reportBtn;
@property (nonatomic,strong) NSString *CommonFuction;
@end

@implementation EntireView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}



- (void)initView:(CGRect)frame
{
    
    self.bRobbingSofa = NO;
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"robSofaBK"]];
    
    //50%透明
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 24)];
    view.backgroundColor=[CommonFuction colorFromHexRGB:@"000000" alpha:0.5];
    [self addSubview:view];
    
    _defaultHead = [[UIImageView alloc] initWithFrame:CGRectZero];
    _defaultHead.image = [UIImage imageNamed:@"personInfo"];
    [self addSubview:_defaultHead];
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _headImg.layer.cornerRadius = 16.5f;
    [_headImg setClipsToBounds:YES];
    [self addSubview:_headImg];
    
    _starlevelGrade = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_starlevelGrade];
    
    _Notice=[[EWPScrollLable alloc] initWithFrame:CGRectMake(35, 5, SCREEN_WIDTH-35, 19)];
    _Notice.backgroundColor=[UIColor clearColor];
    _Notice.font=[UIFont systemFontOfSize:11.f];
    _Notice.textColor=[CommonFuction colorFromHexRGB:@"ffffff"];
    [self addSubview:_Notice];
    
    _nick = [[UILabel alloc] initWithFrame:CGRectZero];
    _nick.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _nick.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:_nick];

    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    if (!starInfo.introduction) {
        starInfo.introduction = @"全民星直播互动平台，娱乐你的生活";
    }
    
    _introductionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _introductionLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _introductionLabel.backgroundColor = [UIColor clearColor];
    _introductionLabel.text =starInfo.introduction;
    _introductionLabel.font = [UIFont systemFontOfSize:13.f];
    [self addSubview:_introductionLabel];
    
    
    _rollImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _rollImg.image = [UIImage imageNamed:@"notice"];
    [self addSubview:_rollImg];
    
    _detailedImg = [[UIImageView  alloc] initWithFrame:CGRectZero];
    _detailedImg.image =[UIImage imageNamed:@"rank_arrow"];
    [self addSubview:_detailedImg];
    
    _VIPBox =[[UIImageView alloc] initWithFrame:CGRectZero];
    _VIPBox.image=[UIImage imageNamed:@"VIPBox"];
    [self addSubview:_VIPBox];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(75, 79, SCREEN_WIDTH-90, 1)];
    lineView.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff" alpha:0.3];
    [self addSubview:lineView];
    
    
    UIView *Backgroundview = [[UIView alloc] initWithFrame:CGRectMake(0, 155, SCREEN_WIDTH, 40)];
    Backgroundview.backgroundColor=[CommonFuction colorFromHexRGB:@"000000" alpha:0.5];
    [self addSubview:Backgroundview];
    
    CGFloat sofaWidth = ((frame.size.width - 70 ) / 4);
    for (int nIndex = 0; nIndex < 4; nIndex++)
    {
        SofaCell *sofaCell = [[SofaCell alloc] initWithFrame:CGRectMake(sofaWidth * nIndex + 84, 81, 40, 40)];
        SofaData *sofaData = [[SofaData alloc] init];
        sofaCell.delegate = self;
        sofaData.sofano = nIndex + 1;
        sofaData.coin = 100;
        sofaData.num = 0;
        sofaCell.sofaData = sofaData;
        sofaCell.tag = nIndex + 1;
        [self addSubview:sofaCell];
    }
    [self initSofaList];


    _starBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _starBtn.tag = 3330;
    _starBtn.frame = CGRectZero;
    [_starBtn setBackgroundColor:[UIColor clearColor]];
    __weak typeof(self) weakself = self;
    _starBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(weakself) strongself = weakself;
        if (strongself)
        {
            ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)strongself.rootViewController;
            if (chatRoomViewController)
            {
                StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
                NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"userid"];
                [chatRoomViewController pushCanvas:PersonInfo_Canvas withArgument:param];
            }
        }
    };
    
    [self addSubview:_starBtn];
    
    UIImage *normalImg = [CommonFuction imageWithColor:[UIColor clearColor] size:CGSizeMake(56, 23)];
    UIImage *selectImg = [CommonFuction imageWithColor:[UIColor colorWithWhite:1 alpha:0.3] size:CGSizeMake(56, 23)];

    _attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _attentionBtn.frame = CGRectZero;
    _attentionBtn.titleLabel.font=[UIFont systemFontOfSize:14.f];
    [_attentionBtn.layer setCornerRadius:12.0]; //边框弧度
    [_attentionBtn.layer setBorderWidth:0.5];   //边框宽度
    [_attentionBtn.layer setBorderColor:[CommonFuction colorFromHexRGB:@"ffffff"].CGColor];     //边框颜色
    [_attentionBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_attentionBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [_attentionBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [_attentionBtn setBackgroundImage:selectImg forState:UIControlStateSelected];
    [_attentionBtn addTarget:self action:@selector(attention:) forControlEvents:UIControlEventTouchUpInside];
    _attentionBtn.layer.masksToBounds = YES;
    [Backgroundview addSubview:_attentionBtn];
    

    _shareBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _shareBtn.tag = 3332;
    _shareBtn.frame = CGRectZero;
    _shareBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [_shareBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    [_shareBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [_shareBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    [_shareBtn.layer setCornerRadius:12.0];
    [_shareBtn.layer setBorderWidth:0.5];   //边框宽度
    [_shareBtn.layer setBorderColor:[CommonFuction colorFromHexRGB:@"ffffff"].CGColor];
    _shareBtn.layer.masksToBounds = YES;
    _shareBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(weakself) strongself = weakself;
        if (strongself)
        {
//判断是否安装微信
//            if (![WXApi isWXAppInstalled])
//            {
//                EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"提示" message:@"未检测到微信客户端,是否现在安装" leftBtnTitle:@"暂不安装" rightBtnTitle:@"马上安装" clickBtnBlock:^(NSInteger nIndex) {
//                    if (nIndex == 0)
//                    {
//                        
//                    }
//                    else if(nIndex == 1)
//                    {
//                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
//                    }
//                }];
//                [alertView show];
//                
//                return;
//            }
            
            NSString *sharelink = [NSString stringWithFormat:@"http://www.51rebo.cn/%ld",(long)[UserInfoManager shareUserInfoManager].currentStarInfo.idxcode];
            NSString *shareContent = [NSString stringWithFormat:@"%@/%ld",UMengShareText,(long)[UserInfoManager shareUserInfoManager].currentStarInfo.idxcode];
            [UMSocialData defaultData].extConfig.wechatSessionData.url = sharelink;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = sharelink;
            [UMSocialData defaultData].extConfig.qqData.url = sharelink;
            [UMSocialData defaultData].extConfig.qzoneData.url = sharelink;
            [UMSocialData defaultData].extConfig.wechatSessionData.url = sharelink;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = sharelink;
            [UMSocialData defaultData].extConfig.title = @"热波间|全民直播平台";

            
            [UMSocialSnsService presentSnsIconSheetView:[AppDelegate shareAppDelegate].lrSliderMenuViewController
                                                 appKey:nil
                                              shareText:shareContent
                                             shareImage:[UIImage imageNamed:@"reboLogo"]
                                        shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSms]
                                               delegate:nil];

        }
       
    };
    [self addSubview:_shareBtn];

    
    //举报按钮
    _reportBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _reportBtn.tag = 3333;
    _reportBtn.frame = CGRectZero;
    _reportBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [_reportBtn setTitle:@"举报" forState:UIControlStateNormal];
    [_reportBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    [_reportBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [_reportBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    [_reportBtn.layer setCornerRadius:11.5];
    [_reportBtn.layer setBorderWidth:0.5];
    [_reportBtn.layer setBorderColor:[CommonFuction colorFromHexRGB:@"ffffff"].CGColor];
    _reportBtn.layer.masksToBounds = YES;
    _reportBtn.buttonBlock = ^(id sender)
    {
        __strong typeof (weakself) strongself = weakself;
        if (strongself)
        {
            ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)strongself.rootViewController;
            if (chatRoomViewController)
            {
                [chatRoomViewController reportUser:[UserInfoManager shareUserInfoManager].currentStarInfo];
            }
        }
        
    };
    [self addSubview:_reportBtn];
    
}


- (void)initSofaList
{
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    SofaListModel *model = [[SofaListModel alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:starInfo.roomid] forKey:@"roomid"];
    [model requestDataWithParams:param success:^(id object) {
        [self performSelectorOnMainThread:@selector(updateSofaData:) withObject:object waitUntilDone:NO];
    } fail:^(id object) {
        EWPLog(@"initsofalist fail");
    }];
}

- (void)updateSofaData:(id)sender
{
    SofaListModel *model = (SofaListModel *)sender;
    for (int nIndex = 0; nIndex < [model.sofaMArray count]; nIndex++)
    {
        SofaCellData *sofaCellData = [model.sofaMArray objectAtIndex:nIndex];
        SofaData *sofaData = [[SofaData alloc] init];
        sofaData.sofano = sofaCellData.sofano;
        sofaData.coin = sofaCellData.coin;
        sofaData.num = sofaCellData.num;
        sofaData.userid = sofaCellData.userid;
        sofaData.nick = sofaCellData.nick;
        sofaData.photo = sofaCellData.photo;
        sofaData.hidden = sofaCellData.hidden;
        sofaData.hiddenindex = sofaCellData.hiddenindex;
        sofaData.issupermanager = sofaCellData.issupermanager;
        
        [self setSofaData:sofaData];
    }
}


- (void)viewWillAppear
{
    [super viewWillAppear];
}


- (void)viewwillDisappear
{
    [super viewwillDisappear];
}

- (void)setPersonData:(PersonData *)personData
{
    _personData = personData;
    if (personData)
    {
        //头像
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[AppInfo shareInstance].res_server,personData.userImg]] placeholderImage:[UIImage imageNamed:@"headDefault.png"]];
        //公告
        self.Notice.text = personData.notice ? personData.notice :@"暂无公告";
        
        //    签名        CommonFuction
        self.nick.text = personData.nick;
        _CommonFuction=personData.nick;
        if (personData.nick)
        {
            self.nick.text = [NSString stringWithFormat:@"%@",personData.nick];
        }
        
        //等级
        UIImage *image = [[UserInfoManager shareUserInfoManager] imageOfStar:personData.starlevelid];
        if (image)
        {
            self.starlevelGrade.image = image;
        }
        
        //关注
        self.attentionBtn.selected = personData.attented;
        
    }
}


- (void)setSofaData:(SofaData *)sofaData
{
    
    if (sofaData)
    {
        SofaCell *sofaCell = (SofaCell *)[self viewWithTag:sofaData.sofano];
        if (sofaCell)
        {
            sofaCell.sofaData = sofaData;
        }
        
        UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        
        if (sofaData.userid == userInfo.userId)
        {
            self.bRobbingSofa = NO;
        }
    }
}

- (void)attention:(id)sender
{
    if (![AppInfo shareInstance].bLoginSuccess)
    {
        [self showNotice:@"需要先登录哦"];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:self.personData.userId]forKey:@"staruserid"];
    
    __weak EntireView *weakSelf = self;
    if (self.personData.attented)
    {
        //取消关注
        DelAttentionModel *delAttentionModel = [[DelAttentionModel alloc] init];
        [delAttentionModel requestDataWithParams:dict success:^(id object) {
            __strong EntireView *strongSelf = weakSelf;
            /*成功返回数据*/
            if (delAttentionModel.result == 0)
            {
                strongSelf.personData.attented = NO;
                strongSelf.attentionBtn.selected = NO;
                [strongSelf showNotice:@"已取消对TA的关注"];
            }
            else
            {
//                EWPAlertView *alerView = [[EWPAlertView alloc] initWithTitle:delAttentionModel.title message:delAttentionModel.msg confirmBlock:^(id sender) {
//                    
//                } cancelBlock:nil];
//                [alerView show];
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
                strongSelf.attentionBtn.selected = YES;
                [strongSelf showNotice:@"已成功关注TA"];
            }
            else
            {
                [strongSelf showNotice:@"需要先登录哦"];
            }
            
        } fail:^(id object) {
            
        }];
        
    }
}
#pragma mark - SofaCellDelegate
- (void)sofaCell:(SofaCell *)sofaCell sofaData:(SofaData *)sofaData
{
    if (self.delega && [self.delega respondsToSelector:@selector(robSofaView:sofaData:)])
    {
        [self.delega robSofaView:self sofaData:sofaData];
    }
}



- (void)layoutSubviews
{
    self.rollImg.frame = CGRectMake(15,5, 15, 15);
    self.defaultHead.frame = CGRectMake(16, 31, 44, 44);
    self.headImg.frame = CGRectMake(20.7, 35, 35, 35);
    self.starBtn.frame = CGRectMake(0, 24, SCREEN_WIDTH, 55);
    
    CGSize nickSize = [CommonFuction sizeOfString:_CommonFuction maxWidth:128 maxHeight:15 withFontSize:14.0f];
    self.nick.frame = CGRectMake(75, 35, nickSize.width, nickSize.height);

    self.starlevelGrade.frame = CGRectMake(80 + nickSize.width, 35, 33, 15);

    self.introductionLabel.frame = CGRectMake(75, 55, 220, 15);
    self.VIPBox.frame = CGRectMake(20, 85, 34, 59);
    self.detailedImg.frame = CGRectMake(75+225, 43, 10, 20);
    
    self.attentionBtn.frame = CGRectMake(38, 10, 56, 23);
    self.shareBtn.frame = CGRectMake(131, 165, 56, 23);
    self.reportBtn.frame = CGRectMake(225, 165, 56, 23);

    
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
