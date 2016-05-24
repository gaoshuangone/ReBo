//
//  VipSofaView.m
//  BoXiu
//
//  Created by 李杰 on 15/7/16.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "SheetView.h"
#import "MacroMethod.h"
#import "SheetButton.h"
#import "VipHeadView.h"
#import "ChooseBar.h"
#import "TableViewCell.h"
#import "UserInfoManager.h"
#import "RoomFansViewController.h"
#import "UserInfo.h"
#import "SofaListModel.h"
#import "UserInfoManager.h"
#import "SofaCell.h"
#import "LiveRoomViewController.h"
#import "FansCell.h"
#import "FansRankModel.h"
#import "GiftRankModel.h"
#import "GiftRankCell.h"


#define SHEET_VIEW_WIDTH    284     /**<标签栏宽度*/
#define FANS_TABLEVIEW      233     /**<粉丝榜界面*/
#define SUPER_VTEW          244     /**<超级榜界面*/
#define STAR_VIEW           255     /**<抢星榜界面*/
#define FANS_Cell_ID        @"fansCell" /**<本场粉丝cell*/



#define HideChatTag         10000
#define ShowBarrageTag      10001
#define AudioModeTag        10002


#define SofaBeginTag        100

@interface SheetView()<ChooseBarDelegate, VipHeadViewDelegate, BaseTableViewDataSoure, BaseTableViewDelegate>

@property (strong, nonatomic) UIButton *hideButton;     /**<隐藏聊天按钮*/
@property (strong, nonatomic) UIButton *danMuButton;    /**<弹幕展示按钮*/
@property (strong, nonatomic) UIButton *audioButton;    /**<音频模式按钮*/
@property (strong, nonatomic) BaseTableView *fansTableView ;
@property (strong, nonatomic) BaseTableView *superTableView;
@property (strong, nonatomic) BaseTableView *starTableView ;
@property (strong, nonatomic) UIScrollView *vipRoomScrollView;
@property (strong, nonatomic) ChooseBar   *chooseBar;
@property (nonatomic,assign) BOOL refreshing;//正在刷新数据

@property (nonatomic,strong) NSMutableArray *fansDataMArray;
@property (nonatomic,strong) NSMutableArray *superDataMArray;
@property (nonatomic,strong) NSMutableArray *starDataMArray;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView* imageViewIndictorView;
@property (nonatomic, strong) UILabel *remarkLabel;

@end

@implementation SheetView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
    }
    return self;
}

+(instancetype)shareRoomSettingView
{
    static SheetView *sharedRoomSettingView = nil;
    static dispatch_once_t roomSettingView;
    dispatch_once(&roomSettingView,^{
        sharedRoomSettingView = [[self alloc]init];
    });
    return sharedRoomSettingView;
}

-(void)initSheetView
{
    switch (self.enterType) {
        case EnterTypeVipSofa:
            [self createVipSofaView];
            
            break;
        case EnterTypeRoomSetting:
            [self createRoomSettingView];
            break;
        case EnterTypeRank:
            [self createRankView];
            break;
        default:
            break;
    }
    
}

- (void)initSofaList
{
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    
    NSMutableAttributedString * titleString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@的贵宾席", starInfo.nick]];
    [titleString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, titleString.length - 4)];
    NSLog(@"%lu",(unsigned long)titleString.length);
    [titleString addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"F7C250"] range:NSMakeRange(0, titleString.length - 4)];
    [titleString addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"A4A4A4"] range:NSMakeRange(titleString.length - 4, 3)];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.attributedText = titleString;
    
    SofaListModel *model = [[SofaListModel alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:starInfo.roomid] forKey:@"roomid"];
    [model requestDataWithParams:param success:^(id object) {
        [self performSelectorOnMainThread:@selector(updateSofaData:) withObject:object waitUntilDone:NO];
    } fail:^(id object) {
        EWPLog(@"initsofalist fail");
    }];
    
}

