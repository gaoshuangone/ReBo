//
//  PersonInfoView.m
//  BoXiu
//
//  Created by andy on 14-4-17.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "PersonInfoView.h"
#import "EWPIconButton.h"
#import "AddAttentModel.h"
#import "DelAttentionModel.h"
#import "UserInfoManager.h"
#import "EWPAlertView.h"
#import "MBProgressHUD.h"
#import "ChatRoomViewController.h"
#import "UIImageView+WebCache.h"
#import "EWPScrollLable.h"
#import "PersonInfoViewController.h"
#import "UserLogicModel.h"
#import "GetUserCarModel.h"
#import "GetUserInfoModel.h"
#import "InviterFriendViewController.h"
#import "RobSofaView.h"

#import "SofaCell.h"

@implementation PersonInfoButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(25, (contentRect.size.height - 15)/2, contentRect.size.width - 20, 15);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(5, (contentRect.size.height - 11)/2, 13, 11);
}

@end


@interface PersonInfoView ()
@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *nick;
@property (nonatomic,strong) UILabel *userIdLable;
@property (nonatomic,strong) UIImageView *starlevelGrade;
@property (nonatomic,strong) UIImageView *privlevelGrade;
@property (nonatomic,strong) UILabel *showbegintime;
@property (nonatomic,strong) UIImageView *colockImg;
@property (nonatomic,strong) PersonInfoButton *attentionBtn;

@property (nonatomic,strong) EWPScrollLable *introductionLabel;

@property (nonatomic,strong) EWPScrollLable *rollContext;

@property (atomic,strong) GetUserInfoModel *getUserInfoModel;
@property (nonatomic,strong) UIImageView *headImageView;


@property (nonatomic,strong) UIButton *starInfoBtn;
@property (nonatomic,strong) UIButton *safaBtn;

@end

