//
//  LiveFansRankViewController.m
//  BoXiu
//
//  Created by tongmingyu on 15/12/31.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "LiveRankViewController.h"
#import "BaseTableView.h"
#import "FansRankModel.h"
#import "GiftRankModel.h"
#import "LiveRankTableViewCell.h"
#import "LiveRank2TableViewCell.h"
#import "GrabStarRankCell.h"
#import "GiftRankCell.h"
#import "SuperRankModel.h"
@interface LiveRankViewController ()<SINavigationMenuDelegate,BaseTableViewDataSoure,BaseTableViewDelegate>
@property (nonatomic,strong) NSMutableArray *fansDataMArray;
@property (nonatomic,strong) NSMutableArray *starDataMArray;
@property (nonatomic,strong) NSMutableArray *superDataMArray;


@property (nonatomic,strong) BaseTableView *fansRankTableview;
@property (nonatomic,strong) BaseTableView *starRankTableview;
@property (nonatomic,strong) BaseTableView *superRankTableview;

@property (nonatomic,strong) FansRankModel *fansModel;
@property (nonatomic,strong) SuperRankModel *superfansModel;

@property (nonatomic,strong) UILabel *fanscoinlabel;

@property (nonatomic,strong) UIView *cryBack;
@property (nonatomic,strong) UIImageView *cryImg;
@property (nonatomic,strong) UILabel *mesLabel;
@property (nonatomic,assign) int indexPage;

@property (nonatomic,assign) NSInteger selectNum;
@end

@implementation LiveRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.indexPage = 1;
    
    _fansRankTableview = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 60) style:(UITableViewStyleGrouped)];
    _fansRankTableview.baseDataSource = self;
    _fansRankTableview.baseDelegate = self;
    _fansRankTableview.backgroundColor = [UIColor whiteColor];
    _fansRankTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _fansRankTableview.totalPage = 999;
    _fansRankTableview.showsVerticalScrollIndicator = NO;
    self.hideProgressHud = YES;
    [self.view addSubview:_fansRankTableview];
    
    _starRankTableview = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 60) style:UITableViewStyleGrouped];
    _starRankTableview.backgroundColor = [UIColor whiteColor];
    _starRankTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _starRankTableview.baseDelegate = self;
    _starRankTableview.baseDataSource = self;
    _starRankTableview.hidden = YES;
    _starRankTableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_starRankTableview];
    
    _superRankTableview = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 60) style:UITableViewStyleGrouped];
    _superRankTableview.backgroundColor = [UIColor whiteColor];
    _superRankTableview.separatorStyle = UITableViewCellSeparatorStyleNone;

    _superRankTableview.baseDataSource = self;
    _superRankTableview.baseDelegate = self;
    _superRankTableview.hidden = YES;
    _superRankTableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_superRankTableview];
    
    if (self.navigationItem) {
        CGRect frame = CGRectMake(0.0, 0.0, 200.0, self.navigationController.navigationBar.bounds.size.height);
        SINavigationMenuView *menu = [[SINavigationMenuView alloc] initWithFrame:frame title:@"本场粉丝榜"];
        [menu displayMenuInView:self.view];
        menu.items = @[@"本场粉丝榜", @"周抢星榜", @"月度贡献榜"];
        menu.delegate = self;
        self.navigationItem.titleView = menu;
    }

    _cryBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _cryBack.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
    _cryImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 71)/2, 170,71 , 60)];
    _cryImg.image = [UIImage imageNamed:@"cry"];
    
    _mesLabel = [[UILabel alloc] init];
    _mesLabel.font = [UIFont systemFontOfSize:16.0f];
    _mesLabel.text = @"还没人送礼,求主人打赏!";
    _mesLabel.textColor = [CommonFuction colorFromHexRGB:@"b9b9b9"];
    CGSize contSize = [_mesLabel sizeThatFits:CGSizeMake(200, MAXFLOAT)];
    _mesLabel.frame = CGRectMake((SCREEN_WIDTH - contSize.width)/2, 145 + 109, contSize.width, contSize.height);

    _cryBack.hidden = YES;
    [_cryBack addSubview:_mesLabel];
    [_cryBack addSubview:_cryImg];
    [self.view addSubview:_cryBack];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getFansRank];
}