//- (void)getRoomRankData;
//{
//    if (!self.refreshing && _superDataMArray)
//    {
//        [self.tableView reloadData];
//        return;
//    }
//    self.tipLabel.hidden = YES;
//    NSString *method = getFansRank_Method;
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.roomid] forKey:@"roomid"];
//    [params setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];
//    [self startAnimating];
//    FansRankModel *fansModel = [[FansRankModel alloc] init];
//    [fansModel requestDataWithMethod:method params:params success:^(id object) {
//        if (fansModel.result == 0)
//        {
//            if (_superDataMArray == nil)
//            {
//                _superDataMArray = [NSMutableArray array];
//            }
//            if (fansModel.fansUserMArray)
//            {
//                if (self.refreshing)
//                {
//                    [_superDataMArray removeAllObjects];
//                    self.refreshing = NO;
//                }
//                
//                [_superDataMArray addObjectsFromArray:fansModel.fansUserMArray];
//                [self.tableView reloadData];
//                if (_superDataMArray.count == 0)
//                {
//                    self.tipLabel.hidden = NO;
//                }
//                else
//                {
//                    self.tipLabel.hidden = YES;
//                }
//            }
//            else
//            {
//                self.tipLabel.hidden = NO;
//            }
//        }
//        [self stopAnimating];
//    } fail:^(id object) {
//        [self.tableView reloadData];
//        [self stopAnimating];
//    }];
//}

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
    if ([model.sofaMArray count]==0) {
        
        for (int nIndex = 0; nIndex < 4; nIndex++){
        VipHeadView *imageView = (VipHeadView *)[self viewWithTag:SofaBeginTag + nIndex + 1 - 1];
        SofaData *sofaData = [[SofaData alloc] init];
        sofaData.sofano = nIndex + 1;
        sofaData.coin = 100;
        sofaData.num = 0;
            sofaData.hidden = 2;
         
        imageView.data = sofaData;
        }
        
    }
    
    

    
   
}

//- (void)setSofaData:(SofaData *)data;
//{
//    
//}

#pragma mark - VipHeadViewDelegate
- (void)didSelectedCell:(VipHeadView *)vipHeadView
{
    LiveRoomViewController *lr = (LiveRoomViewController *)self.rootViewController;
    [lr selecteSofaData:vipHeadView.data];
}

#pragma mark -贵宾席界面
-(void)createVipSofaView
{

   // UILabel *titleLabel  = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 60, 15, 120, 20)];

    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 18, self.frame.size.width, 20)];

    titleLabel.textColor = [CommonFuction colorFromHexRGB:@"a4a4a4"];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = @"--的贵宾席";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    self.titleLabel = titleLabel;

    
    
    
    for (int nIndex = 0; nIndex < 4; nIndex++)
    {
        VipHeadView *imageView  = [[VipHeadView alloc]initWithFrame:CGRectMake(12 + 70 * nIndex,  48, 53, 160)];
        imageView.tag = SofaBeginTag + nIndex;
        imageView.delegate = self;
        
        SofaData *sofaData = [[SofaData alloc] init];
        sofaData.sofano = nIndex + 1;
        sofaData.coin = 100;
        sofaData.num = 0;
        imageView.data = sofaData;
        
        [self addSubview:imageView];
    }

}

- (void)setSofaData:(SofaData *)sofaData
{
    
    if (sofaData)
    {

        VipHeadView *view = (VipHeadView *)[self viewWithTag:SofaBeginTag + sofaData.sofano - 1];
        view.data = sofaData;
        
        UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        
        if (sofaData.userid == userInfo.userId)
        {
//            self.bRobbingSofa = NO;
        }
    }
}

#pragma mark -房间设置界面
-(void)createRoomSettingView
{
    UILabel *hideChatLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 30)];
    hideChatLabel.text = @"隐藏聊天";
    hideChatLabel.font = [UIFont systemFontOfSize:16];
    hideChatLabel.textColor = [CommonFuction colorFromHexRGB:@"454A4D"];
   
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50, self.frame.size.width - 43, 0.5)];
    line1.backgroundColor = [CommonFuction colorFromHexRGB:@"E2E2E2"];
    
    UILabel *showDanMuLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 60, 100, 30)];
    showDanMuLabel.text = @"隐藏弹幕";
    showDanMuLabel.font = [UIFont systemFontOfSize:16];
    showDanMuLabel.textColor = [CommonFuction colorFromHexRGB:@"454A4D"];
    
    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100, self.frame.size.width - 43, 0.5)];
    line2.backgroundColor = [CommonFuction colorFromHexRGB:@"E2E2E2"];
    
    UILabel *AudioLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 110, 100, 30)];
    AudioLabel.text = @"音频模式";
    AudioLabel.font = [UIFont systemFontOfSize:16];
    AudioLabel.textColor = [CommonFuction colorFromHexRGB:@"454A4D"];
    
    [self addSubview:hideChatLabel];
    [self addSubview:showDanMuLabel];
    [self addSubview:AudioLabel];
    [self addSubview:line1];
    [self addSubview:line2];
    [self createButtons];
}


