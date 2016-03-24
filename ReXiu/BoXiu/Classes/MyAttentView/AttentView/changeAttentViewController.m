//
//  changeAttentViewController.m
//  BoXiu
//
//  Created by tongmingyu on 14-5-8.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "changeAttentViewController.h"
#import "AddAttentCell.h"
#import "UserInfoManager.h"
#import "AttentionModel.h"
#import "AddAttentModel.h"

//9.19 查询主播列表
#import "QueryStarModel.h"
#import "UserInfo.h"


@interface changeAttentViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate>

@property (nonatomic,strong) UIControl *controlAttentBack;
@property (nonatomic,strong) QueryStarModel *queryStarModel;

@property (nonatomic,strong) NSMutableArray *starMary;
@property (nonatomic,strong) UIButton *buttonAddall;
@property (nonatomic,strong) UIButton *buttonNext;

@end

@implementation changeAttentViewController

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

    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 150, 15)];
    titleLabel.text = @"推荐关注";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:titleLabel];
    
    UIButton *buttonClose=[UIButton buttonWithType:UIButtonTypeCustom];
    [buttonClose setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    buttonClose.frame = CGRectMake(self.view.frame.size.width -38, 15, 30, 20);
    [buttonClose addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonClose];
 
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(100, 32)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(100, 32)];
    UIImage *selectImg2 = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"c34845"] size:CGSizeMake(100, 32)];

    
    _buttonNext = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonNext setTitle:@" 换一批" forState:UIControlStateNormal];
    _buttonNext.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _buttonNext.frame = CGRectMake(self.view.frame.size.width - 248, 53, 83, 28);
    _buttonNext.layer.masksToBounds = YES;
    _buttonNext.layer.cornerRadius = 14;
    _buttonNext.layer.borderWidth = 1;
    [_buttonNext setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    _buttonNext.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [_buttonNext setBackgroundImage:normalImg forState:UIControlStateNormal];
    [_buttonNext setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    [_buttonNext addTarget:self action:@selector(actionNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonNext];
    
    
    
  
    _buttonAddall = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonAddall setTitle:@" 全部关注" forState:UIControlStateNormal];
    _buttonAddall.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _buttonAddall.frame = CGRectMake(167, 53, 83, 28);
    _buttonAddall.layer.masksToBounds = YES;
    _buttonAddall.layer.cornerRadius = 14;
    _buttonAddall.layer.borderWidth = 1;
    _buttonAddall.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [_buttonAddall setBackgroundImage:selectImg forState:UIControlStateNormal];
    [_buttonAddall setBackgroundImage:selectImg2 forState:UIControlStateHighlighted];
    [_buttonAddall addTarget:self action:@selector(actionAddall) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonAddall];
    
    self.tableView.frame = CGRectMake(0,87, self.view.frame.size.width, 265-52);
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.tableView.refresh=NO;
    self.tableView.loadMore=NO;
    self.tableView.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    self.tableView.allowsSelection=NO;
    
    [self refreshData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - BaseCanvasController

- (void)loadMorData
{
    NSInteger npageIndex = self.queryStarModel.pageIndex + 1;
    if (npageIndex > self.tableView.totalPage)
    {
        npageIndex = 1;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isPagination"];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isFromMobile"];
    [dict setObject:[NSNumber numberWithInteger:npageIndex] forKey:@"pageIndex"];
    [dict setObject:[NSNumber numberWithInteger:Count_Per_Page] forKey:@"pageSize"];
    [dict setObject:[NSNumber numberWithInteger:2] forKey:@"type"];
    [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentUserInfo.userId] forKey:@"userid"];
    
    __weak typeof(self) weakSelf = self;
    [self requestDataWithAnalyseModel:[QueryStarModel class] params:dict success:^(id object)
     {
         __strong typeof(self) strongSelf = weakSelf;
         /*成功返回数据*/
         QueryStarModel *starModel = object;
         if (starModel.result == 0)
         {
             strongSelf.queryStarModel = starModel;
             if (_starMary == nil)
             {
                 _starMary = [NSMutableArray array];
             }
             [self.starMary removeAllObjects];
             
             [self.starMary addObjectsFromArray:weakSelf.queryStarModel.starMArray];
             
             self.tableView.totalPage = starModel.recordCount/Count_Per_Page + ((starModel.recordCount % Count_Per_Page) ? 1 : 0);
             [strongSelf.tableView reloadData];
         }
     }
     fail:^(id object)
     {
         /*失败返回数据*/
     }];
}

- (void)refreshData
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isPagination"];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isFromMobile"];
    [dict setObject:[NSNumber numberWithInteger:1] forKey:@"pageIndex"];
    [dict setObject:[NSNumber numberWithInteger:Count_Per_Page] forKey:@"pageSize"];
    [dict setObject:[NSNumber numberWithInteger:2] forKey:@"type"];
    [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentUserInfo.userId] forKey:@"userid"];
    
    __weak changeAttentViewController *weakSelf = self;
    [self requestDataWithAnalyseModel:[QueryStarModel class] params:dict success:^(id object)
     {
          __strong changeAttentViewController *strongSelf = weakSelf;
         /*成功返回数据*/
         QueryStarModel *starModel = object;
         if (starModel.result == 0)
         {
             strongSelf.queryStarModel = starModel;
             if (_starMary == nil)
             {
                 _starMary = [NSMutableArray array];
             }
             [self.starMary removeAllObjects];
             [self.starMary addObjectsFromArray:weakSelf.queryStarModel.starMArray];

             self.tableView.totalPage = (long)(starModel.recordCount/Count_Per_Page + ((starModel.recordCount % Count_Per_Page) ? 1 : 0));

             [weakSelf.tableView reloadData];
         }
     }
     fail:^(id object)
     {
         /*失败返回数据*/
     }];
}


