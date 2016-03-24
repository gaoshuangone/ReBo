//
//  AttentViewController.m
//  XiuBo
//
//  Created by Andy on 14-3-26.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "AttentViewController.h"
#import "RecommendCell.h"
#import "UserInfo.h"
#import "AttentionModel.h"
#import "UserInfoManager.h"
#import "EnterRoomModel.h"
#import "AppInfo.h"
#import "changeAttentViewController.h"
#import "AppDelegate.h"
#import "EWPDialog.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "DelAttentionModel.h"
#import "AddAttentModel.h"
#import "MainViewController.h"
#import "LiveRoomViewController.h"

#define Category_StarCount_Per_Page (10)

@interface AttentViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate,RecommendCellDelegate,changeAttentViewControllerDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UIView *viewNodataBack;
@property (nonatomic,strong) NSMutableArray *starUserMArray;
@property (nonatomic,strong) StarInfo *selectedStarUser;

@property (nonatomic,strong) EWPDialog *noticeDialog;
@property (nonatomic,strong) UIView *noLoginView;
@property (nonatomic,strong) changeAttentViewController *changeAttentViewController;
@property (nonatomic,strong) UIImageView *rexiuImg;
@property (nonatomic,strong) UIButton *recommendbut;
@property (nonatomic,assign) NSInteger Number;

@end

@implementation AttentViewController

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
    self.navigationItem.title = Attent_Title;
    
    _rexiuImg = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, SCREEN_WIDTH - 14, 180)];
    _rexiuImg.layer.cornerRadius = 8.0f;
    _rexiuImg.layer.masksToBounds = YES;
    [_rexiuImg setImage:[UIImage imageNamed:@"attentionImg@2x"]];

    _recommendbut = [[UIButton alloc] initWithFrame:CGRectMake(97, 128, 125, 32)];
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"c34845"] size:CGSizeMake(200, 38)];
    UIImage *highImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(200, 38)];
    _recommendbut.layer.cornerRadius = 16.0f;
    _recommendbut.layer.masksToBounds = YES;
    _recommendbut.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _recommendbut.layer.borderWidth = 1;
    _recommendbut.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [_recommendbut setTitle:@"看看推荐" forState:UIControlStateNormal];
    [_recommendbut addTarget:self action:@selector(OnRecomment:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendbut setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    [_recommendbut setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    [_recommendbut setBackgroundImage:normalImg forState:UIControlStateHighlighted];
    [_recommendbut setBackgroundImage:highImg forState:UIControlStateNormal];
    
    self.tipLabel.hidden = YES;
    
    self.tableView.frame =  CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 36 - 44);
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.hideProgressHud = YES;
}

-(void)OnRecomment:(id)sender
{
    if ([self showLoginDialog])
    {
        return;
    }
    MainViewController *mainViewController = (MainViewController *)self.rootViewController;
    mainViewController.tabMenuControl.currentSelectedSegmentIndex=1;
    [mainViewController.tabMenuControl reloadData];

}
- (void)viewWillLayoutSubviews
{
    self.tableView.frame =  CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 36 - 44);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(![AppInfo shareInstance].bLoginSuccess)
    {
        [_viewNodataBack removeFromSuperview];

        if(_starUserMArray)
        {
            [_starUserMArray removeAllObjects];
            [self.tableView reloadData];
        }
//        [self ShowNoLogin];
        [self showNoAttent];
    }
    else
    {

        if (self.bFirstViewWillAppear)
        {
            [self refreshData];
        }

        _noLoginView.hidden = YES;
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self closeChangeAttentDilaog];
}

-(void)setAttenview
{
    
    if(![AppInfo shareInstance].bLoginSuccess)
    {
        [_viewNodataBack removeFromSuperview];
        
        if(_starUserMArray)
        {
            [_starUserMArray removeAllObjects];
            [self.tableView reloadData];
        }
//        [self ShowNoLogin];
        [self showNoAttent];
    }
    else
    {
        
        if (self.bFirstViewWillAppear)
        {
            [self refreshData];
        }
        
        _noLoginView.hidden = YES;
    }
}

#pragma mark - BaseCanvasController

