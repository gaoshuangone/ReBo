//
//  TaskViewController.m
//  BoXiu
//
//  Created by tongmingyu on 14-6-19.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "TaskViewController.h"
#import "TaskTitleCell.h"
#import "TaskCell.h"

@interface TaskViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate>

@end

@implementation TaskViewController

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
    self.title = @"做任务、赢热币";
    
    self.tableView.frame = self.view.bounds;
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.allowsSelection = NO;
    
    self.tableView.refresh = NO;
    self.tableView.loadMore = NO;
    [self refreshData];
}

- (void)refreshData
{
    
}

#pragma mark -BaseTableCanvasDataSoure
- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return 3;
}

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }else{
        return 2;
    }
  return 0;
}
- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0&&indexPath.section==0){
        static NSString *taskTitleCellIdentifier =  @"taskTitleCellIdentifier";
        TaskTitleCell *cell = [baseTableView dequeueReusableCellWithIdentifier:taskTitleCellIdentifier];
        if (cell == nil)
        {
            cell = [[TaskTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:taskTitleCellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
        }
        return cell;
    }else{
        static NSString *taskCellIdentifier =  @"taskCellIdentifier";
        TaskCell *cell = [baseTableView dequeueReusableCellWithIdentifier:taskCellIdentifier];
        if (cell == nil)
        {
            cell = [[TaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:taskCellIdentifier];
//            cell.backgroundColor = [UIColor redColor];
        }
        return cell;

    }
}

#pragma mark -UITableViewDelegate
- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [baseTableView selectRowAtIndexPath:nil animated:NO scrollPosition:UITableViewScrollPositionNone];
    
}

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0&&indexPath.section==0)
        return [TaskTitleCell height];
    else
        return [TaskCell height];
}
- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForHeeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
@end
