
//
//  ChatToolBar.m
//  BoXiu
//
//  Created by Andy on 14-3-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ChatToolBar.h"
#import "EWPCheckBox.h"
#import "IconButton.h"
#import "DropList.h"
#import "ChatRoomViewController.h"
#import "AppInfo.h"
#import "UserInfoManager.h"
#import "StarGiftView.h"
#import "LiveRoomViewController.h"

#import "LiveRoomUtil.h"
#define Start_X 5
#define Start_Y 10
#define Expression_View_Height (245)
#define Gift_View_Height (188)

#define TEXTFIELD_LIMIT_WARNING @"输入字数不能超过%d个字符"
#define TEXTFIELD_BARAGE_TIP @"弹幕100热币/条，限15字"

@interface ChatToolBar ()<EWPCheckBoxDelegate,DropListDelegate,DropListDataSource,UITextFieldDelegate>



@property (nonatomic,strong) BaseView *giftBaseView;//showType = 3是StarGiftView类型；否则是GiftView

@property (nonatomic,strong) DropList *memberList;

@property (nonatomic,strong) EWPCheckBox *privateBtn;
@property (nonatomic,strong) EWPCheckBox *barageSwitchBtn;

@property (nonatomic,strong) IconButton *giftBtn;

@property (nonatomic,strong) EWPButton *expressBtn;

@property (nonatomic,strong) EWPButton *sendBtn;

@property (nonatomic,assign) int limitCharacterCount;//输入文字最大个数
@property (nonatomic,assign) int limitBarageCharacterCount;//弹幕文字最大个数

@property (nonatomic,strong) NSMutableArray *memberInfoMArray;//聊天成员列表

@property (nonatomic,strong) UIImageView *textFieldBackImgeView;

@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UserInfo* selfUser;



@property (nonatomic,strong) UIControl* controlGongLiao;
@property (nonatomic,strong) UILabel* labelKey;
@property (assign, nonatomic) BOOL isBarageSwitchOn;//弹幕开关
@property (strong,nonatomic) EWPButton* buttonBarageSwitch;
@property (strong,nonatomic) UIControl* controlHidKey;

@property (strong,nonatomic) UIImageView* imageViewPrivate;//私聊框
@property (strong, nonatomic) NSString* strPairce;//弹幕价格




@end

