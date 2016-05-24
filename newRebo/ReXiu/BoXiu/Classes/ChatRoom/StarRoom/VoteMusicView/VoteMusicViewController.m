//
//  VoteMusicViewController.m
//  BoXiu
//
//  Created by andy on 15-1-9.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "VoteMusicViewController.h"
#import "EWPTabMenuControl.h"
#import "ChatRoomViewController.h"
#import "ChoseMusicModel.h"
#import "UserInfoManager.h"
#import "FreeTicketModel.h"
#import "VoteMusicCell.h"

@interface VoteMusicViewController ()<VoteMusicCellDelegate,BaseTableViewDataSoure,BaseTableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) BaseTableView *tableView;
@property (nonatomic,strong) NSMutableArray *musicAry;

@property (nonatomic,strong) UIImageView *volueImgView;
@property (nonatomic,strong) UILabel *volueTitle;
@property (nonatomic,strong) UILabel *coinCount;
@property (nonatomic,assign) NSInteger canOperate;

@property (nonatomic,strong) UIView *volumeView;
@property (nonatomic,strong) UIImageView *lineImgView;
@property (nonatomic,strong) UIView *chargeView;

@property (nonatomic,assign) BOOL havefreeTicket;

@property (nonatomic,strong) EWPSimpleDialog *voteDialog; //第一次投票弹出提示
@property (nonatomic,strong) UITextField *ticketNumTextFiled;      //长按投票数量

@end

@implementation VoteMusicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseTableViewType;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _volumeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 292)];
    _volumeView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"musicBg"]];
    [self.view addSubview:_volumeView];
    
    _volueImgView = [[UIImageView alloc] initWithFrame:CGRectMake(9.5, 7.5, 22.5, 26)];
    _volueImgView.image = [UIImage imageNamed:@"unused"];
    [_volumeView addSubview:_volueImgView];
    
    _volueTitle = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 280, 20)];
    _volueTitle.text = @"您有1张免费点歌卷未使用，长按投票可批量送出";
    _volueTitle.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _volueTitle.font = [UIFont systemFontOfSize:12.0f];
    _volueTitle.backgroundColor = [UIColor clearColor];
    [_volumeView addSubview:_volueTitle];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.tableView.loadMore = NO;
    [self.volumeView addSubview:self.tableView];
    
    _lineImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _lineImgView.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [self.view addSubview:_lineImgView];
    
    _chargeView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_chargeView];
    
    UIImageView *coinImg = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 15, 15)];
    coinImg.image = [UIImage imageNamed:@"rebi"];
    [_chargeView addSubview:coinImg];
    
    _coinCount = [[UILabel alloc] initWithFrame:CGRectMake(34, 15, 150, 15)];
    _coinCount.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    _coinCount.textAlignment = NSTextAlignmentLeft;
    _coinCount.font = [UIFont systemFontOfSize:12.0f];
    _coinCount.text = @"0";
    [_chargeView addSubview:_coinCount];
    
    UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rechargeBtn.frame = CGRectMake(236, 10.5, 68, 25);
    [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"f7c250"] forState:UIControlStateNormal];
    [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    rechargeBtn.layer.cornerRadius = 12.5;
    rechargeBtn.layer.masksToBounds = YES;
    rechargeBtn.layer.borderWidth = 0.5;
    rechargeBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"f7c250"].CGColor;
    rechargeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [rechargeBtn addTarget:self action:@selector(goToRecharge) forControlEvents:UIControlEventTouchUpInside];
    [_chargeView addSubview:rechargeBtn];
    
    [self showMusicBadge];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    self.tableView.frame = CGRectMake(0, 41, self.view.frame.size.width, self.view.frame.size.height - 41 - 43);

    self.lineImgView.frame = CGRectMake(10, 41, _volumeView.frame.size.width-20, 0.5);
    self.chargeView.frame = CGRectMake(0, self.view.frame.size.height - 43, self.view.frame.size.width, 43);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.bFirstViewWillAppear)
    {
        [self showMusicBadge];
    }
    [self refreshData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)initData
{
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    if (userInfo)
    {
        _coinCount.text = [NSString stringWithFormat:@"%lld",userInfo.coin];
    }
}

