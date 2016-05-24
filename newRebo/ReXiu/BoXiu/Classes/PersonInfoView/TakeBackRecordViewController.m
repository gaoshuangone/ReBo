//
//  TakeBackRecordViewController.m
//  BoXiu
//
//  Created by andy on 15/12/1.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "TakeBackRecordViewController.h"
#import "PageQueryModel.h"
#import "PageQueryTableViewCell.h"

#import "TakeBackHistary.h"
#define Single_Per_Page 10
@interface TakeBackRecordViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate>
@property (nonatomic,strong) UIButton* buttonBack;
@property (nonatomic,strong) UILabel* labelJinE;
@property (strong, nonatomic)NSMutableArray* buyHisMArray;
@property (strong, nonatomic)UIControl* control;

@property (strong, nonatomic)UIControl* controlNoData;

@property (strong, nonatomic)UIView* viewNoData;
@end

@implementation TakeBackRecordViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
       [self loadDate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _controlNoData =[[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_controlNoData];
    
    UIControl* controlBG1 = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    controlBG1.backgroundColor = [CommonUtils colorFromHexRGB:@"f6f6f6"];
    [_controlNoData addSubview:controlBG1];
    
    _viewNoData = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-110)/2, SCREEN_HEIGHT/2-64, 110, 120)];
    
    [_controlNoData addSubview:_viewNoData];
    UIImageView* imageView =[[UIImageView alloc]initWithFrame:CGRectMake((110-65)/2, 0, 65, 60)];
    
    
    imageView.image = [UIImage imageNamed:@"TB01.png"];
    [_viewNoData addSubview:imageView];
    
    UILabel* label1 =[CommonUtils commonSignleLabelWithText:@"暂无记录" withFontSize:14 withOriginX:0 withOriginY:0 isRelativeCoordinate:NO];
    label1.textColor =[CommonUtils colorFromHexRGB:@"cbcbcb"];
    [_viewNoData addSubview:label1];
       label1.center = CGPointMake(55, 82);
    
    UILabel* label2 =[CommonUtils commonSignleLabelWithText:@"马上开播收获礼物吧" withFontSize:12 withOriginX:0 withOriginY:0 isRelativeCoordinate:NO];
    label2.textColor =[CommonUtils colorFromHexRGB:@"cbcbcb"];
    [_viewNoData addSubview:label2];
        label2.center = CGPointMake(55, 100);
    
    _buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonBack setImage:[UIImage imageNamed:@"navB_Nor.png"] forState:UIControlStateHighlighted];
    [_buttonBack setImage:[UIImage imageNamed:@"backNew.png"] forState:UIControlStateNormal];
    _buttonBack.frame = CGRectMake(0, 20, 50, 40);
    _buttonBack.tag = 11;
    [_buttonBack addTarget:self action:@selector(buttonPres:) forControlEvents:UIControlEventTouchUpInside];
    [_controlNoData addSubview:_buttonBack];
    
    UILabel* labelTitleNoData = [CommonUtils commonSignleLabelWithText:@"提现记录" withFontSize:18 withOriginX:self.view.center.x withOriginY:20+21 isRelativeCoordinate:NO];
    labelTitleNoData.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
    [_controlNoData addSubview:labelTitleNoData];
    
    UIView* viewLineNoData = [CommonUtils CommonViewLineWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
    viewLineNoData.backgroundColor = [UIColor grayColor];
    [_controlNoData addSubview:viewLineNoData];

    
    
 
    _control =[[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_control];
    
    
    UIControl* controlBG = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    controlBG.backgroundColor = [CommonUtils colorFromHexRGB:@"f6f6f6"];
    [_control addSubview:controlBG];
    
    _buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonBack setImage:[UIImage imageNamed:@"navB_Nor.png"] forState:UIControlStateHighlighted];
    [_buttonBack setImage:[UIImage imageNamed:@"backNew.png"] forState:UIControlStateNormal];
    _buttonBack.frame = CGRectMake(0, 20, 50, 40);
    _buttonBack.tag = 11;
    [_buttonBack addTarget:self action:@selector(buttonPres:) forControlEvents:UIControlEventTouchUpInside];
    [_control addSubview:_buttonBack];
    
    UILabel* labelTitle = [CommonUtils commonSignleLabelWithText:@"提现记录" withFontSize:18 withOriginX:self.view.center.x withOriginY:20+21 isRelativeCoordinate:NO];
    labelTitle.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
    [_control addSubview:labelTitle];
    
    UIView* viewLine = [CommonUtils CommonViewLineWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
    viewLine.backgroundColor = [UIColor grayColor];
    [_control addSubview:viewLine];
    
    
 
    UIImageView* imageViewIcon =[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-41)/2, 194/2, 41, 32)];
    imageViewIcon.image = [UIImage imageNamed:@"TBleiji"];
    
    [_control addSubview:imageViewIcon];
    
    UILabel* labelCount =[CommonUtils commonSignleLabelWithText:@"累计提现" withFontSize:12 withOriginX:self.view.center.x withOriginY:282/2 isRelativeCoordinate:NO];
    labelCount.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
    labelCount.font = [UIFont boldSystemFontOfSize:12];
    [labelCount sizeToFit];
    labelCount.center = CGPointMake(self.view.center.x, 282/2+labelCount.boundsHeight/2);
    [_control addSubview:labelCount];
    
    _labelJinE =[CommonUtils commonSignleLabelWithText:@"￥" withFontSize:25 withOriginX:self.view.center.x withOriginY:322/2 isRelativeCoordinate:NO];
    _labelJinE.textColor = [CommonUtils colorFromHexRGB:@"f7c250"];
    _labelJinE.font = [UIFont boldSystemFontOfSize:24];
    [_labelJinE sizeToFit];
 
    _labelJinE.center = CGPointMake(self.view.center.x, 322/2+_labelJinE.boundsHeight/2);
    [_control addSubview:_labelJinE];
    
    self.view.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    

    
    [self addTableViewWithFrame:CGRectMake(0, 422/2, SCREEN_WIDTH, SCREEN_HEIGHT-422/2) style:UITableViewStylePlain];
    self.tableView.baseDataSource =self;
    self.tableView.baseDelegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [_control addSubview:self.tableView];
    

    // Do any additional setup after loading the view.
}