@implementation ChatToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)initView:(CGRect)frame
{
    //    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    
    self.limitCharacterCount = 60;
    self.limitBarageCharacterCount = 15;
    
    //    _memberList = [[DropList alloc] initWithFrame:CGRectMake(9, 7, 100, 22) showInView:self.containerView];
    //    _memberList.delegate = self;
    //    _memberList.dataSource = self;
    ////    _memberList.listBackColor = [UIColor whiteColor];
    //
    //    _memberList.selectTextColor = [CommonFuction colorFromHexRGB:@"a4a4a4"];
    //    _memberList.selectBackColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    //    _memberList.listBackColor = [UIColor whiteColor];
    //    _memberList.listTextColor = [CommonFuction colorFromHexRGB:@"a4a4a4"];
    //    _memberList.backView.layer.borderColor = [UIColor clearColor].CGColor;
    //    [self addSubview:_memberList];
    //
    //    _privateBtn = [[EWPCheckBox alloc] initWithDelegate:self];
    //    _privateBtn.iconWH = 15;
    //    _privateBtn.frame = CGRectMake(Start_X + 110, Start_Y, 80, 16);
    //    _privateBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    //    [_privateBtn setTitle:@"悄悄话" forState:UIControlStateNormal];
    //    [_privateBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    //    [self addSubview:_privateBtn];
    //
    //    _barageSwitchBtn = [[EWPCheckBox alloc] initWithDelegate:self];
    //    _barageSwitchBtn.iconWH = 15;
    //    _barageSwitchBtn.frame = CGRectMake(Start_X + 185, Start_Y, 70, 16);
    //    _barageSwitchBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    //    [_barageSwitchBtn setTitle:@"弹幕" forState:UIControlStateNormal];
    //    [_barageSwitchBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    //    [self addSubview:_barageSwitchBtn];
    
    _controlHidKey = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.containerView.frame.size.height - self.frame.size.height - Expression_View_Height)];
    _controlHidKey.backgroundColor = [UIColor clearColor];
    [_controlHidKey addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    
    [self.containerView addSubview:_controlHidKey];
    if (self.typeKey == TypeKey_GONGLIAO) {
        _controlGongLiao = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 56+10)];
        _controlGongLiao.backgroundColor = [UIColor clearColor];
        [self addSubview:_controlGongLiao];
        
        UIControl* controlBG = [[UIControl alloc]initWithFrame:CGRectMake(5, 0, 53, 56/2)];
        controlBG.backgroundColor = [CommonFuction colorFromHexRGB:@"c6c5c4"];
        controlBG.layer.cornerRadius = 3;
        
        [_controlGongLiao addSubview:controlBG];
        
        
        
        
        
        
        _imageViewPrivate = [[UIImageView alloc]initWithFrame:controlBG.frame];
        _imageViewPrivate.hidden = YES;
        _imageViewPrivate.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
        _imageViewPrivate.layer.cornerRadius = 3;
        [_controlGongLiao addSubview:_imageViewPrivate];
        
        UIImageView* iamgeV = [[UIImageView alloc]initWithFrame:CGRectMake(5, (56/2-18)/2, 18, 18)];
        iamgeV.image = [UIImage imageNamed:@"LRprivateChatliao.png"];
        [_imageViewPrivate addSubview:iamgeV];
        
        UILabel*labeV= [[UILabel alloc]initWithFrame:CGRectMake(53-3-74/2, 2,74/2,  56/2-4)];
        labeV.text = @"私聊";
        labeV.textAlignment = NSTextAlignmentRight;
        labeV.textColor  =[CommonFuction colorFromHexRGB:@"959596"];
        labeV.font = [UIFont systemFontOfSize:12];
        [_imageViewPrivate addSubview:labeV];
        
        
        
        
        
        _labelKey = [[UILabel alloc]initWithFrame:CGRectMake(3, 2,74/2,  56/2-4)];
        _labelKey.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
        _labelKey.text = @"公聊";
        _labelKey.textAlignment = NSTextAlignmentCenter;
        _labelKey.textColor  =[CommonFuction colorFromHexRGB:@"959596"];
        _labelKey.layer.masksToBounds = YES;
        _labelKey.layer.cornerRadius = 3;
        _labelKey.font = [UIFont systemFontOfSize:14];
        [controlBG addSubview:_labelKey];
        
        _buttonBarageSwitch = [[EWPButton alloc]initWithFrame:CGRectMake(0, 0, controlBG.frameWidth, controlBG.frameHeight)];
        _buttonBarageSwitch.tag = 100;
        __weak typeof(self) safeSelf = self;
        self.buttonBarageSwitch.buttonBlock = ^(UIButton* sender){
            __strong UIButton* button  = sender;
            if (button.tag==100) {
                button.tag=101;
                
                [safeSelf  setBarageSwitchIsOn:YES];
            }else if(button.tag == 101) {
                button.tag = 100;
                
                [safeSelf  setBarageSwitchIsOn:NO];
            }
            
        };
        [controlBG addSubview:_buttonBarageSwitch];
        
        
        UIControl* controlText  =[[UIControl alloc]initWithFrame:CGRectMake((10+106+10)/2, 0, SCREEN_WIDTH-((10+106+10)/2)-(108+10+10)/2, 56/2)];
        controlText.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
        controlText.layer.cornerRadius = 3;
        [_controlGongLiao addSubview:controlText];
        
        _messageCotent = [[CommonTextField alloc] initWithFrame:CGRectZero];
        _messageCotent.frame = CGRectMake(0, 0, controlText.frameWidth-56/2, 56/2);
        _messageCotent.returnKeyType = UIReturnKeySend;
        _messageCotent.font = [UIFont systemFontOfSize:14.0f];
        _messageCotent.textColor = [CommonFuction colorFromHexRGB:@"959596"];
        _messageCotent.delegate = self;
        _messageCotent.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _messageCotent.clearButtonMode = UITextFieldViewModeNever;
        _messageCotent.layer.masksToBounds = YES;
        _messageCotent.layer.cornerRadius = 3;
        _messageCotent.leftView = [[UIView alloc] initWithFrame:CGRectMake(-5, 0, 10, 20)];
        _messageCotent.leftViewMode = UITextFieldViewModeAlways;
        _messageCotent.tintColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
        //        _messageCotent.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4f];
        [_messageCotent setValue:[CommonFuction colorFromHexRGB:@"cbcbcb"] forKeyPath:@"_placeholderLabel.textColor"];
        [controlText addSubview:_messageCotent];
        
        EWPButton* buttonSM =[[EWPButton alloc]initWithFrame:CGRectMake(controlText.frameWidth-56/2, 0, 56/2, 56/2)];
        [buttonSM setImage: [UIImage imageNamed:@"LRsm.png"] forState:UIControlStateNormal];
        
        buttonSM.buttonBlock = ^(UIButton* sender){
            
            [safeSelf  showEmotionView:sender];
        };
        [controlText addSubview:buttonSM];
        
        
        
        
        EWPButton* buttonSend = [[EWPButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-(10+108)/2, 0, 108/2, 56/2)];
        [buttonSend setImage:  [UIImage imageNamed:@"LRsend"] forState:UIControlStateNormal];
        buttonSend.backgroundColor =[CommonFuction colorFromHexRGB:@"f792a0"];
        buttonSend.layer.cornerRadius = 3;
        buttonSend.isSoonCliCKLimit = YES;
        buttonSend.buttonBlock = ^(UIButton* sender){
            __weak typeof(self) safeSelf = self;
            [safeSelf sendMessage:nil];
            sender.userInteractionEnabled = NO;
            [safeSelf performSelector:@selector(delay:) withObject:sender afterDelay:0.7];
        };
        [_controlGongLiao addSubview:buttonSend];
        
    }
    
    
    //    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 0.5)];
    //    self.lineView.backgroundColor = [UIColor whiteColor];
    //    [self addSubview:self.lineView];
    
    
    
    //    _expressBtn = [[EWPButton alloc] initWithFrame:CGRectZero];
    //    _expressBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    //    [_expressBtn setBackgroundImage:[UIImage imageNamed:@"face_normal"] forState:UIControlStateNormal];
    ////    [_expressBtn setBackgroundImage:[UIImage imageNamed:@"face_selected.png"] forState:UIControlStateHighlighted];
    //    [_expressBtn addTarget:self action:@selector(showEmotionView:) forControlEvents:UIControlEventTouchUpInside];
    //    [self addSubview:_expressBtn];
    
    //    _messageCotent = [[UITextField alloc] initWithFrame:CGRectZero];
    //    _messageCotent.returnKeyType = UIReturnKeySend;
    //    _messageCotent.font = [UIFont systemFontOfSize:14.0f];
    //    _messageCotent.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    //    _messageCotent.delegate = self;
    //    _messageCotent.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //    _messageCotent.clearButtonMode = UITextFieldViewModeNever;
    //    _messageCotent.layer.masksToBounds = YES;
    //    _messageCotent.layer.cornerRadius = 3;
    //    _messageCotent.leftView = [[UIView alloc] initWithFrame:CGRectMake(-5, 0, 10, 20)];
    //    _messageCotent.leftViewMode = UITextFieldViewModeAlways;
    //    _messageCotent.tintColor = [UIColor whiteColor];
    //    _messageCotent.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4f];
    //    [_messageCotent setValue:[CommonFuction colorFromHexRGB:@"ffffff"] forKeyPath:@"_placeholderLabel.textColor"];
    //    [self addSubview:_messageCotent];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeText:) name:UITextFieldTextDidChangeNotification object:nil];
    
    //    _sendBtn = [[EWPButton alloc] initWithFrame:CGRectZero];
    //    _sendBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    //    [_sendBtn setImage:[UIImage imageNamed:@"exitroom"] forState:UIControlStateNormal];
    ////    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    //    [_sendBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    //    [_sendBtn addTarget:self action:@selector(hideSelf) forControlEvents:UIControlEventTouchUpInside];
    //    [self addSubview:_sendBtn];
    
    [self initChatMemeber];

}
-(void)delay:(EWPButton*)sender{
    sender.userInteractionEnabled = YES;
}