- (void)viewDidDisappear:(BOOL)animated
{
    _selectNum = 0;
    [super viewDidDisappear:animated];
}
//下来刷新
- (void)refreshData
{
    if (_selectNum == 0) {
        [self didSelectItemAtIndex:0];
    }else if (_selectNum == 1)
    {
        [self getGiftRank];
    }else
    {
        [self getSuperRank];
    }
}
//上拉加载
-(void)loadMorData
{
    if (_selectNum == 0) {
        if ([_fansDataMArray count]<100) {
            if([_fansDataMArray count]%10 == 0){
                [self getFansRank];
                
            }else{
                [_fansRankTableview reloadData];
            }
        }else
        {
         [_fansRankTableview reloadData];
        }
    }else if (_selectNum == 1)
    {
    }else
    {
    }
}
- (void)didSelectItemAtIndex:(NSUInteger)index
{
    if (index == 0) {
        _selectNum = 0;
        _indexPage = 0;
        [self getFansRank];
        _starRankTableview.hidden = YES;
        _superRankTableview.hidden = YES;
        _fansRankTableview.hidden = NO;
    }else if (index == 1)
    {
        _selectNum = 1;
        _fansRankTableview.hidden =YES;
        _superRankTableview.hidden = YES;
        _starRankTableview.hidden = NO;
        [self getGiftRank];
    }else
    {
        _selectNum =2;
        _fansRankTableview.hidden =YES;
        _superRankTableview.hidden = NO;
        _starRankTableview.hidden = YES;
        [self getSuperRank];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 粉丝排行榜
-(void)getFansRank
{
    NSString *method = getFansRank_Method;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.roomid] forKey:@"roomid"];
    [params setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];
    [params setObject:[NSNumber numberWithInt:10] forKey:@"pageSize"];
    [params setObject:[NSNumber numberWithInt:self.indexPage] forKey:@"pageIndex"];

    [params setObject:@"1" forKey:@"iscountall"];
    
    _fansModel = [[FansRankModel alloc] init];
    [_fansModel requestDataWithMethod:method params:params success:^(id object) {
        if (_fansModel.result == 0)
        {
            if (_fansDataMArray == nil)
            {
                _fansDataMArray = [NSMutableArray array];
            }
            if (self.indexPage ==1 || self.indexPage ==0) {
                 [_fansDataMArray removeAllObjects];
            }
            
           
            if (_fansModel.fansUserMArray)
            {
                self.indexPage ++;
                [_fansDataMArray addObjectsFromArray:_fansModel.fansUserMArray];
            }
            else
            {
                //                    self.tipLabel.hidden = NO;
            }
            [_fansRankTableview reloadData];
            [_superRankTableview reloadData];
        }
        } fail:^(id object) {
            [_fansRankTableview reloadData];
    }];
}

#pragma  mark 礼物排行榜
-(void)getGiftRank
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];
    
    //        [self startAnimating];
    GiftRankModel *model = [[GiftRankModel alloc] init];
    [model requestDataWithParams:params success:^(id object) {
        GiftRankModel *model  = (GiftRankModel *)object;
        if (model.result == 0)
        {
            if (_starDataMArray == nil)
            {
                _starDataMArray = [NSMutableArray array];
            }
            if (model.starUserMArray)
            {
                [_starDataMArray removeAllObjects];
                
                [_starDataMArray addObjectsFromArray:model.starUserMArray];

            }
            else
            {
                //                    self.tipLabel.hidden = NO;
            }
            [_starRankTableview reloadData];
        }
        [self stopAnimating];
        
    } fail:^(id object) {
        /*失败返回数据*/
        //            [self.tableView reloadData];
        [self stopAnimating];
        [_starRankTableview reloadData];
    }];
}

#pragma  mark 超级榜
-(void)getSuperRank
{
    
    NSString *method = getFansRankMonth_Method;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.roomid] forKey:@"roomid"];
    [params setObject:@"1" forKey:@"iscountall"];

//        [self startAnimating];
    _superfansModel = [[SuperRankModel alloc] init];
    [_superfansModel requestDataWithMethod:method params:params success:^(id object) {
        if (_superfansModel.result == 0)
        {
            if (_superDataMArray == nil)
            {
                _superDataMArray = [NSMutableArray array];
            }
            
            if (_superfansModel.fansUserMArray)
            {
                [_superDataMArray removeAllObjects];
                [_superDataMArray addObjectsFromArray:_superfansModel.fansUserMArray];
            }
            else
            {
                //                    self.tipLabel.hidden = NO;
            }
            [_superRankTableview reloadData];

        }
        [self stopAnimating];
    } fail:^(id object) {
        [_superRankTableview reloadData];
        [self stopAnimating];
    }];
}

//分区
#pragma mark - BaseTableView view data source
-(NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
        if (_selectNum == 0) {
            if([_fansDataMArray count] <=3 )
            {
                return 1;
            }else
            {
                return 2;
            }
        }
        else if (_selectNum == 2)
        {
            if([_superDataMArray count] <= 3)
            {
                return 1;
            }else
            {
                return 2;
            }
        }else
        {
            return 1;
        }
   
}

