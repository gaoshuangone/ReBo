//
//  LiveRoomRightView.m
//  BoXiu
//
//  Created by andy on 15/6/11.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "LiveRoomRightView.h"
#import "SheetView.h"

#define SHEET_VIEW_HEIGHT 300 //SheetView高度
#define SHEET_VIEW_WIDTH  284
@interface LiveRoomRightView()

@property (nonatomic, assign) BOOL VipSofaViewShow;
@property (nonatomic, assign) BOOL RankViewShow;
@property (nonatomic, assign) BOOL RoomSettingViewShow;
@property (nonatomic, strong) SheetView *vipSofaView;
@property (nonatomic, strong) SheetView *rankView;
@property (nonatomic, strong) SheetView *roomSettingView;
@property (nonatomic, strong) EWPButton *vipSofaBtn;
@property (nonatomic, strong) EWPButton *rankBtn;
@property (nonatomic, strong) EWPButton *roomSettingBtn;


@end

@implementation LiveRoomRightView

- (void)initView:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    CGFloat offY = 140;
    _vipSofaBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _vipSofaBtn.frame = CGRectMake(SCREEN_WIDTH / 4 - 30, offY, 50, 50);
    [_vipSofaBtn setImage:[UIImage imageNamed:@"RoomVip_off.png"] forState:UIControlStateNormal];
    _vipSofaBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [_vipSofaBtn addTarget:self action:@selector(OnClickVipSofaBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_vipSofaBtn];
    
    UILabel *vipSofaLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 4 - 30+5, 190, 80, 20)];

    vipSofaLabel.text = @"贵宾席";
    vipSofaLabel.textColor = [UIColor whiteColor];
    vipSofaLabel.textAlignment = NSTextAlignmentCenter;
    vipSofaLabel.font = [UIFont italicSystemFontOfSize:14];
     vipSofaLabel.shadowColor = [UIColor colorWithWhite:1 alpha:0.25];
    [vipSofaLabel sizeToFit];
    [self addSubview:vipSofaLabel];
    
    _rankBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _rankBtn.frame = CGRectMake(SCREEN_WIDTH / 2 - 25, offY, 50, 50);
    [_rankBtn setImage:[UIImage imageNamed:@"RoomRank_off.png"] forState:UIControlStateNormal];
    _rankBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [_rankBtn addTarget:self action:@selector(OnClickRankBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rankBtn];
    
    UILabel *rankLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 25, 190, 80, 20)];
    rankLabel.center = CGPointMake(_rankBtn.center.x, 200);
    rankLabel.text = @"榜单";
     rankLabel.shadowColor = [UIColor colorWithWhite:1 alpha:0.25];
    rankLabel.textColor = [UIColor whiteColor];
    rankLabel.textAlignment = NSTextAlignmentCenter;
    rankLabel.font = [UIFont italicSystemFontOfSize:14];
    [self addSubview:rankLabel];
    
    _roomSettingBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _roomSettingBtn.frame = CGRectMake(SCREEN_WIDTH * 3 / 4 - 20, offY, 50, 50);

//    RoomSet_off
    [_roomSettingBtn setImage:[UIImage imageNamed:@"RoomSet_off.png"] forState:UIControlStateNormal];
    _roomSettingBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [_roomSettingBtn addTarget:self action:@selector(OnClickRoomSettingBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_roomSettingBtn];
    UILabel *roomSettingLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 3 / 4 - 20, 190, 80, 20)];
    roomSettingLabel.center = CGPointMake(_roomSettingBtn.center.x, 200);
    roomSettingLabel.text = @"房间设置";
    roomSettingLabel.shadowColor = [UIColor colorWithWhite:1 alpha:0.25];
    roomSettingLabel.textColor = [UIColor whiteColor];
    roomSettingLabel.textAlignment = NSTextAlignmentCenter;
    roomSettingLabel.font = [UIFont italicSystemFontOfSize:14];
    [self addSubview:roomSettingLabel];
    [self initVipSofaView];//初始化贵宾席
    [self initRankView];//初始化榜单
    [self initRoomSettingView];//初始化房间设置
    //加载上边对应数据
    [_vipSofaView     initSheetView];
    [_rankView        initSheetView];
    [_roomSettingView initSheetView];
}

- (void)initData
{
    [_vipSofaView initSofaList];
    [_rankView getRoomRankData];
}


