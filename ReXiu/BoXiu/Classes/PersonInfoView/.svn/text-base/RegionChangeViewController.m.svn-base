//
//  RegionChangeViewController.m
//  BoXiu
//
//  Created by tongmingyu on 14-5-19.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RegionChangeViewController.h"
#import "updateCurrUserModel.h"
#import "UserInfoManager.h"
#import "JSONKit.h"

@interface RegionChangeViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate>
@property (nonatomic,strong) UserInfo *userInfo;

@property(nonatomic,strong) NSMutableArray *dataList;
@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;

@end

@implementation RegionChangeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseTableViewType;
        
        self.userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        
        NSString *path  = [[NSBundle mainBundle] pathForResource:@"ProvinceCityData" ofType:@"plist"];
        _dataList = [[NSMutableArray alloc] initWithContentsOfFile:path];
        
        NSString *string=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        _dataList = [string objectFromJSONString];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改地区";
    self.tipLabel.hidden = YES;
    
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 44);
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    
    __weak typeof(self) weakself = self;
    [self setNavigationBarLeftItem:nil itemNormalImg:[UIImage imageNamed:@"navBack_normal.png"] itemHighlightImg:nil withBlock:^(id sender) {
        __strong typeof(self) strongself = weakself;
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:strongself.userInfo forKey:@"userinfo"];
        [strongself popCanvasWithArgment:dict];
    }];
    
}

-(void)argumentForCanvas:(id)argumentData
{

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return [_dataList count];
}

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOpen)
    {
        if (self.selectIndex.section == section)
        {
            return [[[_dataList objectAtIndex:section] objectForKey:@"city"] count]+1;;
        }
    }
    return 1;
}

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isOpen && self.selectIndex.section == indexPath.section && indexPath.row!=0)
    {
        static NSString *CellIdentifier = @"CellCity";
        UITableViewCell *cell = [baseTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.imageView.image = [CommonFuction imageWithColor:[UIColor clearColor] size:CGSizeMake(46, 46)];
        }
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        NSArray *list = [[_dataList objectAtIndex:self.selectIndex.section] objectForKey:@"city"];
        cell.textLabel.text = [[list objectAtIndex:indexPath.row-1] objectForKey:@"divisionName"];
        cell.textLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        CGRect rect=cell.textLabel.frame;
        rect.origin.x = 60;
        cell.textLabel.frame = rect;
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"CellProvince";
        UITableViewCell *cell = [baseTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        NSString *name = [[_dataList objectAtIndex:indexPath.section] objectForKey:@"divisionName"];
        cell.textLabel.text = name;
        cell.textLabel.textColor = [CommonFuction colorFromHexRGB:@"d14c49"];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        cell.imageView.image = [self.selectIndex isEqual:indexPath]?[UIImage imageNamed:@"ExpansionArrow"]:[UIImage imageNamed:@"rightArrow"];
        return cell;
    }
}


#pragma mark - Table view delegate
- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        if ([indexPath isEqual:self.selectIndex])
        {
            self.isOpen = NO;
            [self didSelectCellRowFirstDo:NO nextDo:NO];
            self.selectIndex = nil;
            
        }
        else
        {
            if (!self.selectIndex)
            {
                self.selectIndex = indexPath;
                [self didSelectCellRowFirstDo:YES nextDo:NO];
                
            }
            else
            {
                
                [self didSelectCellRowFirstDo:NO nextDo:YES];
            }
        }
        
    }
    else
    {
        NSArray *list = [[_dataList objectAtIndex:indexPath.section] objectForKey:@"city"];
        
        NSString *provincename = [[_dataList objectAtIndex:indexPath.section] objectForKey:@"divisionName"];
        NSString *province = [[_dataList objectAtIndex:indexPath.section] objectForKey:@"divisionCode"];
        NSString *cityname = [[list objectAtIndex:indexPath.row-1] objectForKey:@"divisionName"];
        NSString *city = [[list objectAtIndex:indexPath.row-1] objectForKey:@"divisionCode"];
        _userInfo.city = city;
        _userInfo.cityname = cityname;
        _userInfo.province = province;
        _userInfo.provincename = provincename;
        [self popCanvasWithArgment:[NSDictionary dictionaryWithObject:_userInfo forKey:@"userinfo"]];
    }
    [baseTableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    self.isOpen = firstDoInsert;
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.selectIndex];
    cell.imageView.image = firstDoInsert?[UIImage imageNamed:@"ExpansionArrow"]:[UIImage imageNamed:@"rightArrow.png"];
    
    [self.tableView beginUpdates];
    
    NSInteger section = self.selectIndex.section;
    NSInteger contentCount = [[[_dataList objectAtIndex:section] objectForKey:@"city"] count];
	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
	for (NSUInteger i = 1; i < contentCount + 1; i++)
    {
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
		[rowToInsert addObject:indexPathToInsert];
	}
	
	if (firstDoInsert)
    {
        [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
	else
    {
        [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
	
	[self.tableView endUpdates];
    if (nextDoInsert)
    {
        self.isOpen = YES;
        self.selectIndex = [self.tableView indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    if (self.isOpen)
    {
        [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark - Interaction
-(void) updateCurrUserRegion:(NSString *)city cityName:(NSString *)cityname province:(NSString *)province provinceName:(NSString *)provinceName
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:_userInfo.nick forKey:@"nick"];
    [dict setObject:city forKey:@"city"];
    [dict setObject:[NSNumber numberWithInteger:_userInfo.sex] forKey:@"sex"];
    
    __weak typeof(self) weakSelf = self;
    [self requestDataWithAnalyseModel:[updateCurrUserModel class] params:dict success:^(id object)
     {
         /*成功返回数据*/
         updateCurrUserModel *userModel = object;
         if (userModel.result == 0)
         {
             weakSelf.userInfo.city = city;
             weakSelf.userInfo.cityname = cityname;
             weakSelf.userInfo.province = province;
             weakSelf.userInfo.provincename = provinceName;
             
             NSMutableDictionary *dict = [NSMutableDictionary dictionary];
             [dict setObject:_userInfo forKey:@"userinfo"];
             [weakSelf popCanvasWithArgment:dict];

         }
     }
    fail:^(id object)
     {
         /*失败返回数据*/
     }];
    
}

@end