- (void)loadMorData
{
    if (![AppInfo shareInstance].bLoginSuccess)
    {
        [self.tableView reloadData];
        return;
    }

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isPagination"];
    [dict setObject:[NSNumber numberWithInteger:++self.tableView.curentPage] forKey:@"pageIndex"];
    [dict setObject:[NSNumber numberWithInt:Count_Per_Page] forKey:@"pageSize"];
    
    [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentUserInfo.userId] forKey:@"userid"];
    
    [self requestDataWithAnalyseModel:[AttentionModel class] params:dict success:^(id object)
     {
         _Number = 0;
         /*成功返回数据*/
         AttentionModel *model = (AttentionModel *)object;
         if (model.result == 0)
         {
             if ([_starUserMArray count] < (self.tableView.curentPage * Count_Per_Page)?1:0) {
                 self.tableView.totalPage = 0;
                 self.tableView.curentPage --;
             }else
             {
                 
             }

            [self.starUserMArray addObjectsFromArray:model.starUserMArray];
            [self.tableView reloadData];

         }
         else
         {
             if (![model.title rangeOfString:@"用户没有登陆"].length > 0)
             {
                 [self showNoticeInWindow:model.title];
             }
         }
     }
    fail:^(id object)
     {
         [self.tableView reloadData];
         _Number =1;
         /*失败返回数据*/
     }];

}

- (void)refreshData
{
    [_viewNodataBack removeFromSuperview];
    
    if (![AppInfo shareInstance].bLoginSuccess)
    {
        [self.tableView reloadData];
        return;
    }
    if (self.starUserMArray.count==0) {
        self.isFirstRequestData = YES;
    }else{
        self.isFirstRequestData = NO;
    }
    [self startAnimating];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isPagination"];
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"pageIndex"];
    [dict setObject:[NSNumber numberWithInt:Count_Per_Page] forKey:@"pageSize"];
    
    [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentUserInfo.userId] forKey:@"userid"];
    
    __weak typeof(self) weakSelf = self;
    [self requestDataWithAnalyseModel:[AttentionModel class] params:dict success:^(id object)
     {
         _Number = 0;
         __strong typeof(self) strongSelf = weakSelf;
         /*成功返回数据*/
         AttentionModel *model = (AttentionModel *)object;
         if (model.result == 0)
         {
             if(_starUserMArray == nil)
             {
                 _starUserMArray = [[NSMutableArray alloc] initWithCapacity:0];
             }
             [strongSelf.starUserMArray removeAllObjects];
             if (model.starUserMArray && model.starUserMArray.count > 0)
             {
                [strongSelf.starUserMArray addObjectsFromArray:model.starUserMArray];
             }
             
             strongSelf.tableView.totalPage = model.recordCount / Count_Per_Page + (model.recordCount % Count_Per_Page ? 1 : 0);
             [strongSelf.tableView reloadData];
             if(strongSelf.starUserMArray.count==0)
             {
                 [strongSelf showNoAttent];
             }
         }
         else
         {
             if (![model.title rangeOfString:@"用户没有登陆"].length > 0)
             {
                 [strongSelf showNoticeInWindow:model.title];
             }
         }
         [self stopAnimating];
     }
    fail:^(id object)
     {
         [self stopAnimating];
         _Number = 1;
         /*失败返回数据*/
     }];
    [self.tableView reloadData];

}

#pragma mark -BaseTableCanvasDataSoure

- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return 1;
}

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger nCount = [self.starUserMArray count];
    if (nCount == 0)
    {
        if([AppInfo shareInstance].bLoginSuccess)
        {
            [self showNoAttent];
        }
        else
        {
//            [self ShowNoLogin];
            [self showNoAttent];
        }
        
    }
    else
    {
        if (_viewNodataBack)
        {
            [_viewNodataBack removeFromSuperview];
        }
        
        if (_noLoginView)
        {
            _noLoginView.hidden = YES;
        }
    }
    return  nCount;
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row+1)%10 == 0) {
        if ((10 + [self.starUserMArray count])%10 ==0 ) {
            if(self.tableView.totalPage != 0)
            {
                [self loadMorData];
            }
        }
    }
    static NSString *cellIdentifier =  @"cellIdentifier";
    RecommendCell *cell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[RecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.starInfo = [self.starUserMArray objectAtIndex:indexPath.row];
    
    UIButton  *starinforButton = [UIButton buttonWithType:UIButtonTypeCustom];
    starinforButton.frame = CGRectMake(6, 198, 65, 65);
    starinforButton.backgroundColor = [UIColor clearColor];
    [starinforButton addTarget:self action:@selector(starinforButton:) forControlEvents:UIControlEventTouchUpInside];
    starinforButton.tag = indexPath.row;
    [cell.contentView addSubview:starinforButton];
    return cell;
}