- (void)updateSofaData:(SofaData *)sofaData
{
    [_vipSofaView setSofaData:sofaData];
}

- (void)setRootViewController:(BaseViewController *)rootViewController
{
    [super setRootViewController:rootViewController];
    _vipSofaView.rootViewController = self.rootViewController;
    _rankView.rootViewController = self.rootViewController;
    _roomSettingView.rootViewController = self.rootViewController;
}

-(void)initVipSofaView
{
    _vipSofaView = [[SheetView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - SHEET_VIEW_WIDTH) / 2, SCREEN_HEIGHT, SHEET_VIEW_WIDTH, 151 + 5)];
    _vipSofaView.enterType = EnterTypeVipSofa;
    _vipSofaView.backgroundColor = [UIColor whiteColor];
    _vipSofaView.rootViewController = self.rootViewController;
    [self addSubview:_vipSofaView];
}

-(void)initRankView
{
    _rankView = [[SheetView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - SHEET_VIEW_WIDTH) / 2, SCREEN_HEIGHT, SHEET_VIEW_WIDTH, SHEET_VIEW_HEIGHT + 5)];
    _rankView.enterType = EnterTypeRank;
    _rankView.backgroundColor = [UIColor whiteColor];
    _rankView.rootViewController = self.rootViewController;
    [self addSubview:_rankView];
}

-(void)initRoomSettingView
{
    _roomSettingView = [[SheetView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - SHEET_VIEW_WIDTH) / 2, SCREEN_HEIGHT, SHEET_VIEW_WIDTH, 151 + 5)];
    _roomSettingView.enterType = EnterTypeRoomSetting;
    _roomSettingView.backgroundColor = [UIColor whiteColor];
    _roomSettingView.rootViewController = self.rootViewController;
    [self addSubview:_roomSettingView];
}

#pragma mark - 点击贵宾席按钮
- (void)OnClickVipSofaBtn:(id)sender
{   [self checkViewState:_vipSofaView];
    if (_VipSofaViewShow) {
        [UIView animateWithDuration:.2f animations:^{

            _vipSofaView.frame = CGRectMake((SCREEN_WIDTH - SHEET_VIEW_WIDTH) / 2, SCREEN_HEIGHT, SHEET_VIEW_WIDTH, 151 + 5);
            [_vipSofaBtn setImage:[UIImage imageNamed:@"RoomVip_off.png"] forState:UIControlStateNormal];
        }];
        _VipSofaViewShow = NO;
    }
    else{
    [UIView animateWithDuration:.2f animations:^{
        _vipSofaView.frame = CGRectMake((SCREEN_WIDTH - SHEET_VIEW_WIDTH) / 2, SCREEN_HEIGHT - 170, SHEET_VIEW_WIDTH, 175);
        [_vipSofaBtn setImage:[UIImage imageNamed:@"RoomVip_on.png"] forState:UIControlStateNormal];
    }];
    _VipSofaViewShow = YES;
    }
}

#pragma mark - 点击榜单按钮
- (void)OnClickRankBtn:(id)sender
{
    
    [self checkViewState:_rankView];
    if (_RankViewShow) {
    [UIView animateWithDuration:.2f animations:^{
        _rankView.frame = CGRectMake((SCREEN_WIDTH - SHEET_VIEW_WIDTH) / 2, SCREEN_HEIGHT, SHEET_VIEW_WIDTH, SHEET_VIEW_HEIGHT + 5);
        [_rankBtn setImage:[UIImage imageNamed:@"RoomRank_off.png"] forState:UIControlStateNormal];
    }];
        _RankViewShow = NO;
    }
    else{
        [_rankView getRoomRankData];
    [UIView animateWithDuration:.2f animations:^{
        _rankView.frame = CGRectMake((SCREEN_WIDTH - SHEET_VIEW_WIDTH) / 2, SCREEN_HEIGHT - SHEET_VIEW_HEIGHT, SHEET_VIEW_WIDTH, SHEET_VIEW_HEIGHT + 5);
        [_rankBtn setImage:[UIImage imageNamed:@"RoomRank_on.png"] forState:UIControlStateNormal];
    }];
    _RankViewShow = YES;
    }
}