@implementation PersonInfoView


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
    UIImageView *defaultHead = [[UIImageView alloc] initWithFrame:CGRectMake(14, 10, 41, 41)];
    defaultHead.image = [UIImage imageNamed:@"personInfo_default"];
    [self addSubview:defaultHead];
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _headImg.layer.cornerRadius = 16.5f;
    [_headImg setClipsToBounds:YES];
    [self addSubview:_headImg];
    
    _nick = [[UILabel alloc] initWithFrame:CGRectZero];
    _nick.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _nick.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:_nick];
    
    _userIdLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _userIdLable.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _userIdLable.font = [UIFont systemFontOfSize:12.0f];
    [self addSubview:_userIdLable];
    
    _starlevelGrade = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_starlevelGrade];
    
    _privlevelGrade = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_privlevelGrade];
    
    _colockImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _colockImg.image = [UIImage imageNamed:@"starColock"];
    [self addSubview:_colockImg];
    
    _showbegintime = [[UILabel alloc] initWithFrame:CGRectZero];
    _showbegintime.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _showbegintime.font = [UIFont systemFontOfSize:12.0f];
    [self addSubview:_showbegintime];
    
    _attentionBtn = [PersonInfoButton buttonWithType:UIButtonTypeCustom];
    _attentionBtn.frame = CGRectZero;
    _attentionBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [_attentionBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    [_attentionBtn setTitle:@"未关注" forState:UIControlStateNormal];
    [_attentionBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [_attentionBtn setImage:[UIImage imageNamed:@"attention_normal.png"] forState:UIControlStateNormal];
    [_attentionBtn setImage:[UIImage imageNamed:@"attention_selected.png"] forState:UIControlStateSelected];
    [_attentionBtn addTarget:self action:@selector(attention:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_attentionBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(14, frame.size.height - 52, frame.size.width-28, 0.5)];
    lineView.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [self addSubview:lineView];
    
    UIImageView *rollImg = [[UIImageView alloc] initWithFrame:CGRectMake(14, frame.size.height - 29, 15, 15)];
    rollImg.image = [UIImage imageNamed:@"notice"];
    [self addSubview:rollImg];
    
    _rollContext = [[EWPScrollLable alloc] initWithFrame:CGRectMake(40, frame.size.height - 32, frame.size.width - 50, 20)];
    _rollContext.font = [UIFont systemFontOfSize:13.0f];
    _rollContext.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _rollContext.backgroundColor = [UIColor clearColor];
    [self addSubview:_rollContext];
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    if (_rollContext)
    {
        [_rollContext setNeedsDisplay];
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
    
    __weak PersonInfoView *weakSelf = self;
    if (self.personData.attented)
    {
        //取消关注
        DelAttentionModel *delAttentionModel = [[DelAttentionModel alloc] init];
        [delAttentionModel requestDataWithParams:dict success:^(id object) {
            __strong PersonInfoView *strongSelf = weakSelf;
            /*成功返回数据*/
            if (delAttentionModel.result == 0)
            {
                strongSelf.personData.attented = NO;
                strongSelf.attentionBtn.selected = NO;
                [strongSelf showNotice:@"已取消对TA的关注"];
            }
            else
            {
                EWPAlertView *alerView = [[EWPAlertView alloc] initWithTitle:delAttentionModel.title message:delAttentionModel.msg confirmBlock:^(id sender) {
                    
                } cancelBlock:nil];
                [alerView show];
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
                EWPAlertView *alerView = [[EWPAlertView alloc] initWithTitle:addAttentionModel.title message:addAttentionModel.msg confirmBlock:^(id sender) {
                    
                } cancelBlock:nil];
                [alerView show];
            }
            
        } fail:^(id object) {
            
        }];
        
    }
}

- (void)setPersonData:(PersonData *)personData
{
    _personData = personData;
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[AppInfo shareInstance].res_server,personData.userImg]] placeholderImage:[UIImage imageNamed:@"headDefault.png"]];
    self.nick.text = personData.nick;
    if(personData.showbegintime)
    {
        self.showbegintime.hidden = NO;
        self.colockImg.hidden = NO;
        self.showbegintime.text = [NSString stringWithFormat:@"开播时间: %@",personData.showbegintime? personData.showbegintime : @"直播间未开通"];
    }
    else
    {
        self.showbegintime.hidden = YES;
        self.colockImg.hidden = YES;
    }
    
    self.rollContext.text = personData.notice ? personData.notice :@"暂无公告";
    
    if (personData.nick)
    {
        self.nick.text = [NSString stringWithFormat:@"%@",personData.nick];
    }
    
    
    //改成显示靓号
    self.userIdLable.text = [NSString stringWithFormat:@"靓号:%ld",(long)personData.idxcode];
    
    self.attentionBtn.selected = personData.attented;
    
    UIImage *image = [[UserInfoManager shareUserInfoManager] imageOfStar:personData.starlevelid];
    if (image)
    {
        self.starlevelGrade.image = image;
    }
    
    //    image = [[UserInfoManager shareUserInfoManager] imageOfconsumerlevelweight:personData.consumerlevelweight];
    //    if (image)
    //    {
    //        self.privlevelGrade.image = image;
    //    }
}
- (void)layoutSubviews
{
    int nXOffset = 12;
    self.headImg.frame = CGRectMake(18.1, 13.9, 33, 33);
    nXOffset += 50;
    if (self.personData && [self.personData.nick length])
    {
        NSString *text = [NSString stringWithFormat:@"%@",self.personData.nick];
        CGSize size = [CommonFuction sizeOfString:text maxWidth:300 maxHeight:20 withFontSize:17.0f];
        self.nick.frame= CGRectMake(nXOffset, 10, size.width + 10, 20);
        nXOffset = nXOffset + size.width + 5;
    }
    self.colockImg.frame = CGRectMake(195, 12, 15, 15);
    self.showbegintime.frame = CGRectMake(220, 10, 90, 20);
    
    self.starlevelGrade.frame = CGRectMake(62 , 36, 33, 15);
    
    if (self.userIdLable)
    {
        NSString *text = [NSString stringWithFormat:@"%ld",(long)self.personData.idxcode];
        CGSize useridSize = [CommonFuction sizeOfString:text maxWidth:300 maxHeight:20 withFontSize:12.0f];
        self.userIdLable.frame = CGRectMake(103, 37, useridSize.width + 30, useridSize.height);
        nXOffset = nXOffset + useridSize.width + 5;
    }
    self.attentionBtn.frame = CGRectMake(247, 35, 65, 20);
    
    nXOffset = nXOffset + 30;
    self.privlevelGrade.frame = CGRectMake(nXOffset + 5, 10, 30, 20);
    
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