- (void)refreshData{
    [self loadDate];
}
-(void)loadDate{
    self.tableView.tipLabel.hidden = YES;
    
    if (![AppInfo shareInstance].bLoginSuccess)
    {
        [self.tableView reloadData];
        return;
    }
    self.isFirstRequestData = NO;
    if (self.buyHisMArray.count==0) {
        self.isFirstRequestData = YES;
    }else{
        self.isFirstRequestData = NO;
    }
    [self startAnimating];
    self.tableView.curentPage =1;

    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1],@"pageIndex", nil];
    
    TakeBackHistary* model = [[TakeBackHistary alloc]init];
    [model requestDataWithParams:param success:^(id object) {
        [self stopAnimating];
        if (model.result == 0)
        {
            if (_buyHisMArray == nil)
            {
                _buyHisMArray= [NSMutableArray array];
            }
            [_buyHisMArray removeAllObjects];
            [_buyHisMArray addObjectsFromArray:model.dataArray];
            
            _labelJinE.comSizeToTextFit = [NSString stringWithFormat:@"￥%.2f",[model.strTotolMoney floatValue]];

            
            if ([model.dataArray count] < Single_Per_Page || [model.strPageIndex intValue]*[model.strPageSize intValue] >= [model.strRecordCount intValue] )

            {
                self.tableView.totalPage = [model.dataArray count]/Single_Per_Page + ([model.dataArray count] %Single_Per_Page? 1:0);
            }
            else
            {
                self.tableView.totalPage = 1000;
            }
            [self.tableView reloadData];
            
        }else{
            if (model.code == 403) {
                           [self popToCanvas:PersonInfo_Canvas withArgument:nil];
            }else{
                   [self showNoticeInWindow:model.msg duration:1.5];
            }
        }
    } fail:^(id object) {
        [self showNoticeInWindow:@"网络连接失败，请重试" duration:1.5];
        [self stopAnimating];
        [self.tableView reloadData];
    }];

}
-(void)loadMorData{
    
    self.tableView.tipLabel.hidden = YES;
    if (![AppInfo shareInstance].bLoginSuccess)
    {
        [self.tableView reloadData];
        return;
    }
//    if (self.buyHisMArray.count==0) {
//        self.isFirstRequestData = YES;
//    }else{
//        self.isFirstRequestData = NO;
//    }
//    [self startAnimating];
//
    
    NSString* strPage = [NSString stringWithFormat:@"%ld",self.tableView.curentPage];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:strPage,@"pageIndex", nil];
    
    TakeBackHistary* model = [[TakeBackHistary alloc]init];
    
    [model requestDataWithParams:param success:^(id object) {
        [self stopAnimating];
        if (model.result == 0)
        {
            if (_buyHisMArray == nil)
            {
                _buyHisMArray= [NSMutableArray array];
            }
            [_buyHisMArray addObjectsFromArray:model.dataArray];
            
            _labelJinE.comSizeToTextFit = [NSString stringWithFormat:@"￥%.2f",[model.strTotolMoney floatValue]];

            if ([model.dataArray count] < Single_Per_Page || [model.strPageIndex intValue]*[model.strPageSize intValue] >= [model.strRecordCount intValue] )
                
            {
                self.tableView.totalPage = [model.dataArray count]/Single_Per_Page + ([model.dataArray count] %Single_Per_Page? 1:0);
            }
            else
            {
                self.tableView.totalPage = 1000;
            }
            [self.tableView reloadData];
            
        }
    } fail:^(id object) {
        [self showNoticeInWindow:@"网络连接失败，请重试" duration:1.5];
        [self stopAnimating];
        [self.tableView reloadData];
    }];
}
- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView{
    
        if ([self.buyHisMArray count] <= 0)
        {
    
            _control.hidden = YES;;
            _controlNoData.hidden = NO;
      
        }else{
            _control.hidden = NO;;
            _controlNoData.hidden = YES;
            [_controlNoData removeFromSuperview];
        }

    return 1;
}

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.buyHisMArray count];
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* strNoti = @"cell";
    PageQueryTableViewCell* cell = [baseTableView dequeueReusableCellWithIdentifier:strNoti];
    if (!cell) {
        cell=[[PageQueryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strNoti];
    }
    for (UIView* view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    [cell initViewWithData:[self.buyHisMArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row != self.buyHisMArray.count-1) {
        [cell addLine];
    }
    
    if (indexPath.row==0 && indexPath.section==0) {
        [cell addLineheader];
    }
    
    
    
    return cell;
}
- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(void)buttonPres:(UIButton*)sener{
    switch (sener.tag) {
        case 11://返回
            [self popCanvasWithArgment:nil];
            break;
            
        default:
            break;
    }
}
#pragma mark -argument
-(void)argumentForCanvas:(id)argumentData
{
    
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
