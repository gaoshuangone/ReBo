//
//  LiveFansRankViewController.m
//  BoXiu
//
//  Created by tongmingyu on 15/12/31.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "LiveFansRankViewController.h"

@interface LiveFansRankViewController ()

@end

@implementation LiveFansRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息中心";
    if (self.navigationItem) {
        CGRect frame = CGRectMake(0.0, 0.0, 200.0, self.navigationController.navigationBar.bounds.size.height);
        SINavigationMenuView *menu = [[SINavigationMenuView alloc] initWithFrame:frame title:@"本场粉丝榜"];
        [menu displayMenuInView:self.view];
        menu.items = @[@"本场粉丝榜", @"周抢星榜", @"月度贡献榜"];
        menu.delegate = self;
        
        self.navigationItem.titleView = menu;
    }
}

- (void)didSelectItemAtIndex:(NSUInteger)index
{
    NSLog(@"did selected item at index %lu", (unsigned long)index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
