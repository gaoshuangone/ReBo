//
//  RechargeRecordViewController.m
//  BoXiu
//
//  Created by Bob Wan on 15/7/13.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//
typedef NS_ENUM(NSInteger, Select) {
    Select1 = 0,
    Select2,

};
#import "RechargeRecordViewController.h"
#import "RechHistoryCell.h"
#import "UserButHistory.h"
#define Single_Per_Page 10
@interface RechargeRecordViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate>

@property(strong, nonatomic)UILabel* label1;
@property(strong, nonatomic)UILabel* label2;
@property(nonatomic,strong)UIDatePicker* datePicker;
@property(nonatomic,strong)UIButton* buttonPicker;
@property(nonatomic,strong)UIView* viewPicker;
@property (nonatomic, strong) EWPSimpleDialog *awaysLoginDialog;
@property (strong, nonatomic) UILabel* labelPicker;
@property (assign, nonatomic)Select select;
@property (strong, nonatomic)NSMutableArray* buyHisMArray;
@property (assign, nonatomic) BOOL isFirst;

@property (strong, nonatomic) NSString* strLabel1Text;
@property (strong, nonatomic) NSString* strLabel2Text;
@end

@implementation RechargeRecordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"充值记录";
    [self addTableViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-65) style:UITableViewStylePlain];
    self.tableView.baseDataSource =self;
    self.tableView.baseDelegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

   
   
    
}
- (void)refreshData{
    [self loadDate];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
//    [self loadDate];
}