#pragma mark -刷新数据
- (void)refreshData
{
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    if (starInfo == nil)
    {
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:starInfo.userId] forKey:@"staruserid"];
    
    FreeTicketModel *model = [[FreeTicketModel alloc] init];
    [model requestDataWithParams:dict success:^(id object)
     {
         if (model.result == 0)
         {
             self.havefreeTicket = model.haveFreeTicket;
        }
     }
    fail:^(id object)
     {
         
     }];
    
    
    QueryMusicListModel *musicModel = [[QueryMusicListModel alloc] init];
    
    [musicModel requestDataWithParams:dict success:^(id object)
     {
         if (musicModel.result == 0)
         {
             if (_musicAry == nil)
             {
                 _musicAry = [NSMutableArray array];
             }
             [_musicAry removeAllObjects];
             
             [_musicAry addObjectsFromArray:musicModel.musicDataArray];
             
             _canOperate = musicModel.canOperate;
             
             [self.tableView reloadData];
         }
     }
    fail:^(id object)
     {
         [self.tableView reloadData];
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return 1;
}


-(NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    return _musicAry.count;
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    VoteMusicCell *cell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[VoteMusicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.delegate = self;
    }
    cell.musicData = [_musicAry objectAtIndex:indexPath.row];
    [cell canOperate:_canOperate];
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [VoteMusicCell height];
}

- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

// 第一次安装，点歌标签有红点
- (void)showMusicBadge
{
    EWPTabMenuControl *tabMenuControl = (EWPTabMenuControl *)self.baseTabMenuControl;
    if (tabMenuControl)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"musicBadge"] == nil)
        {
            int badge = 0;
            if (tabMenuControl.currentSelectedSegmentIndex != 1)
            {
                badge = 1;
            }
            else
            {
                badge = 0;
                [defaults setObject:@"YES" forKey:@"musicBadge"];
                [defaults synchronize];
            }
            
            [tabMenuControl tabMenuBadge:badge atIndex:1];
        }
    }
}

//跳转到充值
- (void)goToRecharge
{
    ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)self.rootViewController;
    if (chatRoomViewController)
    {
        [chatRoomViewController goToRechargeView];
    }
}

#pragma mark - VoteMusicCellDelegate
- (void)voteMusicCell:(VoteMusicCell *)voteMusicCell musicData:(MusicData *)musicData longPressGesture:(BOOL)longPressGesture
{
    ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)self.rootViewController;
    if (chatRoomViewController == nil)
    {
        return;
    }
    
    if ([chatRoomViewController showLoginDialog])
    {
        return;
    }
    
    if (longPressGesture)
    {
        [self moreVoteDialog:musicData.musiceId musicName:musicData.musicname];
        return;
    }
    
    if (self.havefreeTicket)
    {
        [self OnSupport:musicData.musiceId ticket:1];
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"firstVoteDialog"] == nil)
        {
            [self firstVoteDialog:musicData.musiceId];
            [defaults setObject:@"YES" forKey:@"firstVoteDialog"];
            [defaults synchronize];
            return;
        }
        [self OnSupport:musicData.musiceId ticket:1];
    }
   
    

}