-(void)createButtons
{
    SheetButton *hideButton = [[SheetButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 60-10, 10, 50, 30)];
    hideButton.tag = HideChatTag;
    SheetButton *showDanmuButton = [[SheetButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 60-10, 60, 50, 30)];
    showDanmuButton.tag = ShowBarrageTag;
    SheetButton *audioButton = [[SheetButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 60-10, 110, 50, 30)];
    audioButton.tag = AudioModeTag;

    hideButton.type      = ButtonTypeChat;
    showDanmuButton.type = ButtonTypeDanmu;
    audioButton.type     = ButtonTypeAudio;
    
    
    
    [hideButton      loadFrame];
    [showDanmuButton loadFrame];
    [audioButton     loadFrame];
    
    [hideButton      addTarget:self action:@selector(hideButtonDidClicked:)  forControlEvents:UIControlEventTouchUpInside];
    [showDanmuButton addTarget:self action:@selector(DanmuButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [audioButton     addTarget:self action:@selector(AudioButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:hideButton];
    [self addSubview:showDanmuButton];
    [self addSubview:audioButton];
    
    hideButton.clicked = NO;
    showDanmuButton.clicked = NO;
    audioButton.clicked = NO;

}
#pragma mark 点击隐藏聊天按钮
-(void)hideButtonDidClicked:(SheetButton *)button
{

    [self buttonAnimationWithButton:button];

}

#pragma mark 点击弹幕展示按钮
-(void)DanmuButtonDidClicked:(SheetButton *)button
{

    [self buttonAnimationWithButton:button];

//    [[NSUserDefaults standardUserDefaults]setBool:button.clicked forKey:@"hideDanmu"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark 点击音频模式按钮
-(void)AudioButtonDidClicked:(SheetButton *)button
{
    
    [self buttonAnimationWithButton:button];
}

-(void)buttonAnimationWithButton:(SheetButton *)button
{
    LiveRoomViewController *lr = (LiveRoomViewController *)self.rootViewController;
    
    
    switch (button.type) {
        case ButtonTypeChat:
        {

            button.clicked = !button.clicked;
            lr.hideChat = button.clicked;
            if(button.clicked)
            {
                [lr showNoticeInWindow:@"聊天信息已隐藏"];
            }
            else
            {
                [lr showNoticeInWindow:@"聊天信息已显示"];
            }
        }break;
        case ButtonTypeDanmu:
        {
            button.clicked = !button.clicked;
            lr.hideBarrage = button.clicked;
//            [self changeButtonState:button];
            
            if(button.clicked)
            {
                [lr showNoticeInWindow:@"弹幕已隐藏"];
            }
            else
            {
                [lr showNoticeInWindow:@"弹幕已显示"];
            }
            
        }break;
            case ButtonTypeAudio:
        {
            if (lr.phoneLiving)
            {
                [lr showNoticeInWindow:@"手机开播中,不能切换音频模式"];
                return;
            }
            
            StarInfo *starInfo =  [UserInfoManager shareUserInfoManager].currentStarInfo;
            if (starInfo)
            {
                if (!starInfo.onlineflag || !lr.isZhiBoIng)
                {
                    [lr showNoticeInWindow:@"Star未开播,不能切换音频模式"];
                    return;
                }
                button.clicked = !button.clicked;
//                [self changeButt多发点onState:button];
                [lr changePlayMode:!button.clicked];//切换音视频模式
                lr.audioMode = button.clicked;
                
                if (button.clicked)
                {
                    [lr showNoticeInWindow:@"切换为音频模式"];
                }
                else
                {
                    [lr showNoticeInWindow:@"切换为视频模式"];
                }
                
            }
            

        }break;
        default:
            break;
    }
    
    
}

-(void)changeButtonState:(SheetButton *)button
{
        if (button.clicked) {
            [UIView animateWithDuration:.5f animations:^{
                button.point.center = CGPointMake(button.frame.size.width - 10, button.frame.size.height/2);
                button.yellowButtonAboveView.alpha = 1;
            }];
        }
        else
        {
            [UIView animateWithDuration:.5f animations:^{
                button.point.frame = CGRectMake(0, button.frame.size.height/2 - 10, 20, 20);
                button.yellowButtonAboveView.alpha = 0;
            }];
        }
}

- (void)buttonAction:(SheetButton *)button
{
    LiveRoomViewController *lr = (LiveRoomViewController *)self.rootViewController;
    button.clicked = !button.clicked;
    switch (button.tag)
    {
        case HideChatTag:
            lr.hideChat = button.clicked;
            break;
        case ShowBarrageTag:
        {
            
        }
            lr.hideBarrage = button.clicked;
            break;
        case AudioModeTag:
        {
            lr.audioMode = button.clicked;
            
        }
            
            break;
        default:
            break;
    }
}

#pragma mark -榜单界面
-(void)createRankView
{
    _chooseBar = [[ChooseBar alloc] initWithFrame:CGRectMake(0, 10, SHEET_VIEW_WIDTH, 42)];
    _chooseBar.delegate = self;
    _chooseBar.stringArray = [[NSMutableArray alloc] initWithArray: @[@"本场粉丝",@"超级榜",@"抢星榜"]];
    _chooseBar.selectedIndex = 0;
    [self addSubview:_chooseBar];
    
    _vipRoomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 42+10, SHEET_VIEW_WIDTH,self.frame.size.height - 42 )];
    _vipRoomScrollView.delegate = self;
    _vipRoomScrollView.pagingEnabled = YES;
    _vipRoomScrollView.bounces = NO;
    _vipRoomScrollView.contentSize = CGSizeMake(SHEET_VIEW_WIDTH * 3, self.frame.size.height - 42);
    
    [self  initFansTableView];
    [self initSuperTableView];
    [self  initStarTableView];
    
    [_vipRoomScrollView addSubview:_fansTableView];
    [_vipRoomScrollView addSubview:_superTableView];
    [_vipRoomScrollView addSubview:_starTableView];
    
    [self addSubview:_vipRoomScrollView];
}

- (void)getRoomRankData;
{
    
    if (self.chooseBar.selectedIndex == 0)
    {
        if (!self.refreshing && [_fansDataMArray count])
        {
            [_fansTableView reloadData];
            return;
        }
//        self.tipLabel.hidden = YES;
        NSString *method = getFansRank_Method;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.roomid] forKey:@"roomid"];
        [params setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];
//            [self startAnimating];
        FansRankModel *fansModel = [[FansRankModel alloc] init];
        [fansModel requestDataWithMethod:method params:params success:^(id object) {
            if (fansModel.result == 0)
            {
                if (_fansDataMArray == nil)
                {
                    _fansDataMArray = [NSMutableArray array];
                }
                if (fansModel.fansUserMArray)
                {
                    if (self.refreshing)
                    {
                        [_fansDataMArray removeAllObjects];
                        self.refreshing = NO;
                    
                    }
                    
                    [_fansDataMArray addObjectsFromArray:fansModel.fansUserMArray];
                    
//                    if (_fansDataMArray.count == 0)
//                    {
//                        self.tipLabel.hidden = NO;
//                    }
//                    else
//                    {
//                        self.tipLabel.hidden = YES;
//                    }
                }
                else
                {
//                    self.tipLabel.hidden = NO;
                }
                [_fansTableView reloadData];
              
            }
            [self stopAnimating];
        } fail:^(id object) {
            [_fansTableView reloadData];
            [self stopAnimating];
        }];
    }
    else if (self.chooseBar.selectedIndex == 1)
    {
        if (!self.refreshing && [_superDataMArray count])
        {
            [_superTableView reloadData];
            return;
        }
        
//        self.tipLabel.hidden = YES;
        
        NSString *method = getFansRankMonth_Method;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.roomid] forKey:@"roomid"];
        