- (void)starinforButton:(UIButton *)sender{
    
    RecommendCell* cell = (RecommendCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]  ];
    
    [UserInfoManager shareUserInfoManager].tempHederImage = cell.adPhoto.image;
    StarInfo *starInfo =[self.starUserMArray objectAtIndex:sender.tag];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"userid"];
    [self.rootViewController pushCanvas:PersonInfo_Canvas withArgument:param];
}

#pragma mark - BaseTableCanvasDelegate

- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedStarUser = [self.starUserMArray objectAtIndex:indexPath.row];
    NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:self.selectedStarUser.userId] forKey:@"staruserid"];
//    [self.rootViewController pushCanvas:ChatRoom_Canvas withArgument:param];
    [self.rootViewController pushCanvas:LiveRoom_CanVas withArgument:param];
}

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [RecommendCell height];
}

#pragma mark - RecommendCellDelegate
- (void)recommendCell:(RecommendCell *)recommendCell attendStar:(StarInfo *)starInfo
{
    if (![AppInfo shareInstance].bLoginSuccess)
    {
        [self showNoticeInWindow:@"需要先登录哦"];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:starInfo.userId]forKey:@"staruserid"];
    
    __weak typeof(self) weakSelf = self;
    if (starInfo.attentionflag)
    {
        //取消关注
        DelAttentionModel *delAttentionModel = [[DelAttentionModel alloc] init];
        [delAttentionModel requestDataWithParams:dict success:^(id object) {
            __strong typeof(self) strongSelf = weakSelf;
            /*成功返回数据*/
            if (delAttentionModel.result == 0)
            {
                starInfo.attentionflag = NO;
                recommendCell.starInfo = starInfo;
                [strongSelf showNoticeInWindow:@"已取消对TA的关注" duration:1];
                [strongSelf.starUserMArray removeObject:recommendCell.starInfo];
                [strongSelf.tableView reloadData];
            }
            else if([delAttentionModel.data isEqualToString:@"用户没有登陆！不能关注"])
            {
                [[AppInfo shareInstance] loginOut];
                [self setAttenview];
                [self showOherTerminalLoggedDialog];
            }
        } fail:^(id object) {
            
        }];
    }
    else
    {
        //添加关注
        AddAttentModel *addAttentionModel = [[AddAttentModel alloc] init];
        [addAttentionModel requestDataWithMethod:AddAttention_Method params:dict success:^(id object) {
            __strong typeof(self) strongSelf = weakSelf;
            /*成功返回数据*/
            if (addAttentionModel.result == 0)
            {
                starInfo.attentionflag = YES;
                recommendCell.starInfo = starInfo;
                [strongSelf showNoticeInWindow:@"已成功关注TA" duration:1];
            }
            else
            {
                [strongSelf showNoticeInWindow:@"需要先登录哦"];

            }
        } fail:^(id object) {
            
        }];
    }
    
}