- (void)textFieldDidChangeText:(NSNotification *)notify
{
    if ([self.messageCotent.text length])
    {
        [self updateSendButtonToSendType:YES];
    }
    else
    {
        [self updateSendButtonToSendType:NO];
    }
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    if (![AppInfo shareInstance].bLoginSuccess)
    {
        self.messageCotent.placeholder = @"请登录后发言";
    }
    else
    {
        self.messageCotent.placeholder = @"和大家说点什么吧";
    }
    [_messageCotent setValue:[CommonFuction colorFromHexRGB:@"cbcbcb"] forKeyPath:@"_placeholderLabel.textColor"];
    
    if (_giftBaseView)
    {
        [_giftBaseView viewWillAppear];
    }
    
}

- (void)updateSendButtonToSendType:(BOOL)isSend;
{
    if (isSend)
    {
        [_sendBtn setImage:nil forState:UIControlStateNormal];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
        [_sendBtn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        [_sendBtn addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        [_sendBtn setImage:[UIImage imageNamed:@"exitroom"] forState:UIControlStateNormal];
        [_sendBtn setTitle:nil forState:UIControlStateNormal];
        [_sendBtn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        [_sendBtn addTarget:self action:@selector(hideSelf) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)hideSelf
{
    [self hideEmotionView];
    [self endEditing:YES];
}


- (void)viewwillDisappear
{
    [super viewwillDisappear];
}

- (void)hideKeyBoard
{
    [self initChatMemeber];//页面消失的时候，去掉@谁，默认对所有人说
    if (self.typeKey==TypeKey_ToOther) {
    [self   changeBarageSwitch];//去掉@谁的placeHolder
    }

    [self.messageCotent resignFirstResponder];
    self.controlHidKey.hidden = YES;
    
}

- (void)initChatMemeber
{
   
    UserInfo *allUser = [[UserInfo alloc] init];
    allUser.userId = 0;
    allUser.nick = @"所有人";
    [self addChatMember:allUser];
    self.targetUserInfo = allUser;
    self.selfUser = allUser;
}


-(void)setBarageSwitchIsOn:(BOOL)isOn{
    ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)self.rootViewController;
    if (chatRoomViewController && [chatRoomViewController showLoginDialog])
    {
        return ;
    }
    if (chatRoomViewController && chatRoomViewController.roomInfoData &&isOn)
    {
        if (!chatRoomViewController.roomInfoData.openflag)
        {
            [self showNotice:@"Star已关闭弹幕功能"];
            self.isBarageSwitchOn = NO;
            
            
            
        }else{
            self.isBarageSwitchOn = isOn;
            
            
        }
    }else{
        
        if (isOn) {
            self.isBarageSwitchOn = isOn;
        }else{
            self.isBarageSwitchOn = NO;
        }
        
    }
  
    [self changeBarageSwitch];
    
}
-(void)changeBarageSwitch{
      self.messageCotent.text = @"";
    if (self.isBarageSwitchOn) {
        __weak UILabel* label = _labelKey;
        label.frame = CGRectMake(53-3-74/2, 2,74/2,  56/2-4);
        label.text = @"弹幕";
        _buttonBarageSwitch.tag = 101;

      
        
     
            __weak typeof(self) weakself = self;
            [[LiveRoomUtil shartLiveRoonUtil]utilGetDataFromRoomUtilWithParams:nil withServerMothod:@"selectByParamname" bolock:^(id responseObject) {
                
                if (responseObject) {
                    __weak   HttpModel* model =(HttpModel*)responseObject;
                    weakself.strPairce = [model valueForKey:@"data"];
                
                    
                    if ([self.strPairce integerValue]==0) {
                               self.messageCotent.placeholder = [NSString stringWithFormat:@"弹幕发送限15字"];
                    }else{
                               self.messageCotent.placeholder = [NSString stringWithFormat:@"%@热币/条，限15字",self.strPairce];
                    }
               
                }else{
                    NSLog(@"获取弹幕价格失败");
                    
                    return ;
                }
                
                
            }];
      
        
    }else{
        self.isBarageSwitchOn = NO;
        
        __weak UILabel* label = _labelKey;
        label.frame = CGRectMake(3, 2,74/2,  56/2-4);
        label.text = @"公聊";
        _buttonBarageSwitch.tag = 100;
        
        self.messageCotent.placeholder = @"和大家说点什么吧";
    }
}

- (void)updateBarageSwitch
{
    
    
    LiveRoomViewController *chatRoomViewController = (LiveRoomViewController *)self.rootViewController;
    if (chatRoomViewController == nil)
    {
        return;
    }
    if (_barageSwitchBtn.checked)
    {
        if (chatRoomViewController && !chatRoomViewController.roomInfoData.openflag)
        {
            _barageSwitchBtn.checked = NO;
        }else{
            _barageSwitchBtn.checked = YES;
        }
    }
}
-(void)initSlefUser{
     _targetUserInfo = self.selfUser;
        self.memberList.selectedText = self.selfUser.nick;
}

- (void)setTargetUserInfo:(UserInfo *)targetUserInfo
{
    _targetUserInfo = targetUserInfo;
    self.memberList.selectedText = targetUserInfo.nick;
    if (_targetUserInfo.userId == 0)
    {
        self.privateBtn.checked = NO;
    }
}

- (void)addChatMember:(UserInfo *)userInfo
{
    if(_memberInfoMArray == nil)
    {
        _memberInfoMArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    BOOL bHasUserInfo = NO;
    for (UserInfo *user in self.memberInfoMArray)
    {
        if (userInfo.userId == user.userId)
        {
            bHasUserInfo = YES;
            break;
        }
    }
    if (!bHasUserInfo)
    {
        [self.memberInfoMArray addObject:userInfo];
    }
    
}

- (void)chatWithUserInfo:(UserInfo *)userInfo
{
    [self chatWithUserInfo:userInfo showToolBar:NO];
}

- (void)chatWithUserInfo:(UserInfo *)userInfo showToolBar:(BOOL)show
{
    if (userInfo)
    {
        [self addChatMember:userInfo];
        self.targetUserInfo = userInfo;
        self.typeKey = TypeKey_ToOther;
        self.messageCotent.text = @"";
        self.messageCotent.placeholder = [NSString stringWithFormat:@"@%@:",userInfo.nick];
        
        
    }
    if (show)
    {
        [self.messageCotent becomeFirstResponder];
    }
    
}

#pragma mark - EmotionViewDelegate

- (void)emotionView:(EmotionView *)emotionView didSelectEmotionData:(EmotionData *)emotiondata
{
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    if (userInfo)
    {
        if (emotiondata.emotionType == eVipType)
        {
            if (!userInfo.issupermanager)
            {
                if(!(userInfo.isYellowVip || userInfo.isPurpleVip))
                {
                    LiveRoomViewController *liveRoomViewController = (LiveRoomViewController *)self.rootViewController;
                    
                    if (liveRoomViewController)
                    {
                        [liveRoomViewController showMarketDialogWithTitle:@"温馨提示" message:@"您还不是VIP用户" buyVipBlock:nil cancelBlock:nil];
                    }
                    return;
                }
            }
        }
        int limitCharacterCount = self.limitCharacterCount;
        if (_barageSwitchBtn.checked)
        {
            limitCharacterCount = self.limitBarageCharacterCount;
        }
        NSString *content = [NSString stringWithFormat:@"[%@]",emotiondata.title];
        if ([self.messageCotent.text length] + [content length] > limitCharacterCount)
        {
            [self showLimitWaring];
            return;
        }
        
        if (self.messageCotent.text && [self.messageCotent.text length])
        {
            self.messageCotent.text = [NSString stringWithFormat:@"%@%@",self.messageCotent.text,content];
        }
        else
        {
            self.messageCotent.text = content;
        }
        
        
        if (emotiondata.emotionType == eVipType)//如果是VIP表情，直接发送，只能输入一个VIP表情
        {
            if (!userInfo.issupermanager)
            {
                if((userInfo.isYellowVip || userInfo.isPurpleVip))
                {
                    
                    
                    [self sendMessage:nil];
                }
            }else{
                [self sendMessage:nil];
            }
        }
    }
}

- (void)showEmotionView:(id)sender
{
    LiveRoomViewController *chatRoomViewController = (LiveRoomViewController *)self.rootViewController;
    if (chatRoomViewController == nil)
    {
        return;
    }
    
    if ([chatRoomViewController showLoginDialog])
    {
        return;
    }
    
    
    if (_emotionView == nil)
    {
        [_messageCotent addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
        UIControl *backView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.containerView.frame.size.height - self.frame.size.height - Expression_View_Height)];
        backView.backgroundColor = [UIColor clearColor];
        [backView addTarget:self action:@selector(hideEmotionView) forControlEvents:UIControlEventTouchUpInside];
        backView.tag = 1111;
        [self.containerView addSubview:backView];
        
        _emotionView = [[EmotionView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, self.frame.size.width, Expression_View_Height) showInView:self];
        _emotionView.delegate = self;
        [self.containerView addSubview:_emotionView];
        
        [_messageCotent resignFirstResponder];
        
        
        CGRect rect = self.emotionView.frame;
        rect.origin.y = CGRectGetMaxY(self.containerView.frame) - Expression_View_Height;
        self.emotionView.frame = rect;
        
        [UIView animateWithDuration:0.1f animations:^{
            CGRect frame = self.frame;
            frame.origin.y = CGRectGetMaxY(self.containerView.frame) - Expression_View_Height - 33;
            self.frame = frame;
            
            
        }];
        
        
        //        [UIView animateWithDuration:0.1f animations:^{
        //
        //
        //        } completion:^(BOOL finished) {
        //
        //        }];
    }
    //    else
    //    {
    //        [self hideEmotionView];
    //    }
    
}


- (void)hideEmotionView
{
    [self hideEmotionView:NO];
//    self.controlHidKey.hidden = YES;
}

- (void)hideEmotionView:(BOOL)willKeyboardShow;
{
    if(self.emotionView == nil)
    {
        return;
    }
      if (_typeKey != TypeKey_SILIAO)
    [_messageCotent removeObserver:self forKeyPath:@"text"];
    [UIView animateWithDuration:0.25f animations:^{
        CGRect rect = self.emotionView.frame;
        rect.origin.y = CGRectGetMaxY(self.containerView.frame) + 33;
        self.emotionView.frame = rect;
        
        if (!willKeyboardShow)
        {
            
            if (_typeKey == TypeKey_SILIAO) {
                self.frame = CGRectMake(0, SCREEN_HEIGHT-33, SCREEN_WIDTH, 33);
            }else{
            
            CGRect frame = self.frame;
            frame.origin.y = CGRectGetMaxY(self.containerView.frame);
            self.frame = frame;
            }
            
        }
        
        
    } completion:^(BOOL finished) {
        
        [self.emotionView removeFromSuperview];
        self.emotionView = nil;
        
        UIView *backView = [self.containerView viewWithTag:1111];
        [backView removeFromSuperview];
    }];
    
}

#pragma mark - GiftViewDelegate

- (void)giftView:(BaseView *)giftView  giveGiftInfo:(NSDictionary *)giftInfo
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(giveGift:)])
    {
        [self.delegate giveGift:giftInfo];
        [self hideGift];
    }
}

- (void)goToRecharge
{
    ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)self.rootViewController;
    if (chatRoomViewController)
    {
        [chatRoomViewController goToRechargeView];
    }
}