#pragma mark - 点击房间设置按钮
- (void)OnClickRoomSettingBtn:(id)sender
{
    [self checkViewState:_roomSettingView];
    if (_RoomSettingViewShow) {
        [UIView animateWithDuration:.2f animations:^{
            _roomSettingView.frame = CGRectMake((SCREEN_WIDTH - SHEET_VIEW_WIDTH) / 2, SCREEN_HEIGHT, SHEET_VIEW_WIDTH, 151 + 5);
            [_roomSettingBtn setImage:[UIImage imageNamed:@"RoomSet_off.png"] forState:UIControlStateNormal];
        }];
    _RoomSettingViewShow = NO;
    }
    else{
   
    [UIView animateWithDuration:.2f animations:^{
        _roomSettingView.frame = CGRectMake((SCREEN_WIDTH - SHEET_VIEW_WIDTH) / 2, SCREEN_HEIGHT - 151, SHEET_VIEW_WIDTH, 151 + 5);
        [_roomSettingBtn setImage:[UIImage imageNamed:@"RoomSet_on.png"] forState:UIControlStateNormal];
    }];
        
    _RoomSettingViewShow = YES;
    }
}


-(void)checkViewState:(SheetView *)sender
{
    if (sender.enterType == EnterTypeVipSofa) {
        if (_RankViewShow) {
            _RankViewShow = NO;
            [UIView animateWithDuration:.2f animations:^{
                _rankView.frame = CGRectMake((SCREEN_WIDTH - SHEET_VIEW_WIDTH) / 2, SCREEN_HEIGHT, SHEET_VIEW_WIDTH, SHEET_VIEW_HEIGHT + 5);
            }];
            [_rankBtn setImage:[UIImage imageNamed:@"RoomRank_off.png"] forState:UIControlStateNormal];
        }
        if (_RoomSettingViewShow) {
            _RoomSettingViewShow = NO;
            [UIView animateWithDuration:.2f animations:^{
                _roomSettingView.frame = CGRectMake((SCREEN_WIDTH - SHEET_VIEW_WIDTH) / 2, SCREEN_HEIGHT, SHEET_VIEW_WIDTH, 151 + 5);
            }];
            [_roomSettingBtn setImage:[UIImage imageNamed:@"RoomSet_off.png"] forState:UIControlStateNormal];
        }
    }
    if (sender.enterType == EnterTypeRank) {
        if (_VipSofaViewShow) {
            _VipSofaViewShow = NO;
            [UIView animateWithDuration:.2f animations:^{
                _vipSofaView.frame = CGRectMake((SCREEN_WIDTH - SHEET_VIEW_WIDTH) / 2, SCREEN_HEIGHT, SHEET_VIEW_WIDTH, 151 + 5);
                [_vipSofaBtn setImage:[UIImage imageNamed:@"RoomVip_off.png"] forState:UIControlStateNormal];
            }];
        }
        if (_RoomSettingViewShow) {
            _RoomSettingViewShow = NO;
            [UIView animateWithDuration:.2f animations:^{
                _roomSettingView.frame = CGRectMake((SCREEN_WIDTH - SHEET_VIEW_WIDTH) / 2, SCREEN_HEIGHT, SHEET_VIEW_WIDTH, 151 + 5);
                [_roomSettingBtn setImage:[UIImage imageNamed:@"RoomSet_off.png"] forState:UIControlStateNormal];
            }];
        }
    }
    if (sender.enterType == EnterTypeRoomSetting) {
            if (_VipSofaViewShow) {
                _VipSofaViewShow = NO;
                [UIView animateWithDuration:.2f animations:^{
                    _vipSofaView.frame = CGRectMake((SCREEN_WIDTH - SHEET_VIEW_WIDTH) / 2, SCREEN_HEIGHT, SHEET_VIEW_WIDTH, 151 + 5);
                }];
                [_vipSofaBtn setImage:[UIImage imageNamed:@"RoomVip_off.png"] forState:UIControlStateNormal];
            }
            if (_RankViewShow) {
                _RankViewShow = NO;
                [UIView animateWithDuration:.2f animations:^{
                    _rankView.frame = CGRectMake((SCREEN_WIDTH - SHEET_VIEW_WIDTH) / 2, SCREEN_HEIGHT, SHEET_VIEW_WIDTH, SHEET_VIEW_HEIGHT + 5);
                    [_rankBtn setImage:[UIImage imageNamed:@"RoomRank_off.png"] forState:UIControlStateNormal];
                }];
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