//        [self startAnimating];
        FansRankModel *fansModel = [[FansRankModel alloc] init];
        [fansModel requestDataWithMethod:method params:params success:^(id object) {
            if (fansModel.result == 0)
            {
                if (_superDataMArray == nil)
                {
                    _superDataMArray = [NSMutableArray array];
                }
                
                if (fansModel.fansUserMArray)
                {
                    if (self.refreshing)
                    {
                        [_superDataMArray removeAllObjects];
                        self.refreshing = NO;
                    }
                    
                    [_superDataMArray addObjectsFromArray:fansModel.fansUserMArray];

//                    if (_superDataMArray.count == 0)
//                    {
//                        self.tipLabel.hidden = NO;
//                    }
//                    else
//                    {
//                        self.tipLabel.hidden = YES;
//                    }
                    
                }
                else
                {
//                    self.tipLabel.hidden = NO;
                }
                [_superTableView reloadData];
            }
            [self stopAnimating];
        } fail:^(id object) {
            [_superTableView reloadData];
            [self stopAnimating];
        }];
    }
    else if (self.chooseBar.selectedIndex == 2)
    {
        if (!self.refreshing && [_starDataMArray count])
        {
            [_starTableView reloadData];
            return;
        }
        
//        self.tipLabel.hidden = YES;
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];
        