- (void)showGift:(id)sender
{
    ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)self.rootViewController;
    if (chatRoomViewController == nil)
    {
        return;
    }
    
    if (![chatRoomViewController showLoginDialog])
    {
        [self giveGiftWithUserInfo:[UserInfoManager shareUserInfoManager].currentStarInfo];
    }
}


- (void)giveGiftWithUserInfo:(UserInfo *)userInfo
{
    [_messageCotent resignFirstResponder];
    
    [self hideEmotionView];
    if (_giftBaseView == nil)
    {
        ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)self.rootViewController;
        if (chatRoomViewController == nil)
        {
            return;
        }
        if (chatRoomViewController.roomInfoData.showtype == 3)
        {
            UIControl *backView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.containerView.frame.size.height - 120)];
            backView.backgroundColor = [UIColor clearColor];
            [backView addTarget:self action:@selector(hideGift) forControlEvents:UIControlEventTouchUpInside];
            backView.tag = 3333;
            [self.containerView addSubview:backView];
            
            StarGiftView *starGiftView = [[StarGiftView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, self.frame.size.width, 120) showInView:self.containerView];
            starGiftView.delegate = self;
            [self.containerView addSubview:starGiftView];
            
            [UIView animateWithDuration:0.3f animations:^{
                starGiftView.userInteractionEnabled = NO;
                CGRect rect = starGiftView.frame;
                rect.origin.y -= 120;
                starGiftView.frame = rect;
            } completion:^(BOOL finished) {
                [self addGiftGuideView];
                starGiftView.userInteractionEnabled = YES;
            }];
            _giftBaseView = starGiftView;
            
        }
        else
        {
            [[UserInfoManager shareUserInfoManager] addGiftMember:userInfo];
            UIControl *backView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.containerView.frame.size.height - Gift_View_Height)];
            backView.backgroundColor = [UIColor clearColor];
            [backView addTarget:self action:@selector(hideGift) forControlEvents:UIControlEventTouchUpInside];
            backView.tag = 2222;
            [self.containerView addSubview:backView];
            
            GiftView *giftView = [[GiftView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, self.frame.size.width, Gift_View_Height) showInView:self.containerView];
            giftView.delegate = self;
            [self.containerView addSubview:giftView];
            
            
            
            
            
            //            [_giftBaseView addObserver:self.rootViewController forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
            
            
            
            
            [UIView animateWithDuration:0.3f animations:^{
                giftView.userInteractionEnabled = NO;
                CGRect rect = giftView.frame;
                rect.origin.y -= Gift_View_Height;
                giftView.frame = rect;
                [[NSNotificationCenter defaultCenter]postNotificationName:@"chartCountFrame" object:nil userInfo:@{@"x":[NSString stringWithFormat:@"%f",CGRectGetMinY(giftView.frame) ] ,@"height":[NSString stringWithFormat:@"%f",giftView.frame.size.height ]}];
            } completion:^(BOOL finished) {
                [self addGiftGuideView];
                giftView.userInteractionEnabled = YES;
            }];
            
            _giftBaseView = giftView;
            
        }
    }
    else
    {
        [self hideGift];
    }
}