#pragma  mark  cell 的section 高度
-(CGFloat)baseTableView:(BaseTableView *)baseTableView heightForHeaderInSection:(NSInteger)section
{
    if (_selectNum == 0 || _selectNum == 2) {
        if ([_fansDataMArray count]>0 || [_superDataMArray count] >0 ) {
            if (section == 0)
            {
                return 50;
            }else if (section == 1)
            {
                return 10;
            }
        }
    } if (_selectNum == 1) {
        if ([_starDataMArray count] > 0) {
            return 47.5;
        }
    }
    return 1;
}

//ForFooter 如果返回0则调用系统的高度
-(CGFloat )baseTableView:(BaseTableView *)baseTableView heightForFooterInSection:(NSInteger)section
{
   return 0.01;
    
}
#pragma mark  cell section显示的内容
-(UIView *)baseTableView:(BaseTableView *)baseTableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];

    if (_selectNum == 0 ) {
        if ([_fansDataMArray count]>0  ) {
            if (section == 0) {
                
                NSString *countStr = [NSString stringWithFormat:@"%ld ",(long)_fansModel.costallCoin];
                NSInteger leng = [countStr length];
                NSString *mosaicStr = [NSString stringWithFormat:@"本场收益 %ld 热豆",(long)_fansModel.costallCoin];
                CGSize contSize = [_fanscoinlabel sizeThatFits:CGSizeMake(260, MAXFLOAT)];
                
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:mosaicStr];
                [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"4c4855"] range:NSMakeRange(0,4)];
                [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"f7c250"] range:NSMakeRange(4,leng)];
                [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"4c4855"] range:NSMakeRange(leng + 4,3)];
                
                [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0f] range:NSMakeRange(0,4)];
                [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0f] range:NSMakeRange(4,leng)];
                [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0f] range:NSMakeRange(leng + 4,3)];

                
                _fanscoinlabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - contSize.width)/2, 20, contSize.width, 15)];
                _fanscoinlabel.attributedText = str;
                

                [view addSubview:_fanscoinlabel];
            }else if (section == 1)
            {
                
            }
        }
    }else if (_selectNum == 1)
    {
        if ([_starDataMArray count] >0) {
            UIImageView *starRank = [[UIImageView alloc] init];

            starRank.image = [UIImage imageNamed:@"starRank"];
            UILabel *inforLabel = [[UILabel alloc] init];
            inforLabel.font = [UIFont boldSystemFontOfSize:14.0f];
            inforLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
            inforLabel.text=@"本周抢星礼物排行";
            CGSize contSize = [inforLabel sizeThatFits:CGSizeMake(260, MAXFLOAT)];
            inforLabel.frame = CGRectMake((SCREEN_WIDTH - contSize.width + 20)/2, 15, contSize.width, contSize.height);
            starRank.frame = CGRectMake(inforLabel.frame.origin.x - 20, (47.5 - 17)/2, 15, 17);
            [view addSubview:inforLabel];
            [view addSubview:starRank];
        }
    }else if (_selectNum == 2)
    {
        if ( [_superDataMArray count] >0 ) {
            if (section == 0) {
                
                
                _fanscoinlabel = [[UILabel alloc] init];
                NSString *countStr = [NSString stringWithFormat:@"%ld ",(long)_superfansModel.costallCoin];
                NSInteger leng = [countStr length];
                NSString *mosaicStr = [NSString stringWithFormat:@"本场收益 %ld 热豆",(long)_superfansModel.costallCoin];
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:mosaicStr];
                [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"4c4855"] range:NSMakeRange(0,4)];
                [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"f7c250"] range:NSMakeRange(4,leng)];
                [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"4c4855"] range:NSMakeRange(leng + 4,3)];
                
                
                [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0f] range:NSMakeRange(0,4)];
                [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0f] range:NSMakeRange(4,leng)];
                [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0f] range:NSMakeRange(leng + 4,3)];
                  _fanscoinlabel.attributedText = str;
                    CGSize contSize = [_fanscoinlabel sizeThatFits:CGSizeMake(300, MAXFLOAT)];
                _fanscoinlabel.frame =CGRectMake((SCREEN_WIDTH - contSize.width)/2, 20, contSize.width, 15);
              
                [view addSubview:_fanscoinlabel];
            }else if (section == 1)
            {
                
            }
        }
    }

    return view;

}
#pragma mark cell的行数 rowSection
-(NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_selectNum == 0) {
        if (section == 0) {
//            判断本场粉丝榜 第一个分区数据有几行 大于三行显示三行
            if([_fansModel.fansUserMArray count] <3)
            {
                if ([_fansDataMArray count] == 0) {
                    _cryBack.hidden = NO;
                    return  0;
                }
                _cryBack.hidden = YES;
                return [_fansDataMArray count];
            }else
            {
                _cryBack.hidden = YES;
                return 3;
            }
        }else{
            _cryBack.hidden = YES;

//            如果数据小于三行则第二个分区的数据为0
            if ([_fansDataMArray count] >3) {
                return [_fansDataMArray count] - 3;
            }else
            {
                return 0;
            }
        }
    }
    else if (_selectNum == 1)
    {
        if ([_starDataMArray count] == 0) {
            _cryBack.hidden = NO;
            return 0;
        }
        _cryBack.hidden = YES;
        return [_starDataMArray count];
    }else if (_selectNum == 2)
    {
         if (section == 0) {
             if ([_superDataMArray count] <3) {
                 if ([_superDataMArray count] == 0) {
                     _cryBack.hidden = NO;
                     return 0;
                 }
                 _cryBack.hidden = YES;
                 return [_superDataMArray count];
             }
             else
             {
                 _cryBack.hidden = YES;
                 return 3;
             }
         }else{
             //            如果数据小于三行则第二个分区的数据为0
             if ([_superDataMArray count] >3) {
                 _cryBack.hidden = YES;
                 return [_superDataMArray count] - 3;
             }else
             {
                 _cryBack.hidden = YES;
                 return 0;
             }
         }

        
    }
    

    NSInteger nCount = 0;

    return nCount;
}
#pragma mark  cell的高度
- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (_selectNum == 0 || _selectNum == 2) {
//        第一个分区的cell高度
        if (indexPath.section == 0) {
            return 130;
        }else if(indexPath.section == 1)
        {
//            第二个分区cell的高度
            return 55;
        }else
        {
            return 0;
        }
    }else if (_selectNum == 1)
    {
        return 55;
    }
    return 0;
}