//批量点歌
- (void)moreVoteDialog:(NSInteger)musiceId musicName:(NSString *)musicName
{
    if (self.rootViewController == nil)
    {
        return;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    _voteDialog = [[EWPSimpleDialog alloc] initWithFrame:CGRectMake(0, 0, 270, 190)];
    _voteDialog.layer.borderColor = [UIColor whiteColor].CGColor;
    _voteDialog.backgroundColor = [UIColor whiteColor];
    _voteDialog.layer.cornerRadius = 4.0f;
    _voteDialog.layer.borderWidth = 1.0f;
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(225, 5, 40, 40)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeDialog) forControlEvents:UIControlEventTouchUpInside];
    [_voteDialog addSubview:closeBtn];
    
    UILabel *musicNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 18, 200, 15)];
    musicNameLabel.text = [NSString stringWithFormat:@"歌单 ：%@",musicName];
    musicNameLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    musicNameLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [_voteDialog addSubview:musicNameLabel];
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 232, 0.5)];
    lineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [_voteDialog addSubview:lineImg];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 65, 200, 20)];
    titleLabel.text = @"100 热币/票";
    titleLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [_voteDialog addSubview:titleLabel];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleLabel.text];
    [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"f7c250"] range:NSMakeRange(0,3)];
    UIFont *font = [UIFont boldSystemFontOfSize:15.0f];
    [str addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,3)];
    [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"575757"] range:NSMakeRange(3,4)];
    titleLabel.attributedText = str;
    
    UILabel *voteNum = [[UILabel alloc] initWithFrame:CGRectMake(20, 95, 90, 20)];
    voteNum.text = @"投票数量：";
    voteNum.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    voteNum.font = [UIFont systemFontOfSize:14.0f];
    [_voteDialog addSubview:voteNum];
    
    UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reduceBtn.frame = CGRectMake(95, 92, 26, 26);
    reduceBtn.tag = 89;
    [reduceBtn setImage:[UIImage imageNamed:@"reduction"] forState:UIControlStateNormal];
    [reduceBtn setImage:[UIImage imageNamed:@"reduction_select"] forState:UIControlStateHighlighted];
    [reduceBtn addTarget:self action:@selector(changeNumber:) forControlEvents:UIControlEventTouchUpInside];
    [_voteDialog addSubview:reduceBtn];
    

    _ticketNumTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(125, 95, 70, 19)];
    _ticketNumTextFiled.backgroundColor = [CommonFuction colorFromHexRGB:@"e4e4e4"];
    _ticketNumTextFiled.text = @"10";
    _ticketNumTextFiled.font = [UIFont systemFontOfSize:14.0f];
    _ticketNumTextFiled.textAlignment = NSTextAlignmentCenter;
    _ticketNumTextFiled.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    _ticketNumTextFiled.delegate = self;
    _ticketNumTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    [_voteDialog addSubview:_ticketNumTextFiled];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(198, 92, 26, 26);
    addBtn.tag = 90;
    [addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"add_select"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(changeNumber:) forControlEvents:UIControlEventTouchUpInside];
    [_voteDialog addSubview:addBtn];
    
    
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(149, 32)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(149, 32)];
    
    EWPButton *supportBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    supportBtn.frame = CGRectMake(61, 135, 149, 32);
    supportBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [supportBtn setTitle:@"支持TA" forState:UIControlStateNormal];
    [supportBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [supportBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    supportBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [supportBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    [supportBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    supportBtn.layer.cornerRadius = 16.0f;
    supportBtn.layer.borderWidth = 1;
    supportBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    supportBtn.buttonBlock = ^(id sender)
    {
        NSInteger monthNum = [_ticketNumTextFiled.text integerValue];
        if (monthNum <= 0 || monthNum > 10000)
        {
            [_ticketNumTextFiled resignFirstResponder];
            [self.rootViewController showNoticeInWindow:@"投票数量不能等于0或者大于10000"];
            return;
        }

        [self OnSupport:musiceId ticket:[_ticketNumTextFiled.text integerValue]];
    };
    [_voteDialog addSubview:supportBtn];
    
    [_voteDialog showInView:self.rootViewController.view];
}

//第一次投票
- (void)firstVoteDialog:(NSInteger)musiceId
{
    if (self.rootViewController == nil)
    {
        return;
    }
    _voteDialog = [[EWPSimpleDialog alloc] initWithFrame:CGRectMake(0, 0, 270, 125)];
    _voteDialog.layer.borderColor = [UIColor whiteColor].CGColor;
    _voteDialog.backgroundColor = [UIColor whiteColor];
    _voteDialog.layer.cornerRadius = 4.0f;
    _voteDialog.layer.borderWidth = 1.0f;
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(225, 5, 40, 40)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeDialog) forControlEvents:UIControlEventTouchUpInside];
    [_voteDialog addSubview:closeBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 18, 200, 15)];
    titleLabel.text = @"投票X1 消耗100热币";
    titleLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [_voteDialog addSubview:titleLabel];
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 50, 240, 0.5)];
    lineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [_voteDialog addSubview:lineImg];
    
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(149, 32)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(149, 32)];
    
    EWPButton *supportBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    supportBtn.frame = CGRectMake(61, 70, 149, 32);
    [supportBtn setTitle:@"支持TA" forState:UIControlStateNormal];
    [supportBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [supportBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    supportBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [supportBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    [supportBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    supportBtn.layer.cornerRadius = 16.0f;
    supportBtn.layer.borderWidth = 1;
    supportBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    supportBtn.buttonBlock = ^(id sender)
    {
        [self OnSupport:musiceId ticket:1];
    };
    [_voteDialog addSubview:supportBtn];
    
    [_voteDialog showInView:self.rootViewController.view];
}


- (void)closeDialog
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ReLogin" object:self];

    [_ticketNumTextFiled resignFirstResponder];
    if (_voteDialog)
    {
        [_voteDialog hide];
    }
  
}

//支持dialog
- (void)OnSupport:(NSInteger)musiceId ticket:(NSInteger)ticketNum
{
    ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)self.rootViewController;
    if (chatRoomViewController == nil)
    {
        return;
    }
    [self closeDialog];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:musiceId] forKey:@"musicid"];
    [dict setObject:[NSNumber numberWithInteger:ticketNum]  forKey:@"num"];
    
    ChoseMusicModel *model = [[ChoseMusicModel alloc] init];
    [model requestDataWithParams:dict success:^(id object) {
        if (model.result == 0)
        {
            self.havefreeTicket = NO;
            for (MusicData *musicData in _musicAry)
            {
                if (musicData.musiceId == model.musicId)
                {
                    musicData.ticket = model.ticketNum;
                    break;
                }
            }

            [UserInfoManager shareUserInfoManager].currentUserInfo.coin = model.coin;
            _coinCount.text = [NSString stringWithFormat:@"%lld",model.coin];
            [self.tableView reloadData];
        }
        else
        {
            if ([model.msg isEqualToString:@"用户热币不足"])
            {
                [chatRoomViewController showRechargeDialog];
            }
            else
            {
                [self.rootViewController showNoticeInWindow:model.msg];
            }
        }

    } fail:^(id object) {
        
    }];
    
}