- (void)hideGift
{
    ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)self.rootViewController;
    if (chatRoomViewController == nil)
    {
        return;
    }
    if (chatRoomViewController.roomInfoData.showtype == 3)
    {
        [UIView animateWithDuration:0.1f animations:^{
            CGRect rect = self.giftBaseView.frame;
            rect.origin.y += 120;
            self.giftBaseView.frame = rect;
            
        } completion:^(BOOL finished) {
            
            UIView *backView = [self.containerView viewWithTag:3333];
            [backView removeFromSuperview];
            
            [self.giftBaseView removeFromSuperview];
            self.giftBaseView = nil;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.1f animations:^{
            CGRect rect = self.giftBaseView.frame;
            rect.origin.y += Expression_View_Height;
            self.giftBaseView.frame = rect;
            
        } completion:^(BOOL finished) {
            
            UIView *backView = [self.containerView viewWithTag:2222];
            [backView removeFromSuperview];
            
            [self.giftBaseView removeFromSuperview];
            self.giftBaseView = nil;
        }];
    }
    
}

-(void)setIsPrivateChat:(BOOL)isPrivateChat{
    _isPrivateChat = isPrivateChat;
    _imageViewPrivate.hidden = !isPrivateChat;
    _labelKey.hidden = isPrivateChat;
    _barageSwitchBtn.hidden = isPrivateChat;
    
    
    if (isPrivateChat) {
        [self setBarageSwitchIsOn:NO];//关闭弹幕
        _buttonBarageSwitch.userInteractionEnabled = NO;
        _controlHidKey.userInteractionEnabled = NO;
             self.typeKey = TypeKey_SILIAO;
    }else{
            _buttonBarageSwitch.userInteractionEnabled = YES;
          _controlHidKey.userInteractionEnabled = YES;
        [self initChatMemeber];//页面消失的时候，去掉@谁，默认对所有人说
        [self   changeBarageSwitch];//去掉@谁的placeHolder
         self.typeKey = TypeKey_GONGLIAO;
    }
    if ([self.messageCotent isFirstResponder] && !isPrivateChat) {
            [self hideKeyBoard];
    }

}
- (void)sendMessage:(id)sender
{
//    ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)self.rootViewController;
//    
//    if (chatRoomViewController == nil)
//    {
//        return;
//    }
//    if ([chatRoomViewController showLoginDialog])
//    {
//        return;
//    }
    
    //    [self removeObserver:self forKeyPath:@"bLoginSuccess" context:nil];
   
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *message = _messageCotent.text;
    
    if ([CommonFuction isEmpty:message])
    {
        _messageCotent.text = @"";
        [self showNotice:@"发送的内容不能为空!"];
        //        隐藏键盘
        [self endEditing:YES];
        
        return;
    }
    else
    {
        //        [_messageCotent resignFirstResponder];
        
        [self hideEmotionView];
    }
    
   
    
        LiveRoomViewController *chatRoomViewController = (LiveRoomViewController *)self.rootViewController;
        if (chatRoomViewController && [chatRoomViewController showLoginDialog])
        {
            [self hideEmotionView];
            [self endEditing:YES];
            return ;
        }
    
    if (self.messageCotent.text.length>60) {
        [self   showLimitWaring];
        return;

    }

StarInfo *currentStarInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;

    if (self.isBarageSwitchOn)
    {
        if ([_messageCotent.text length] > _limitBarageCharacterCount)
        {
            NSString *message = [NSString stringWithFormat:@"输入字数不能超过%d个字符",_limitBarageCharacterCount];
            EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"提示" message:message confirmBlock:nil cancelBlock:nil];
            [alertView show];
            return;
        }
        [param setObject:[NSNumber numberWithInteger:currentStarInfo.userId] forKey:@"staruserid"];
        [param setObject:message forKey:@"content"];
    }
    else
    {
        UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        
        [param setObject:[NSNumber numberWithInteger:currentUserInfo.userId] forKey:@"userid"];
        [param setObject:currentUserInfo.nick forKey:@"nick"];
        if (_isPrivateChat)
        {
            [param setObject:[NSNumber numberWithInteger:2] forKey:@"chatType"];
        }
        else
        {
            [param setObject:[NSNumber numberWithInteger:1] forKey:@"chatType"];
        }
        

        [param setObject:[NSNumber numberWithInteger:1] forKey:@"contentType"];
        [param setObject:message forKey:@"msg"];
        [param setObject:[NSNumber numberWithInteger:currentStarInfo.userId] forKey:@"staruserid"];
        if (self.targetUserInfo.userId != 0)
        {
            [param setObject:[NSNumber numberWithInteger:self.targetUserInfo.userId] forKey:@"targetUserid"];
            [param setObject:self.targetUserInfo.nick forKey:@"targetNick"];
        }
        else
        {
            [param setObject:[NSNumber numberWithInteger:1] forKey:@"chatType"];
        }
        
        if (_isPrivateChat)
        {
            if ([UserInfoManager shareUserInfoManager].getUserInfoModel.userInfo.userId== self.targetUserInfo.userId) {
                [self showNotice:@"自己不能跟自己聊天哦"];
                return;
            }
        }
    }

    EWPLog(@"message is %@",message);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendMessage:)])
    {
        
        if (_isPrivateChat) {
            GetUserInfoModel *userInfoModel = [[GetUserInfoModel alloc] init];
            [userInfoModel requestDataWithParams:nil success:^(id object) {
                /*成功返回数据*/
                if (userInfoModel.result == 0)
                {
                    if (userInfoModel.userInfo)
                    {
                        
                        
                        
                        
                        if (userInfoModel.userInfo.consumerlevelweight>=2) {
                           [self.delegate sendMessage:param];
                        }else {
                            
                            [self endEditing:YES];
                            [self showNotice:@"财富等级大于2才能私聊哦"];
                        }
                        
                    }
                    
                }

            } fail:^(id object) {
                
            }];
        }else{
        [self.delegate sendMessage:param];
        }
    }
    _messageCotent.text = @"";
    [self updateSendButtonToSendType:NO];
}