//        [self startAnimating];
        GiftRankModel *model = [[GiftRankModel alloc] init];
        [model requestDataWithParams:params success:^(id object) {
            GiftRankModel *model  = (GiftRankModel *)object;
            if (model.result == 0)
            {
                if (_starDataMArray == nil)
                {
                    _starDataMArray = [NSMutableArray array];
                }
                if (model.starUserMArray)
                {
                    if (self.refreshing)
                    {
                        [_starDataMArray removeAllObjects];
                        self.refreshing = NO;
                    }
                    
                    [_starDataMArray addObjectsFromArray:model.starUserMArray];
                    
//                    if (_starDataMArray.count == 0)
//                    {
//                        self.tipLabel.hidden = NO;
//                    }
//                    else
//                    {
//                        self.tipLabel.hidden = YES;
//                    }
                }
                else
                {
//                    self.tipLabel.hidden = NO;
                }
                
                [_starTableView reloadData];
                
            }
            [self stopAnimating];
            
        } fail:^(id object) {
            /*失败返回数据*/
//            [self.tableView reloadData];
            [self stopAnimating];
            [_starTableView reloadData];
        }];
    }
    
    
}

- (void)refreshData
{
    self.refreshing = YES;
    
    if (self.chooseBar.selectedIndex == 0 && self.fansDataMArray.count==0) {
           [self startAnimating];
    }
    if (self.chooseBar.selectedIndex == 2 && self.superDataMArray.count==0) {
        [self startAnimating];
    }
    if (self.chooseBar.selectedIndex == 3 && self.starDataMArray.count==0) {
        [self startAnimating];
    }
 
    [self getRoomRankData];
}
#pragma mark - 请求数据时候动画

- (void)startAnimating
{

    [self bringSubviewToFront:_imageViewIndictorView];
    
    if (_imageViewIndictorView) {
        _imageViewIndictorView.hidden = YES;
        return;
    }
         NSArray *imageNames = [NSArray arrayWithObjects:@"01JZ.png", @"02JZ.png", @"03JZ.png", @"04JZ.png", @"05JZ.png", @"06JZ.png", @"07JZ.png", @"08JZ.png", @"09JZ.png", @"10JZ.png", @"11JZ.png", @"12JZ.png", @"13JZ.png", @"14JZ.png", @"15JZ.png", @"16JZ.png", @"17JZ.png", @"18JZ.png", @"19JZ.png", @"20JZ.png",nil];
    
    NSMutableArray* array = [NSMutableArray array];
    for (NSString *name in imageNames) {
        [ array addObject:[UIImage imageNamed:name]];
    }
    
    if (_imageViewIndictorView==nil) {
        _imageViewIndictorView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 38+50)];
        _imageViewIndictorView.contentMode = UIViewContentModeTop;
//      (0, 42+10, SHEET_VIEW_WIDTH,self.frame.size.height - 42 )
        _imageViewIndictorView.animationImages = array;
        _imageViewIndictorView.animationDuration = 1;
        _imageViewIndictorView.animationRepeatCount = 100;
        _imageViewIndictorView.center = CGPointMake(self.frameWidth/2, 42+10+(self.frame.size.height - 42-20)/2);
        [_imageViewIndictorView startAnimating];
        
        self.remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 38+5, 110, 20)];
        self.remarkLabel.textColor = [CommonFuction colorFromHexRGB:@"959596"];
        self.remarkLabel.font = [UIFont systemFontOfSize:15];
        self.remarkLabel.text = @"loading...";
        self.remarkLabel.textAlignment = NSTextAlignmentCenter;
        [_imageViewIndictorView addSubview:self.remarkLabel];
        
    }
    

    [self addSubview:_imageViewIndictorView];
    
    
    //    if (_activityIndicatorView == nil)
    //    {
    //        _activityIndicatorView = [[EWPActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //        _activityIndicatorView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //
    //
    //    }
    //
    //
    //    [self.view addSubview:_activityIndicatorView];
    //
    //    [_activityIndicatorView startAnimating];
}

