//
//  MoreViewController.m
//  BoXiu
//
//  Created by andy on 15-1-9.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "MoreViewController.h"
#import "EWPTitleButton.h"

#define BtnCount_per_Page (8)

@interface MoreViewController ()

@property (nonatomic,strong) NSMutableArray *btnTitleArray;
@property (nonatomic,strong) NSMutableArray *btnImageArray;

@property (nonatomic,strong) NSMutableArray *subViewofScroolView;

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseScroolViewType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _btnTitleArray = [NSMutableArray arrayWithArray:@[@"粉丝榜",@"抢星",@"Star档案",@"分享"]] ;
    _btnImageArray = [NSMutableArray arrayWithArray:@[@"fanrank_normal",@"rob_normal",@"starInfo_normal",@"chatRoomShare_normal"]];
    
    if ([AppInfo shareInstance].hiddenPay)
    {
        [_btnTitleArray removeLastObject];
        [_btnImageArray removeLastObject];
    }
    _subViewofScroolView = [NSMutableArray array];
    
    NSInteger btnCount = [_btnTitleArray count];
    NSInteger nPageCount = btnCount / BtnCount_per_Page + ((btnCount % BtnCount_per_Page) ? 1 : 0);
    for (NSInteger nPageIndex = 0; nPageIndex < nPageCount; nPageIndex++)
    {
        NSInteger btnCountInCurrentPage = (btnCount - nPageIndex * BtnCount_per_Page) > BtnCount_per_Page? BtnCount_per_Page : btnCount % BtnCount_per_Page;
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        for (NSInteger nIndex = 0; nIndex < btnCountInCurrentPage; nIndex++)
        {
            CGFloat nCellWidth = 53;
            CGFloat nCellHeight = 53;
            CGFloat x = ((nIndex % 4) * nCellWidth) + 20 * ((nIndex % 4) + 1);
            CGFloat y = nCellHeight * (nIndex / 4) + 10 * ((nIndex / 4) + 1);
            
            NSString *title = [_btnTitleArray objectAtIndex:nPageIndex * BtnCount_per_Page + nIndex];
            UIImage *btnImg = [UIImage imageNamed:[_btnImageArray objectAtIndex:nPageIndex * BtnCount_per_Page + nIndex]];
            EWPTitleButton *titleBtn = [[EWPTitleButton alloc] initWithTitle:title Image:btnImg];
            titleBtn.fontSize = 13.0f;
            titleBtn.tag = nPageIndex * BtnCount_per_Page + nIndex;
            titleBtn.frame = CGRectMake(x, y, nCellWidth, nCellHeight);
            [titleBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:titleBtn];
        }
        [self.scrollView addSubview:view];
        [_subViewofScroolView addObject:view];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    for (int nIndex = 0; nIndex < self.subViewofScroolView.count; nIndex++)
    {
        UIView *view = [self.subViewofScroolView objectAtIndex:nIndex];
        view.frame = CGRectMake(nIndex * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    }
}

- (void)OnClick:(id)sender
{
    EWPTitleButton *titleBtn = (EWPTitleButton *)sender;
    EWPLog(@"click btn:%ld",titleBtn.tag);
    if (self.delegate && [self.delegate respondsToSelector:@selector(moreViewController:didSelectBtnWithTag:)])
    {
        [self.delegate moreViewController:self didSelectBtnWithTag:titleBtn.tag];
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