#pragma mark - EWPcheckBoxDelegate

- (BOOL)ewpCheckBoxShouldCanEditing:(EWPCheckBox *)ewpCheckBox
{
    ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)self.rootViewController;
    if (chatRoomViewController && [chatRoomViewController showLoginDialog])
    {
        return NO;
    }
    
    if (ewpCheckBox == _privateBtn)
    {
        if (self.targetUserInfo.userId == 0)
        {
            [self endEditing:YES];
            [self showNotice:@"不能对所有人说悄悄话哦"];
            return NO;
        }
        
        UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        if (userInfo.consumerlevelweight <= 2 )
        {
            [self endEditing:YES];
            [self showNotice:@"财富等级大于2才能私聊哦"];
            return NO;
        }
        
        if (_barageSwitchBtn.checked)
        {
            _barageSwitchBtn.checked = NO;
        }
        
    }
    else
    {
        
        ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)self.rootViewController;
        if (chatRoomViewController && chatRoomViewController.roomInfoData)
        {
            if (!chatRoomViewController.roomInfoData.openflag)
            {
                [self showNotice:@"Star已关闭弹幕功能"];
                return NO;
            }
        }
        if (_privateBtn.checked)
        {
            _privateBtn.checked = NO;
        }
    }
    return YES;
}

- (void)didSelectedCheckBox:(EWPCheckBox *)checkbox checked:(BOOL)checked
{
    if (checkbox == _privateBtn)
    {
        _messageCotent.placeholder = @"最多输入60字";
    }
    else if(checkbox == _barageSwitchBtn)
    {
        
        if (checked)
        {
            _messageCotent.placeholder = TEXTFIELD_BARAGE_TIP;
        }
        else
        {
            _messageCotent.placeholder = @"最多输入60字";
        }
    }
    
}