- (void)stopAnimating
{
    if (_imageViewIndictorView) {
        [_imageViewIndictorView removeFromSuperview];
        _imageViewIndictorView = nil;
    }
    
    //    if (_activityIndicatorView)
    //    {
    //        [_activityIndicatorView stopAnimating];
    //        _activityIndicatorView = nil;
    //    }
}

-(void)initFansTableView
{
    
//    self.tableView.frame =  CGRectZero;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.baseDataSource = self;
//    self.tableView.baseDelegate = self;
//    self.loadMore = NO;
//    self.tableView.backgroundColor = [UIColor clearColor];
    
    _fansTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 42-22)];//粉丝榜单
    [_fansTableView registerClass:[TableViewCell class] forCellReuseIdentifier:FANS_Cell_ID];
    _fansTableView.baseDelegate   = self;
    _fansTableView.baseDataSource = self;
     _fansTableView.tipContent.frame = CGRectMake(0, (self.frame.size.height - 64 - 20) / 2, self.frame.size.width, 20);
    _fansTableView.tag        = FANS_TABLEVIEW;
    _fansTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _fansTableView.loadMore = NO;
    _fansTableView.showsVerticalScrollIndicator = NO;
}

-(void)initSuperTableView
{
    _superTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(SHEET_VIEW_WIDTH, 0, self.frame.size.width, self.frame.size.height - 42-22)];//超级榜单
    _superTableView.backgroundColor = [UIColor clearColor];
    _superTableView.baseDelegate   = self;
    _superTableView.baseDataSource = self;
    _superTableView.tipContent.frame = CGRectMake(0, (self.frame.size.height - 64 - 20) / 2, self.frame.size.width, 20);
    _superTableView.tag        = SUPER_VTEW;
    _superTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _superTableView.loadMore = NO;
    _superTableView.showsVerticalScrollIndicator = NO;
}

-(void)initStarTableView
{
    _starTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(SHEET_VIEW_WIDTH * 2, 0, self.frame.size.width, self.frame.size.height - 42-22)];//抢星榜单
    _starTableView.backgroundColor = [UIColor clearColor];
    _starTableView.baseDelegate   = self;
    _starTableView.baseDataSource = self;
     _starTableView.tipContent.frame = CGRectMake(0, (self.frame.size.height - 64 - 20) / 2, self.frame.size.width, 20);
    _starTableView.tag        = STAR_VIEW;
    _starTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _starTableView.loadMore = NO;
    _starTableView.showsVerticalScrollIndicator = NO;
}

