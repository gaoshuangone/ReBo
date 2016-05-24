//
//  RoomRankViewController.m
//  BoXiu
//
//  Created by andy on 15-5-11.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "RoomRankViewController.h"
#import "UserInfoManager.h"
#import "FansRankModel.h"
#import "FansCell.h"
#import "RoomRankMenuBar.h"
#import "RoomFansViewController.h"
#import "SuperFansViewController.h"
#import "RobStarViewController.h"

@interface RoomRankViewController ()

@property (nonatomic,strong) RoomRankMenuBar *roomRankMenuBar;

@property (nonatomic,strong) RoomFansViewController *roomFansViewController;//本场粉丝榜
@property (nonatomic,strong) SuperFansViewController *superFansViewController;//超级粉丝榜
@property (nonatomic,strong) RobStarViewController *robStarViewController;//抢星榜

@end

@implementation RoomRankViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseViewType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _roomFansViewController = [[RoomFansViewController alloc] init];
    [self.view addSubview:_roomFansViewController.view];
    [self addChildViewController:_roomFansViewController];
    
    _superFansViewController = [[SuperFansViewController alloc] init];
    [self.view addSubview:_superFansViewController.view];
    [self addChildViewController:_superFansViewController];
    
    _robStarViewController = [[RobStarViewController alloc] init];
    [self.view addSubview:_robStarViewController.view];
    [self addChildViewController:_robStarViewController];
    
    _roomRankMenuBar = [[RoomRankMenuBar alloc] initWithFrame:CGRectZero showInView:self.view];
    [self.view addSubview:_roomRankMenuBar];
    __weak typeof(self) weakSelf = self;
    _roomRankMenuBar.roomRankMenuBarBlock = ^(NSInteger type){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf)
        {
            [strongSelf getRoomRankData:type];
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    _roomFansViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _superFansViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _robStarViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.roomRankMenuBar.frame = CGRectMake(0, self.view.frame.size.height - 35, self.view.frame.size.width, 40);
}

- (void)initData
{
    [self getRoomRankData:0];
}

- (void)getRoomRankData:(NSInteger)type
{
    //subview重新布局
    if (type == 0)
    {
        [self.view bringSubviewToFront:_roomFansViewController.view];
        
    }
    else if (type == 1)
    {
        [self.view bringSubviewToFront:_superFansViewController.view];
    }
    else if (type == 2)
    {
        [self.view bringSubviewToFront:_robStarViewController.view];
    }
    [self.view bringSubviewToFront:_roomRankMenuBar];
    
    
    if (type == 1)
    {
        [self.superFansViewController getRoomRankData];
    }
    else if (type == 2)
    {
        [self.robStarViewController getRoomRankData];
    }
    else
    {
        //type == 0；
        [self.roomFansViewController getRoomRankData];
    }
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