-(void)addawaysLoginDialogWithDateString:(NSString*)dateString{
    _awaysLoginDialog = [[EWPSimpleDialog alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT)];
    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-216, self.view.frameWidth, 216)];
    self.datePicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.datePicker addTarget:self action:@selector(pick:) forControlEvents:UIControlEventValueChanged];

    
    self.datePicker.date = [CommonUtils getDateForString:dateString format:@"yyyy/MM/dd"];
    
    
    
    [_awaysLoginDialog addSubview:self.datePicker];
    
    UIView* viewBG = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-216-40, SCREEN_WIDTH, 40)];
    viewBG.backgroundColor =[UIColor groupTableViewBackgroundColor];
    [_awaysLoginDialog addSubview:viewBG];
    
    self.labelPicker = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 0, 200, 40)];
    self.labelPicker.textAlignment = NSTextAlignmentCenter;
    self.labelPicker.text =[dateString stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    self.labelPicker.font = [UIFont systemFontOfSize:18];
    [viewBG addSubview:self.labelPicker];
    
    self.buttonPicker = [CommonUtils commonButNormalWithFrame:CGRectMake(SCREEN_WIDTH-60, 0, 60, 40) withBounds:CGSizeMake(60, 40) withOriginX:SCREEN_WIDTH-60 withOriginY:0 isRelativeCoordinate:YES withTarget:self withAction:@selector(buttonPressed)];
    [self.buttonPicker setTitle:@"确定" forState:UIControlStateNormal];
    [self.buttonPicker setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [viewBG addSubview:self.buttonPicker];
    
    UIView* viewLine = [CommonUtils CommonViewLineWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 0.5)];
    [viewBG addSubview:viewLine];
    
    [_awaysLoginDialog showInView:[UIApplication sharedApplication].keyWindow withColor:[UIColor blackColor] withAlpha:0.7];
}
-(void)pick:(UIDatePicker*)pick{
    UIDatePicker* picker = (UIDatePicker*)pick;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate: picker.date];
    self.labelPicker.text =strDate;
    if (self.select == Select1) {
        self.label1.text = [strDate stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    }else{
        self.label2.text = [strDate stringByReplacingOccurrencesOfString:@"-" withString:@"/"];

    }
    
}
-(void)buttonPressed{
    [_awaysLoginDialog hide];
    
}
- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView{
    return 1;
}

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section{
    if ([self.buyHisMArray count] <= 0)
    {

        self.tipLabel.hidden = NO;
        baseTableView.tipLabel.hidden = NO;
    }
    else
    {
           baseTableView.tipLabel.hidden = YES;
    }
    
    return [self.buyHisMArray count];
    
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* strNoti = @"cell";
    RechHistoryCell* cell = [baseTableView dequeueReusableCellWithIdentifier:strNoti];
    if (!cell) {
        cell=[[RechHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strNoti];
    }
    for (UIView* view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    [cell initViewWithData:[self.buyHisMArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row != self.buyHisMArray.count-1) {
        [cell addLine];
    }
    

 
    return cell;
}
- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForHeaderInSection:(NSInteger)section{
    return 65;
}

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)baseTableView:(BaseTableView *)baseTableView viewForHeaderInSection:(NSInteger)section{

    static NSString* strNoti = @"head";
    
    UIView* view = [baseTableView dequeueReusableHeaderFooterViewWithIdentifier:strNoti];
    if (!view) {
        
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 75)];
        view.backgroundColor = [UIColor whiteColor];
        CGFloat ofSetWide = 105;
        UIControl* view1 = [[UIControl alloc]initWithFrame:CGRectMake(11, 16, ofSetWide, 28)];
        view1.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
        view1.tag = 1;
        [view1 addTarget:self action:@selector(controlTouched:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:view1];
        
        UILabel* labelZhi = [CommonUtils commonSignleLabelWithText:@"至" withFontSize:15 withOriginX:11+ofSetWide+14 withOriginY:view1.center.y isRelativeCoordinate:NO];
        labelZhi.textColor = [CommonFuction colorFromHexRGB:@"6f6f6f"];
        [view addSubview:labelZhi];
        
        
        UIControl* view2 = [[UIControl alloc]initWithFrame:CGRectMake(11+ofSetWide+30, 16, ofSetWide, 28)];
        view2.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
        view2.tag = 2;
        [view2 addTarget:self action:@selector(controlTouched:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:view2];
        
        
        
        UIControl* view3 = [[UIControl alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 16, 50, 28)];
        view3.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
        view3.tag = 3;
        [view3 addTarget:self action:@selector(controlTouched:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:view3];
      
        
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 100, 20)];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:[[NSDate alloc] init]];
        [components setHour:-[components hour]];
        [components setMinute:-[components minute]];
        [components setSecond:-[components second]];
        [components setHour:-24];
        [components setMinute:0];
        [components setSecond:0];
        components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[[NSDate alloc] init]];
        [components setMonth:([components month] - 1)];
        NSDate *lastMonth = [cal dateFromComponents:components];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSString *strDate = [dateFormatter stringFromDate: lastMonth];
       
        self.label1.text =strDate;
        self.label1.textColor =[CommonFuction colorFromHexRGB:@"6f6f6f"];
        self.label1.font = [UIFont systemFontOfSize:13];
        [view addSubview:self.label1];
        
        UIImageView* iamgeView1 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view1.frame)-10-6, 65/2-5, 7, 5)];
        iamgeView1.image = [UIImage imageNamed:@"Cut head.png"];
        [view addSubview:iamgeView1];
        
        
        
        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(11+108+30+5, 20, 100, 20)];
        
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"yyyy/MM/dd"];
        NSString *strDate2 = [dateFormatter2 stringFromDate: [NSDate date]];
        self.label2.text = strDate2;
        
        self.label2.textColor =[CommonFuction colorFromHexRGB:@"6f6f6f"];
        self.label2.font = [UIFont systemFontOfSize:13];
        [view addSubview:self.label2];
        
        UIImageView* iamgeView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view2.frame)-10-6, 65/2-5, 7, 5)];
        iamgeView2.image = [UIImage imageNamed:@"Cut head.png"];
        [view addSubview:iamgeView2];
        
        
        UILabel* label3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(view3.frame), 20, 50, 20)];
        label3.text =@"查询";
        label3.textAlignment = NSTextAlignmentCenter;
        label3.textColor =[CommonFuction colorFromHexRGB:@"6f6f6f"];
        label3.font = [UIFont systemFontOfSize:13];
        [view addSubview:label3];
        
        UIView* viewLine =[CommonUtils  CommonViewLineWithFrame:CGRectMake(11, 64, SCREEN_WIDTH-22, 0.5)];
        viewLine.backgroundColor =[UIColor lightGrayColor];
        viewLine.alpha = 0.15;
        [view addSubview:viewLine];
        
        if (!self.isFirst) {
            self.isFirst = YES;
            [self refreshData];
        }else{
            self.label1.text = self.strLabel1Text;
                self.label2.text = self.strLabel2Text;
        }
        

    }
     
        return view;

 
}
-(void)controlTouched:(UIControl*)control{
    if (control.tag==1) {
        [self addawaysLoginDialogWithDateString:self.label1.text];
        self.select = Select1;
    }else if (control.tag == 2){
         [self  addawaysLoginDialogWithDateString:self.label2.text];
        self.select = Select2;
    }else{
        [self loadDate];
          }
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
    self.strLabel1Text =self.label1.text;
    self.strLabel2Text = self.label2.text;
    
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[self.label1.text stringByReplacingOccurrencesOfString:@"/" withString:@"-"],@"datetime_start",[self.label2.text stringByReplacingOccurrencesOfString:@"/" withString:@"-"],@"datetime_end",[NSNumber numberWithInt:0],@"pageIndex", nil];
    UserButHistory *model = [[UserButHistory alloc] init];
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
            if ([model.dataArray count] < Single_Per_Page)
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
-(void)loadMorData{
    
     self.tableView.tipLabel.hidden = YES;
    if (![AppInfo shareInstance].bLoginSuccess)
    {
        [self.tableView reloadData];
        return;
    }
    if (self.buyHisMArray.count==0) {
        self.isFirstRequestData = YES;
    }else{
        self.isFirstRequestData = NO;
    }
    [self startAnimating];

    self.strLabel1Text =self.label1.text;
    self.strLabel2Text = self.label2.text;
    
    NSLog(@"~~~~~~~~~~~~~~~!!!%ld",(long)self.tableView.curentPage);
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[self.label1.text stringByReplacingOccurrencesOfString:@"/" withString:@"-"],@"datetime_start",[self.label2.text stringByReplacingOccurrencesOfString:@"/" withString:@"-"],@"datetime_end",[NSNumber numberWithInteger:self.tableView.curentPage],@"pageIndex", nil];
    
    
    
    UserButHistory *model = [[UserButHistory alloc] init];
    [model requestDataWithParams:param success:^(id object) {
        [self stopAnimating];
        if (model.result == 0)
        {
            if (_buyHisMArray == nil)
            {
                _buyHisMArray = [NSMutableArray array];
            }
          
            if ([model.dataArray count] < Single_Per_Page || [model.strPageIndex intValue]*[model.strPageSize intValue] >= [model.strRecordCount intValue] )
            {
                self.tableView.totalPage = [model.dataArray count]/Single_Per_Page + ([model.dataArray count] %Single_Per_Page? 1:0);
            }
            else
            {
                self.tableView.totalPage = 1000;
            }
              [_buyHisMArray addObjectsFromArray:model.dataArray];
            [self.tableView reloadData];
           
            
        }
    } fail:^(id object) {
        [self showNoticeInWindow:@"网络连接失败，请重试" duration:1.5];
        self.tableView.curentPage--;
        [self.tableView reloadData];
        [self stopAnimating];
    }];

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
