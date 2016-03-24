//
//  HistoryViewController.m
//  BoXiu
//
//  Created by andy on 14-4-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "HistoryViewController.h"
#import "SeenHistoryModel.h"
#import "AttentCell.h"

@interface HistoryViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate,GeneralRankCellDelegate>

@property (nonatomic,strong) SeenHistoryModel *seenHistoryModel;

@end

@implementation HistoryViewController

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
    self.title = @"我看过的";
    
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44);
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    self.refresh = NO;
    self.loadMore = NO;
    
    [self refreshData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    __weak typeof(self) weakSelf = self;
    
    [self requestDataWithAnalyseModel:[SeenHistoryModel class] params:dict success:^(id object)
     {
         /*成功返回数据*/
         weakSelf.seenHistoryModel = object;
         if (weakSelf.seenHistoryModel.result == 0)
         {
             [weakSelf.tableView reloadData];
         }
     }
                                 fail:^(id object)
     {
         /*失败返回数据*/
     }];
}

#pragma mark - GeneralRankCellDelegate

- (void)generalRankCell:(GeneralRankCell *)generalRankCell didSeletedUserInfo:(UserInfo *)userInfo;
{
    StarInfo *starInfo=generalRankCell.starInfo;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"userid"];
    [self pushCanvas:PersonInfo_Canvas withArgument:param];
}

#pragma mark -BaseTableCanvasDataSoure
- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return 1;
}

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    return [self.seenHistoryModel.userMArray count];
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
    StarInfo *starInfo = [self.seenHistoryModel.userMArray objectAtIndex:indexPath.row];
    cell.starInfo = starInfo;
//    cell.delegate = self;
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, [AttentCell height]- 2, SCREEN_WIDTH, 2)];
    [lineImg setImage:[UIImage imageNamed:@"hLine.png"]];
    [cell.contentView addSubview:lineImg];
    
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [baseTableView selectRowAtIndexPath:nil animated:NO scrollPosition:UITableViewScrollPositionNone];
    StarInfo *starInfo = [self.seenHistoryModel.userMArray objectAtIndex:indexPath.row];
    [baseTableView selectRowAtIndexPath:nil animated:NO scrollPosition:UITableViewScrollPositionNone];
    if(starInfo)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInt:starInfo.userId] forKey:@"userid"];
        [self.rootViewController pushCanvas:PersonInfo_Canvas withArgument:dict];
    }
}

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [AttentCell height];
}

@end