-(void) ShowNoLogin
{
    if(!_noLoginView)
    {
        _noLoginView=[[UIView alloc] initWithFrame:self.tableView.frame];
        _noLoginView.backgroundColor=[UIColor clearColor];
    }
    else
    {
        for(UIView *subView in _noLoginView.subviews)
            [subView removeFromSuperview];
    }
    NSString *textLabel=@"您还未登录热波间";
    NSString *textButton=@"马上去登录 >";
    UILabel *labelNodata=[[UILabel alloc] init];
    labelNodata.text=[NSString stringWithFormat:@"%@%@",textLabel,textButton];
    labelNodata.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    labelNodata.font = [UIFont boldSystemFontOfSize:14];
    [labelNodata sizeToFit];
    labelNodata.text=textLabel;
    [labelNodata sizeToFit];
    labelNodata.frame = CGRectMake((_noLoginView.bounds.size.width - labelNodata.frame.size.width)/2, (_noLoginView.bounds.size.height - labelNodata.frame.size.height)/2 - 50, labelNodata.frame.size.width, labelNodata.frame.size.height);
    [_noLoginView addSubview:labelNodata];
    
    UIButton *buttondata=[UIButton buttonWithType:UIButtonTypeCustom];
    buttondata.tag = 60;
    buttondata.frame=CGRectMake(labelNodata.frame.origin.x, labelNodata.frame.origin.y + 30, labelNodata.frame.size.width, labelNodata.frame.size.height);
    [buttondata setTitle:textButton forState:UIControlStateNormal];
    [buttondata setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    [buttondata addTarget:self action:@selector(showAttent:) forControlEvents:UIControlEventTouchUpInside];
    buttondata.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [_noLoginView addSubview:buttondata];
    
    _noLoginView.hidden = NO;
    [self.view addSubview:_noLoginView];
}


#pragma mark - Interaction

-(void) showNoAttent{
    if(!_viewNodataBack)
    {
        _viewNodataBack=[[UIView alloc] initWithFrame:self.tableView.frame];
        _viewNodataBack.backgroundColor=[UIColor clearColor];
    }
    else
    {
        for(UIView *subView in _viewNodataBack.subviews)
            [subView removeFromSuperview];
    }

  
    [_viewNodataBack addSubview:_rexiuImg];
    [_viewNodataBack addSubview:_recommendbut];
    
    [self.view addSubview:_viewNodataBack];
}

-(void)ShowLogin{
    [self.rootViewController pushCanvas:Login_OR_Register_Canvas withArgument:nil];
}

#pragma mark 推荐关注界面
-(void) showAttent:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 30)
    {
        [self showChangeAttentDialog];
    }
    else if (btn.tag == 60)
    {
        LoginViewController *viewController = [[LoginViewController alloc] init];
        [self.rootViewController.navigationController  pushViewController:viewController animated:YES];  
    }
}



- (void)showPersonInfo:(UserInfo *)userInfo{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[NSNumber numberWithInteger:userInfo.userId] forKey:@"userid"];

    [self.rootViewController pushCanvas:PersonInfo_Canvas withArgument:param];
}


- (void)hideLoginDialog
{
    if (self.noticeDialog)
    {
        [self.noticeDialog hideDialog];
        self.noticeDialog = nil;
    }
}

- (void)closeChangeAttentDilaog
{
    [self hideChangeAttentDialog];
}

- (void)showChangeAttentDialog
{
    UIControl *backView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backView.backgroundColor = [UIColor clearColor];
    [backView addTarget:self action:@selector(hideChangeAttentDialog) forControlEvents:UIControlEventTouchUpInside];
    backView.tag = 1111;
    [self.view addSubview:backView];
    
    if (_changeAttentViewController == nil)
    {
        _changeAttentViewController = [[changeAttentViewController alloc] init];
        _changeAttentViewController.delegate = self;
        _changeAttentViewController.view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 450);
        [self.view addSubview:_changeAttentViewController.view];
    }
    
    [UIView animateWithDuration:0.1f animations:^{
        CGRect frame = self.changeAttentViewController.view.frame;
        frame.origin.y -= frame.size.height;
        self.changeAttentViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)hideChangeAttentDialog
{
    UIView *backView = [self.view viewWithTag:1111];
    
    [UIView animateWithDuration:0.0f animations:^{
        CGRect frame = self.changeAttentViewController.view.frame;
        frame.origin.y += frame.size.height;
        self.changeAttentViewController.view.frame = frame;
        
    } completion:^(BOOL finished) {
        [backView removeFromSuperview];
        [self.changeAttentViewController.view removeFromSuperview];
        self.changeAttentViewController = nil;
        [self refreshData];
    }];
}

@end