-(UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *LiveFansRankCell =  @"LiveFansRankCell";
    static NSString *LiveFansRank2Cell = @"LiveFansRank2Cell";
    static NSString *cellIdentifier =  @"starCellIdentifier";

    UITableViewCell *cell = nil;
    
    if (_selectNum == 0 || _selectNum == 2) {
        if (indexPath.section == 0) {
//         本场粉丝   第一个分区显示的内容
            LiveRankTableViewCell *liveRanCell = [baseTableView dequeueReusableCellWithIdentifier:LiveFansRankCell];
            if (liveRanCell == nil)
            {
                liveRanCell = [[LiveRankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LiveFansRankCell];
                liveRanCell.backgroundColor = [UIColor whiteColor];
                liveRanCell.accessoryType = UITableViewCellAccessoryNone;
                liveRanCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if(_selectNum == 0)
            {
                UserInfo *userInfo = [_fansDataMArray objectAtIndex:indexPath.row];
                liveRanCell.userInfo = userInfo;
                liveRanCell.rankIndex = indexPath.row;
                cell = liveRanCell;

            }else if (_selectNum == 2){
                UserInfo *userInfo = [_superDataMArray objectAtIndex:indexPath.row];
                liveRanCell.userInfo = userInfo;
                liveRanCell.rankIndex = indexPath.row;
                cell = liveRanCell;

            }


        }else if(indexPath.section == 1)
        {
//            本场粉丝第二个分区显示的内容
            LiveRank2TableViewCell *liveRanCell = [baseTableView dequeueReusableCellWithIdentifier:LiveFansRank2Cell];
            if(liveRanCell == nil)
            {
                liveRanCell = [[LiveRank2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LiveFansRank2Cell];
                liveRanCell.backgroundColor = [UIColor whiteColor];
                liveRanCell.accessoryType = UITableViewCellAccessoryNone;
                liveRanCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if (_selectNum == 0) {
                UserInfo *userInfo = [_fansDataMArray objectAtIndex:(indexPath.row + 3) ];
                liveRanCell.userInfo = userInfo;
                liveRanCell.rankIndex = indexPath.row + 3;
                cell = liveRanCell;
            }else{
                UserInfo *userInfo = [_superDataMArray objectAtIndex:(indexPath.row + 3) ];
                liveRanCell.userInfo = userInfo;
                liveRanCell.rankIndex = indexPath.row + 3;
                cell = liveRanCell;
            }

        }else
        {
            
        }
        //一个section刷新
        


    }else if (_selectNum == 1)
    {
        
        GiftRankCell *giftRankCell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (giftRankCell == nil)
        {
            giftRankCell = [[GiftRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            giftRankCell.backgroundColor = [UIColor whiteColor];
            giftRankCell.accessoryType = UITableViewCellAccessoryNone;
            giftRankCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        StarGift * starGift = [_starDataMArray objectAtIndex:indexPath.row];
        giftRankCell.starGift = starGift;
        cell = giftRankCell;
    }

    return cell;

}


-(void)dealloc
{
    if (_fansRankTableview)
    {
        [_fansRankTableview free];
    }
    
    if (_starRankTableview) {
        [_starRankTableview free];
    }
    
    if (_superRankTableview) {
        [_superRankTableview free];
    }
}
/*
 #pragma mark - Navigation           [[NSNotificationCenter defaultCenter] removeObserver:self];


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