- (void)changeNumber:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == 89)
    {
        NSInteger monthNum = [_ticketNumTextFiled.text integerValue];
        if (monthNum <= 10)
        {
            return;
        }
        monthNum -= 10;
        _ticketNumTextFiled.text = [NSString stringWithFormat:@"%ld",(long)monthNum];
    }
    else
    {
        NSInteger monthNum = [_ticketNumTextFiled.text integerValue];
        monthNum += 10;
        _ticketNumTextFiled.text = [NSString stringWithFormat:@"%ld",(long)monthNum];
    }
}

- (void)setHavefreeTicket:(BOOL)havefreeTicket
{
    _havefreeTicket = havefreeTicket;
    if (havefreeTicket)
    {
        _volueTitle.text = @"您有1张免费点歌券未使用，长按投票可批量送出";
        _volueTitle.textColor = [CommonFuction colorFromHexRGB:@"ed9936"];
        _volueImgView.image = [UIImage imageNamed:@"unused"];
    }
    else
    {
        _volueTitle.text = @"免费点歌券已使用！";
        _volueTitle.textColor = [CommonFuction colorFromHexRGB:@"acacac"];
        _volueImgView.image = [UIImage imageNamed:@"used"];
    }
}

#pragma mark - keyboardObserver
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
  
    CGFloat nYOffset = 0;
    CGRect frame = _voteDialog.frame;
    nYOffset = frame.origin.y + frame.size.height - keyboardRect.origin.y;
    if (nYOffset > 5)
    {
        nYOffset +=5;
        [self moveInputBarWithKeyboardHeight:-nYOffset withDuration:animationDuration];
    }
 
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    CGFloat nYOffset = 0;
    CGRect frame = _voteDialog.frame;
    nYOffset = frame.origin.y + frame.size.height - keyboardRect.origin.y;
    if (nYOffset > 5)
    {
        nYOffset +=5;
        [self moveInputBarWithKeyboardHeight:nYOffset withDuration:animationDuration];
    }
}

- (void)moveInputBarWithKeyboardHeight:(float)keyboardHeight withDuration:(NSTimeInterval)animationDuration
{
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        CGRect frame = _voteDialog.frame;
        frame.origin.y += keyboardHeight;
        _voteDialog.frame = frame;
    } completion:^(BOOL finished) {
    }];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
