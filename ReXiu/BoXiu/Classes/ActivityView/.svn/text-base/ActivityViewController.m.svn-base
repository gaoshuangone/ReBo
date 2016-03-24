//
//  ActivityViewController.m
//  XiuBo
//
//  Created by Andy on 14-3-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityModel.h"
#import "ActivityCell.h"
#import "EWPDialog.h"

@interface ActivityViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate>

@property(nonatomic,strong) ActivityModel *activityModel;
@end

@implementation ActivityViewController

- (void)dealloc
{
}

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
    
    self.title = Activity_Title;
    
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-64);
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self refreshData];
    
    __weak typeof(self) weakself = self;
    [self setNavigationBarLeftItem:nil itemNormalImg:[UIImage imageNamed:@"navBack_normal"] itemHighlightImg:nil withBlock:^(id sender) {
        __strong typeof(self) strongself = weakself;
        if (strongself)
        {
            NSString *className = NSStringFromClass([strongself class]);
            NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
            [strongself popCanvasWithArgment:param];
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)refreshData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    __weak typeof(self) weakSelf = self;
    
    [self requestDataWithAnalyseModel:[ActivityModel class] params:dict success:^(id object)
     {
         /*成功返回数据*/
         weakSelf.activityModel = object;
         if (weakSelf.activityModel.result == 0)
         {
             [weakSelf.tableView reloadData];
             NSInteger nCount = [self.activityModel.activityList count];
             if (nCount == 0)
             {
                 self.tipLabel.hidden = NO;
             }
             else
             {
                 self.tipLabel.hidden = YES;
             }
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
    NSInteger nCount = [self.activityModel.activityList count];
    return nCount;
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    ActivityCell *cell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
    }
    
    RobActivity *robActivity = [self.activityModel.activityList objectAtIndex:indexPath.row];
    cell.robActivity = robActivity;
    
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [baseTableView selectRowAtIndexPath:nil animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    //后期跳到活动详情页面
    RobActivity *robActivity = [self.activityModel.activityList objectAtIndex:indexPath.row];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:robActivity.pageurlmobile?robActivity.pageurlmobile:@"" forKey:@"pageurlmobile"];
    [dict setObject:robActivity.title?robActivity.title:@"" forKey:@"title"];
    [self pushCanvas:ActivityUrl_Canvas withArgument:dict];
}

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ActivityCell height];
}

#pragma mark - showDetailDialog
- (void)showDetailDialogWithTitle:(NSString *)title content:(NSString *)conttent
{

    EWPDialog *dialog = [[EWPDialog alloc] initWithTitle:title message:conttent parentView:self.view];
    dialog.backTouchHide = NO;
    dialog.dialogBKImage = [UIImage imageNamed:@"diaologBK.png"];
    [dialog setLeftBtnTitle:@"知道了" normalImg:[UIImage imageNamed:@"commonBtn_normal.png"] selectedImg:[UIImage imageNamed:@"commonBtn_selected.png"] buttonBlock:^(id sender) {
        
    }];
    [dialog show];
}

@end