#pragma mark - DropListDelegate

- (void)dropList:(DropList *)dropList didSelectedIndex:(NSInteger)index
{
    UserInfo *userInfo = [_memberInfoMArray objectAtIndex:index];
    if (userInfo)
    {
        self.targetUserInfo = userInfo;
    }
    
}
- (void)dropList:(DropList *)dropList didSelectedItem:(UserInfo *)userInfo
{
    if (userInfo)
    {
        self.targetUserInfo = userInfo;
    }
}

#pragma mark -DropListDataSource

- (NSInteger)numberOfRowsInDropList:(DropList *)dropList
{
    return [self.memberInfoMArray count];
}

- (NSString *)dropList:(DropList *)dropList textOfRow:(NSInteger)row
{
    UserInfo *userInfo = [self.memberInfoMArray objectAtIndex:row];
    return userInfo.nick;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    LiveRoomViewController *chatRoomViewController = (LiveRoomViewController *)self.rootViewController;
    if (chatRoomViewController && [chatRoomViewController showLoginDialog])
    {
        return NO;
    }
    self.controlHidKey .hidden = NO;
    [self hideEmotionView:YES];
    if (!_messageCotent.window.isKeyWindow)
    {
        [_messageCotent.window makeKeyAndVisible];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    
    [self resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [self sendMessage:nil];
//    [textField resignFirstResponder];
    return NO;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.messageCotent.text length])
    {
        [self updateSendButtonToSendType:YES];
    }
    else
    {
        [self updateSendButtonToSendType:NO];
    }
    int limitCharacterCount = self.limitCharacterCount;
    if (_barageSwitchBtn.checked)
    {
        limitCharacterCount = self.limitBarageCharacterCount;
    }
    
    if (range.length > 0)
    {
        if ([string length] > 0)
        {
            if (([textField.text length] - range.length + [string length]) > limitCharacterCount)
            {
                if ([string length] == 0)
                {
                    return YES;
                }
                [self showLimitWaring];
                return NO;
            }
        }
        else
        {
            if (([textField.text length] - range.length) > limitCharacterCount)
            {
                if ([string length] == 0)
                {
                    return YES;
                }
                [self showLimitWaring];
                return NO;
            }
            
        }
        return YES;
    }
    if ([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        return NO;
    }
    else if(range.location >= 60)
    {
        if ([string length] == 0)
        {
            return YES;
        }
        [self showLimitWaring];
        return NO;
    }
    if ([textField.text length] + [string length]> 0) {
        if (([textField.text length] + [string length]) > limitCharacterCount)
        {
            if ([string length] == 0)
            {
                return YES;
            }
            [self showLimitWaring];
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField               // called when clear button pressed. return NO to ignore (no notifications)
{
    _messageCotent.text = @"";
    return YES;
}

- (void)showLimitWaring
{
    int limitCharacterCount = self.limitCharacterCount;
    if (_barageSwitchBtn.checked)
    {
        limitCharacterCount = self.limitBarageCharacterCount;
    }
    
    NSString *message = [NSString stringWithFormat:TEXTFIELD_LIMIT_WARNING,limitCharacterCount];
    EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:message message:nil confirmBlock:nil cancelBlock:nil];
    [alertView show];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


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

#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"text"])
    {
        NSString *oldContent = [change objectForKey:NSKeyValueChangeOldKey];
        NSString *newcontent  = [change objectForKey:NSKeyValueChangeNewKey];
        if (newcontent)
        {
            if ([newcontent length]  > _limitCharacterCount)
            {
                [self showLimitWaring];
                if (oldContent)
                {
                    _messageCotent.text = oldContent;
                }
            }
            
        }
        
        if ([self.messageCotent.text length])
        {
            [self updateSendButtonToSendType:YES];
        }
        else
        {
            [self updateSendButtonToSendType:NO];
        }
    }
    
}

#pragma mark - addGiftGuideView
- (void)addGiftGuideView
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"GiftGuide"] == nil)
    {
        NSString *giftGuideImgName = nil;
        if (IPHONE_5)
        {
            giftGuideImgName = @"giftGuide2";
        }
        else
        {
            giftGuideImgName = @"giftGuide1";
        }
        
        UIView *giftGuideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        giftGuideView.backgroundColor = [UIColor blackColor];
        giftGuideView.alpha = 0.8;
        [giftGuideView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideGiftGuideView:)]];
        [self.containerView addSubview:giftGuideView];
        
        UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        backImg.image = [UIImage imageNamed:giftGuideImgName];
        [giftGuideView addSubview:backImg];
        
        [UIView animateWithDuration:1.0f animations:^{
            giftGuideView.userInteractionEnabled = NO;
            CGRect rect = backImg.frame;
            rect.origin.y -= rect.size.height;
            backImg.frame = rect;
        } completion:^(BOOL finished) {
            giftGuideView.userInteractionEnabled = YES;
        }];
        
        [defaults setObject:@"YES" forKey:@"GiftGuide"];
        [defaults synchronize];
    }
}

