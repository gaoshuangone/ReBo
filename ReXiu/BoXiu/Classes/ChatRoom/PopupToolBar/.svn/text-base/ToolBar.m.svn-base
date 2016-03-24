//
//  ToolBar.m
//  BoXiu
//
//  Created by Andy on 14-3-31.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ToolBar.h"
#import "PersonInfoView.h"
#import "RobSofaView.h"
#import "UserInfoManager.h"
#import "RobSofaView.h"
#import "AppDelegate.h"
#import "EWPTabBar.h"
#import "EWPScrollLable.h"

@interface ToolBar ()<RobSofaViewDelegate,EWPTabBarDataSource,EWPTabBarDelegate>

@property (nonatomic,strong) PersonInfoView *personInfoView;
@property (nonatomic,strong) RobSofaView *robSofaView;
@property (nonatomic,assign) BaseView *contentView;
@property (nonatomic,strong) EWPTabBar *tabBar;
@property (nonatomic,strong) NSMutableArray *tabTitles;

@property (nonatomic,strong) UIButton *starInfoBtn;
@property (nonatomic,strong) UIButton *safaBtn;

@end

@interface ToolBar()

@property (nonatomic,strong) EWPScrollLable *rollContext;

@end

@implementation ToolBar



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
    
    CGFloat nYOffset = 12;
//    CGFloat nYOffset = 124;
    
    _tabTitles = [NSMutableArray array];
    
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(46, nYOffset, 227, 26)];
    bgImg.image = [UIImage imageNamed:@"registBg"];
    [self addSubview:bgImg];
    
//    [self switchClick forControlEvents:UIControlEventTouchUpInside];
    
    
    _starInfoBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _starInfoBtn.frame = CGRectMake(48, nYOffset + 2, 111, 22);
    _starInfoBtn.tag = 10;
    [_starInfoBtn setTitle:Person_Info_Title forState:UIControlStateNormal];
    _starInfoBtn.layer.masksToBounds = YES;
    _starInfoBtn.layer.cornerRadius = 11;
    _starInfoBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_starInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _starInfoBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    [_starInfoBtn addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_starInfoBtn];
    
    
    
    _safaBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _safaBtn.frame = CGRectMake(160, nYOffset + 2, 111, 22);
    _safaBtn.tag = 11;
    [_safaBtn setTitle:Rob_Sofa_Title forState:UIControlStateNormal];
    _safaBtn.layer.masksToBounds = YES;
    _safaBtn.layer.cornerRadius = 11;
    _safaBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
   [_safaBtn addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self switchClick:_safaBtn];
    [self addSubview:_safaBtn];
    

 
    nYOffset = 45;
    
    _personInfoView = [[PersonInfoView alloc] initWithFrame:CGRectMake(0, nYOffset, frame.size.width, frame.size.height - nYOffset) showInView:self];
    _personInfoView.rootViewController = self.rootViewController;
    [self addSubview:_personInfoView];
    [_tabTitles addObject:Person_Info_Title];
    
    _robSofaView = [[RobSofaView alloc] initWithFrame:CGRectMake(0, nYOffset, frame.size.width, frame.size.height - nYOffset) showInView:self];
    _robSofaView.delegate = self;
    _robSofaView.hidden = YES;
    [self addSubview:_robSofaView];
    [_tabTitles addObject:Rob_Sofa_Title];
    
    [_tabBar reloadData];

}

- (void)viewWillAppear
{
    [super viewWillAppear];
    _personInfoView.rootViewController = self.rootViewController;
    _tabBar.selectedIndex = 0;
    
    if (_personInfoView)
    {
        [_personInfoView viewWillAppear];
    }
    
    if (_robSofaView)
    {
        [_robSofaView viewWillAppear];
    }
    
    if (_rollContext)
    {
        [_rollContext setNeedsDisplay];
    }
}

- (void)viewwillDisappear
{
    [super viewwillDisappear];
}


- (void)setPersonData:(PersonData *)personData
{
    if (_personInfoView)
    {
        _personInfoView.personData = personData;
    }
}

- (void)setSofaData:(SofaData *)sofaData
{
    if (_robSofaView)
    {

        [_robSofaView setSofaData:sofaData];
        UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        if (sofaData.userid == userInfo.userId)
        {
            self.bRobbingSofa = NO;
        }
    }
}

//- (void)switchClick:(id)sender

- (void)switchClick:(id)sender
{
    EWPButton *btn = (EWPButton *)sender;
    
    if (btn.tag == 10)
    {
        _starInfoBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        _safaBtn.backgroundColor = [UIColor clearColor];
        
        _robSofaView.hidden = YES;
        _personInfoView.hidden = NO;
        self.contentView = _personInfoView;
    }
    else
    {
        _starInfoBtn.backgroundColor = [UIColor clearColor];
        _safaBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        
        _robSofaView.hidden = NO;
        _personInfoView.hidden = YES;
        self.contentView = _robSofaView;
    }
    [self.contentView viewWillAppear];
    [self bringSubviewToFront:self.contentView];
}


#pragma mark - EWPTabBarDataSource

- (NSInteger)numberOfItems
{
    return [_tabTitles count];
}

- (CGFloat)widthOfItem:(NSInteger)index
{
    return 140;
}

- (CGFloat)heightOfItem
{
    return 24;
}

- (NSString *)titleOfItem:(NSInteger)index
{
    return [self.tabTitles objectAtIndex:index];
}

- (NSInteger)tagOfItem:(NSInteger)index
{
    return index;
}

#pragma mark - EWPTabBarDelegate

- (void)tabBar:(EWPTabBar *)tabBar didSelectItemWithTag:(NSInteger)itemTag
{

    switch (itemTag)
    {
        case 0:
        {
            _robSofaView.hidden = YES;
            _personInfoView.hidden = NO;
            self.contentView = _personInfoView;
        }
            break;
        case 1:
        {
            _robSofaView.hidden = NO;
            _personInfoView.hidden = YES;
            self.contentView = _robSofaView;
        }
            break;
            
        default:
            break;
    }
    [self.contentView viewWillAppear];
    [self bringSubviewToFront:self.contentView];
}

#pragma mark - RobSofaViewDelegate

- (void)robSofaView:(RobSofaView *)robSofaView sofaData:(SofaData *)sofaData
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(toolBar:robSofa:)])
    {
        if (!self.bRobbingSofa)
        {
            [self.delegate toolBar:self robSofa:sofaData];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