#pragma mark - ChooseBarDelegate
- (void)chooseBar:(ChooseBar *)chooseBar didSelectIndex:(NSInteger)index
{
    if (chooseBar.selectedIndex == 0) {
        [_vipRoomScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if (chooseBar.selectedIndex == 1)
    {
        [_vipRoomScrollView setContentOffset:CGPointMake(SHEET_VIEW_WIDTH, 0) animated:YES];
    }
    else
    {
        [_vipRoomScrollView setContentOffset:CGPointMake(SHEET_VIEW_WIDTH * 2, 0) animated:YES];
    }
    
    [self refreshData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    CGFloat pageWidth = _vipRoomScrollView.frame.size.width;
    int page = floor((_vipRoomScrollView.contentOffset.x - pageWidth / 3) / pageWidth) + 1;
    switch (page)
    {
        case 0:
        {
            _vipRoomScrollView.contentOffset = CGPointMake(0, 0);
            [_chooseBar setSelectedIndex:0 animated:YES];
        }
            break;
        case 1:
        {
            _vipRoomScrollView.contentOffset = CGPointMake(SHEET_VIEW_WIDTH, 0);
            [_chooseBar setSelectedIndex:1 animated:YES];
            
        }
            break;
        case 2:
        {
            _vipRoomScrollView.contentOffset = CGPointMake(SHEET_VIEW_WIDTH * 2, 0);
            [_chooseBar setSelectedIndex:2 animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark tableViewDelegate

#pragma mark tableViewDataSource

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    int i = 0;
//    switch (tableView.tag) {
//        case FANS_TABLEVIEW:
//            i = 4;
//            break;
//        case SUPER_VTEW:
//            i = 0;
//        case STAR_VIEW:
//            i = 0;
//        default:
//            break;
//    }
//    return i;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (tableView.tag == FANS_TABLEVIEW){
//    TableViewCell *fansCell = [tableView dequeueReusableCellWithIdentifier:FANS_Cell_ID forIndexPath:indexPath];
//    fansCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        fansCell.medal.image = [UIImage imageNamed:[NSString stringWithFormat:@"rank_%d",indexPath.row]];
//    return  fansCell;
//    }
//    else return nil;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 65;
//}

#pragma mark - UITalbeViewDataSurce

- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return 1;
}

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger nCount = 0;
    if (baseTableView == _fansTableView)
    {
        if (_fansDataMArray)
        {
            nCount = _fansDataMArray.count + 1;
        }
    }
    else if (baseTableView == _superTableView)
    {
        if (_superTableView)
        {
            nCount = _superDataMArray.count + 1;
        }
    }
    else if (baseTableView == _starTableView)
    {
        if (_starTableView)
        {
            nCount = _starDataMArray.count + 1;
        }
    }
    if (nCount <= 1)
    {
//        baseTableView.tipContent.text = @"暂无数据";
        baseTableView.tipLabel.hidden = NO;
//        baseTableView.contentImg.image= [UIImage imageNamed:@"contentImg"];
//        baseTableView.tipContent2.text = @"下拉刷新看看";
//        baseTableView.updateView.image = [UIImage imageNamed:@"update"];

    }
    else
    {
//        baseTableView.tipContent.text = nil;
           baseTableView.tipLabel.hidden = YES;
//        baseTableView.contentImg.image= [UIImage imageNamed:@""];
//        baseTableView.tipContent2.text = nil;
//        baseTableView.updateView.image = [UIImage imageNamed:@""];
    }
    return nCount;
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = nil;
    if (baseTableView == _fansTableView)
    {
        static NSString *cellIdentifier =  @"cellIdentifier";
        static NSString *blankCellIdentifier = @"blankCellIdentifier";
        
        if (_fansDataMArray)
        {
            if (_fansDataMArray.count == indexPath.row)
            {
                //最后一个空白cell
                UITableViewCell *blankCell = [baseTableView dequeueReusableCellWithIdentifier:blankCellIdentifier];
                if (blankCell == nil)
                {
                    blankCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:blankCellIdentifier];
                    blankCell.backgroundColor = [UIColor clearColor];
                    blankCell.accessoryType = UITableViewCellAccessoryNone;
                    blankCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                cell = blankCell;
            }
            else
            {
                FansCell *fansCell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (fansCell == nil)
                {
                    fansCell = [[FansCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    fansCell.backgroundColor = [UIColor clearColor];
                    fansCell.accessoryType = UITableViewCellAccessoryNone;
                    fansCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                UserInfo *userInfo = [_fansDataMArray objectAtIndex:indexPath.row];
                fansCell.isThis = YES;
                fansCell.userInfo = userInfo;
                fansCell.rankIndex = indexPath.row;
                cell = fansCell;
            }
        }
        else
        {
            UITableViewCell *blankCell = [baseTableView dequeueReusableCellWithIdentifier:blankCellIdentifier];
            if (blankCell == nil)
            {
                blankCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:blankCellIdentifier];
                blankCell.backgroundColor = [UIColor clearColor];
                blankCell.accessoryType = UITableViewCellAccessoryNone;
                blankCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell = blankCell;
        }
    }
    else if (baseTableView == _superTableView)
    {
        static NSString *cellIdentifier =  @"cellIdentifier";
        static NSString *blankCellIdentifier = @"blankCellIdentifier";
        
        if (_superDataMArray )
        {
            if (_superDataMArray.count == indexPath.row)
            {
                //最后一个空白cell
                UITableViewCell *blankCell = [baseTableView dequeueReusableCellWithIdentifier:blankCellIdentifier];
                if (blankCell == nil)
                {
                    blankCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:blankCellIdentifier];
                    blankCell.backgroundColor = [UIColor clearColor];
                    blankCell.accessoryType = UITableViewCellAccessoryNone;
                    blankCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                cell = blankCell;
            }
            else
            {
                FansCell *fansCell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (fansCell == nil)
                {
                    fansCell = [[FansCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    fansCell.backgroundColor = [UIColor clearColor];
                    fansCell.accessoryType = UITableViewCellAccessoryNone;
                    fansCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                UserInfo *userInfo = [_superDataMArray objectAtIndex:indexPath.row];
                fansCell.isThis = NO;
                fansCell.userInfo = userInfo;
                fansCell.rankIndex = indexPath.row;
                cell = fansCell;
            }
        }
        else
        {
            UITableViewCell *blankCell = [baseTableView dequeueReusableCellWithIdentifier:blankCellIdentifier];
            if (blankCell == nil)
            {
                blankCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:blankCellIdentifier];
                blankCell.backgroundColor = [UIColor clearColor];
                blankCell.accessoryType = UITableViewCellAccessoryNone;
                blankCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell = blankCell;
        }
    }
    else
    {
        static NSString *cellIdentifier =  @"starCellIdentifier";
        static NSString *blankCellIdentifier = @"blankCellIdentifier";
        
        if (_starDataMArray )
        {
            if (_starDataMArray.count == indexPath.row)
            {
                //最后一个空白cell
                UITableViewCell *blankCell = [baseTableView dequeueReusableCellWithIdentifier:blankCellIdentifier];
                if (blankCell == nil)
                {
                    blankCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:blankCellIdentifier];
                    blankCell.backgroundColor = [UIColor clearColor];
                    blankCell.accessoryType = UITableViewCellAccessoryNone;
                    blankCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                cell = blankCell;
            }
            else
            {
                GiftRankCell *giftRankCell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (giftRankCell == nil)
                {
                    giftRankCell = [[GiftRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    giftRankCell.backgroundColor = [UIColor clearColor];
                    giftRankCell.accessoryType = UITableViewCellAccessoryNone;
                    giftRankCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                StarGift * starGift = [self.starDataMArray objectAtIndex:indexPath.row];
                giftRankCell.starGift = starGift;
                cell = giftRankCell;
            }
        }
        else
        {
            UITableViewCell *blankCell = [baseTableView dequeueReusableCellWithIdentifier:blankCellIdentifier];
            if (blankCell == nil)
            {
                blankCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:blankCellIdentifier];
                blankCell.backgroundColor = [UIColor clearColor];
                blankCell.accessoryType = UITableViewCellAccessoryNone;
                blankCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell = blankCell;
        }

    }
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
    CGFloat height = [FansCell height];
    if (baseTableView == _fansTableView)
    {
        height = [FansCell height];
        if (_fansDataMArray)
        {
            if (indexPath.row == _fansDataMArray.count)
            {
                height = 40;
            }
        }
        else
        {
            height = 40;
        }
    }
    else if (baseTableView == _superTableView)
    {
        if (_superDataMArray)
        {
            if (indexPath.row == _superDataMArray.count)
            {
                height = 40;
            }
        }
        else
        {
            height = 40;
        }
    }
    else
    {
        height = [GiftRankCell height];
        if (_starDataMArray)
        {
            if (indexPath.row == _starDataMArray.count)
            {
                height = 40;
            }
        }
        else
        {
            height = 40;
        }
    }
    return height;
}



//- (void)getRoomRankData;
//{
//    if (!self.refreshing && _dataMArray)
//    {
//        [self.tableView reloadData];
//        return;
//    }
//    self.tipLabel.hidden = YES;
//    NSString *method = getFansRank_Method;
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.roomid] forKey:@"roomid"];
//    [params setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];
//    [self startAnimating];
//    FansRankModel *fansModel = [[FansRankModel alloc] init];
//    [fansModel requestDataWithMethod:method params:params success:^(id object) {
//        if (fansModel.result == 0)
//        {
//            if (_dataMArray == nil)
//            {
//                _dataMArray = [NSMutableArray array];
//            }
//            if (fansModel.fansUserMArray)
//            {
//                if (self.refreshing)
//                {
//                    [_dataMArray removeAllObjects];
//                    self.refreshing = NO;
//                }
//                
//                [_dataMArray addObjectsFromArray:fansModel.fansUserMArray];
//                [self.tableView reloadData];
//                if (_dataMArray.count == 0)
//                {
//                    self.tipLabel.hidden = NO;
//                }
//                else
//                {
//                    self.tipLabel.hidden = YES;
//                }
//            }
//            else
//            {
//                self.tipLabel.hidden = NO;
//            }
//        }
//        [self stopAnimating];
//    } fail:^(id object) {
//        [self.tableView reloadData];
//        [self stopAnimating];
//    }];
//}



- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