#pragma mark -BaseTableCanvasDataSoure
- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return 1;
}

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    return self.starMary.count;
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";

    AttentCell *cell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[AttentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    StarInfo *starInfo = [self.starMary objectAtIndex:indexPath.row];
    cell.starInfo = starInfo;
    cell.addAttenBtn.tag = starInfo.userId;
    [cell.addAttenBtn addTarget:self action:@selector(actionAddAttent:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [AttentCell height];
}

#pragma mark - Interaction
-(void)close
{
    if (self.delegate)
    {
        [self.delegate closeChangeAttentDilaog];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)actionAddall
{
    UIColor *selectBgColor = [UIColor colorWithWhite:1 alpha:0.5];
    _buttonAddall.backgroundColor = selectBgColor;
    _buttonNext.backgroundColor = [UIColor clearColor];
    
    NSMutableArray *staruserids=[[NSMutableArray alloc] init];
    for(StarInfo *starInfo in self.starMary)
    {
        [staruserids addObject:[NSNumber numberWithInteger:starInfo.userId]];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:staruserids forKey:@"staruserids"];

    __weak typeof(self) weakSelf = self;
    
    AddAttentModel *addAttentionModel = [[AddAttentModel alloc] init];
    [addAttentionModel requestDataWithMethod:addManyAttention_Method params:dict success:^(id object) {
        __strong typeof(self) strongSelf = weakSelf;
        /*成功返回数据*/
        if (addAttentionModel.result == 0)
        {
            [self showNoticeInWindow:@"添加关注成功" duration:2];
            [strongSelf.starMary removeAllObjects];
            [strongSelf performSelector:@selector(loadMorData) withObject:nil afterDelay:0.5];
        }
        else
        {
            [self showNoticeInWindow:addAttentionModel.msg];
        }
        
    } fail:^(id object) {
        
    }];

    
}

-(void)actionNext
{
    UIColor *selectBgColor = [UIColor colorWithWhite:1 alpha:0.5];
    _buttonAddall.backgroundColor = [UIColor clearColor];
    _buttonNext.backgroundColor = selectBgColor;
    [self loadMorData];
    //[self refreshData];
}

-(IBAction)actionAddAttent:(id)sender
{
    UIButton *addAttend=(UIButton *)sender;
    if([addAttend isKindOfClass:[UIButton class]])
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInteger:addAttend.tag]forKey:@"staruserid"];
        __weak typeof(self) weakSelf = self;

        AddAttentModel *addAttentionModel = [[AddAttentModel alloc] init];
        [addAttentionModel requestDataWithMethod:AddAttention_Method params:dict success:^(id object) {
            __strong typeof(self) strongSelf = weakSelf;
            /*成功返回数据*/
            if (addAttentionModel.result == 0)
            {
                [self showNoticeInWindow:@"添加关注成功" duration:0.5];
                
                NSMutableArray *deleteRows=[[NSMutableArray alloc] init];
                for(NSIndexPath *indexPath in weakSelf.tableView.indexPathsForVisibleRows)
                {
                    AttentCell *attentCell=(AttentCell *)[weakSelf.tableView cellForRowAtIndexPath:indexPath];
                    if([attentCell isKindOfClass:[AttentCell class]] && attentCell.addAttenBtn==sender)
                    {
                        [deleteRows addObject:indexPath];
                        [strongSelf.starMary removeObject:attentCell.starInfo];
                        break;
                    }
                }
                EWPLog(@"%@",deleteRows);
                [weakSelf.tableView deleteRowsAtIndexPaths:deleteRows withRowAnimation:UITableViewRowAnimationFade];
            }
            else
            {
                [self showNoticeInWindow:addAttentionModel.msg];
            }
            
        } fail:^(id object) {
            
        }];
    }
}

@end