- (void)hideGiftGuideView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [tapGestureRecognizer.view removeFromSuperview];
}

- (void)layoutSubviews
{
    //     ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)self.rootViewController;
    //    if (chatRoomViewController == nil)
    //    {
    //        return;
    //    }
    //    if (chatRoomViewController.roomInfoData.showtype == 3)
    //    {
    //        self.memberList.frame = CGRectMake(10, 5, 150, 25);
    //        self.privateBtn.hidden = YES;
    //        self.barageSwitchBtn.frame = CGRectMake(Start_X + 175, Start_Y, 70, 16);
    //    }
    //    else
    //    {
    //        self.memberList.frame = CGRectMake(10, 5, 100, 25);
    //
    //        self.privateBtn.frame = CGRectMake(Start_X + 115, Start_Y, 80, 16);
    //        self.privateBtn.hidden = NO;
    //
    //        self.barageSwitchBtn.frame = CGRectMake(Start_X + 190, Start_Y, 70, 16);
    //    }
    //    self.giftBtn.frame = CGRectMake(Start_X + 250, Start_Y, 70, 16);
    //    self.textFieldBackImgeView.frame = CGRectMake(0, 36, self.frame.size.width, 45);
    //    self.expressBtn.frame = CGRectMake(Start_X + 10, 48.5, 20, 20);
    //    self.messageCotent.frame = CGRectMake(Start_X + 40 + 5 , 45, 210, 27);
    //    self.sendBtn.frame = CGRectMake(Start_X + 55 + 200 + 5, 45, 54, 27);
    //    self.lineView.frame = CGRectMake(10, 37, self.frame.size.width - 20, 1);
    ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)self.rootViewController;
    if (chatRoomViewController == nil)
    {
        return;
    }
    if (chatRoomViewController.roomInfoData.showtype == 3)
    {
        //        self.memberList.frame = CGRectMake(10, 5, 150, 25);
        //        self.privateBtn.hidden = YES;
        //        self.barageSwitchBtn.frame = CGRectMake(Start_X + 175, Start_Y, 70, 16);
    }
    else
    {
        //        self.memberList.frame = CGRectMake(10, 5, 100, 25);
        //
        //        self.privateBtn.frame = CGRectMake(Start_X + 115, Start_Y, 80, 16);
        //        self.privateBtn.hidden = NO;
        //
        //        self.barageSwitchBtn.frame = CGRectMake(Start_X + 190, Start_Y, 70, 16);
    }
    //    self.giftBtn.frame = CGRectMake(Start_X + 250, Start_Y, 70, 16);
    //    self.textFieldBackImgeView.frame = CGRectMake(0, 36, self.frame.size.width, 45);
    //    self.expressBtn.frame = CGRectMake(Start_X + 10, 48.5, 20, 20);
    //    self.messageCotent.frame = CGRectMake(Start_X + 40 + 5 , 45, 210, 27);
    //    self.sendBtn.frame = CGRectMake(Start_X + 55 + 200 + 5, 45, 54, 27);
    //    self.lineView.frame = CGRectMake(10, 37, self.frame.size.width - 20, 1);
    
}

@end
