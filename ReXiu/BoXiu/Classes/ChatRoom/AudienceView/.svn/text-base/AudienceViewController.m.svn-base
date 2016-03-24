//
//  AudienceViewController.m
//  BoXiu
//
//  Created by andy on 15-1-9.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "AudienceViewController.h"
#import "AudienceCell.h"
#import "AudieceToolCell.h"


#define Count_Per_Page (20)

@interface AudienceViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate,AudienceToolDelegate>

@property (nonatomic,strong) NSMutableArray *chatMemberMArray;
@property (nonatomic,assign) int currentSelectIndex;
@property (nonatomic,assign) NSInteger maxViewerCount;
@property (nonatomic,assign) NSInteger showTpe;//房间类型

@end

@implementation AudienceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseTableViewType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.currentSelectIndex = -2;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate   = self;
    self.tableView.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];

    [self refreshData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)initData:(NSInteger)showType
{
    self.showTpe = showType;
    
    [self refreshData];
}

- (void)refreshData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isPagination"];//是不是页码
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"pageIndex"];  //页面索引
    [dict setObject:[NSNumber numberWithInt:Count_Per_Page] forKey:@"pageSize"];//页面大小
    [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];//当前主播的id
    
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo; //当前主播信息
    ChatmemberModel *model = [[ChatmemberModel alloc] init];    //聊天者信息
    NSString *serverIp= [NSString stringWithFormat:@"http://%@:%ld/mobile/dispatch.mobile",starInfo.serverip,(long)starInfo.serverport];

    if (starInfo.serverip == nil)
    {
        serverIp = [AppInfo shareInstance].requestServerBaseUrl;
    }
    [dict addEntriesFromDictionary:[model signParamWithMethod:Get_ChatMember_Method]];
    [model requestDataWithBaseUrl:serverIp requestType:nil method:Get_ChatMember_Method httpHeader:[model httpHeaderWithMethod:Get_ChatMember_Method] params:dict success:^(id object)
     {
         if (_chatMemberMArray == nil)
         {
             _chatMemberMArray = [NSMutableArray array];
         }
         [self.chatMemberMArray removeAllObjects];
         [self.chatMemberMArray addObjectsFromArray:[self deleteHidenUserInfo:model.chatMemberMArray]];
         self.touristCount = model.touristCount;
         self.maxViewerCount = model.maxViewerCount;
         self.recordCount = model.recordCount;
         if ([model.chatMemberMArray count] < Count_Per_Page)
         {
             self.tableView.totalPage = [self.chatMemberMArray count]/Count_Per_Page + ([self.chatMemberMArray count]%Count_Per_Page? 1:0);
         }
         else
         {
             self.tableView.totalPage = 999;
         }
         if (self.delegate && [self.delegate respondsToSelector:@selector(updateTouristCount:recordCountshowGift:)])
         {
             [self.delegate updateTouristCount:self.touristCount recordCountshowGift:self.recordCount];
         }
         [self.tableView reloadData];
     } fail:^(id object) {
         [self.tableView reloadData];
     }];
    [model autAddNumber];//在外面调用此函数要手动调用增肌计数，
}

- (void)loadMorData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isPagination"]; //是否为页码的标记
    [dict setObject:[NSNumber numberWithInteger:self.tableView.curentPage + 1] forKey:@"pageIndex"];
    [dict setObject:[NSNumber numberWithInteger:Count_Per_Page] forKey:@"pageSize"]; //每页的pageSize == 20
    [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];//当前主播的id
    
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;//当前主播信息
    ChatmemberModel *model = [[ChatmemberModel alloc] init]; //聊天人
    NSString *serverIp = [NSString stringWithFormat:@"http://%@:%ld/mobile/dispatch.mobile",starInfo.serverip,(long)starInfo.serverport];
    
    if (starInfo.serverip == nil)           //当前主播的 serverip （标识符？）
    {
        serverIp = [AppInfo shareInstance].requestServerBaseUrl;
    }
    
    [dict addEntriesFromDictionary:[model signParamWithMethod:Get_ChatMember_Method]]; //获取聊天者信息（添加进dict）
    
    NSDictionary *header = [model httpHeaderWithMethod:Get_ChatMember_Method]; //获取聊天者信息（存入dict？）
    /*模块向网络层请求数据*/
    [model requestDataWithBaseUrl:serverIp requestType:nil method:Get_ChatMember_Method httpHeader:header params:dict
        success:^(id object) {
        if (_chatMemberMArray == nil)
        {
            _chatMemberMArray = [NSMutableArray array];
        }
        
        [self.chatMemberMArray addObjectsFromArray:[self deleteHidenUserInfo:model.chatMemberMArray]];
        if ([model.chatMemberMArray count] < Count_Per_Page)    //当前聊天的人数不足一页时(20人)
        {
            self.tableView.totalPage = [self.chatMemberMArray count]/Count_Per_Page + ([self.chatMemberMArray count]%Count_Per_Page? 1:0);
        }  //计算出总页数
        else //否则有999页
        {
            self.tableView.totalPage = 999;
        }
        self.touristCount = model.touristCount;
        self.maxViewerCount = model.maxViewerCount;
        self.recordCount = model.recordCount;
        if (self.delegate && [self.delegate respondsToSelector:@selector(updateTouristCount:recordCountshowGift:)])
        {
            [self.delegate updateTouristCount:self.touristCount recordCountshowGift:self.recordCount];
        }
        [self.tableView reloadData];
    } fail:^(id object) {
        [self.tableView reloadData];
    }];
}

- (NSArray *)deleteHidenUserInfo:(NSArray *)chatMemberArray       //将隐身用户移出用户列表，显示最终的列表
{
    UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    NSMutableArray *userInfoArray = [NSMutableArray arrayWithArray:chatMemberArray];
    for (UserInfo *userInfo in chatMemberArray)
    {
        if (currentUserInfo && currentUserInfo.userId == userInfo.userId)
        {
            //如果隐身用户为当前用户，则显示。           如果此用户即为当前用户，跳过判断(无论是否隐身都显示)
            continue;
        }
        
        if (userInfo.hidden == 2)
        {
            if (currentUserInfo.issupermanager) //超管看不到隐身的超管，但可以看到隐身的用户
            {
                if (userInfo.issupermanager)
                {
                    [userInfoArray removeObject:userInfo];
                }
                else
                {
                    continue;
                }
            }
            else                    //普通用户看不到隐身用户
            {
                [userInfoArray removeObject:userInfo];
            }
        }
    }
    return userInfoArray;           //最终得到的用户列表
}

- (UserInfo *)userInfoByUserId:(NSInteger)userId //聊天者不为0时返回聊天者信息
{
    if (self.chatMemberMArray && [self.chatMemberMArray count])
    {
        for (UserInfo *userInfo in self.chatMemberMArray)
        {
            if (userInfo.userId == userId)
            {
                return userInfo;
            }
        }
    }
    return nil;
}

#pragma mark -根据userId删除聊天者(禁言？)
- (void)deleteUserByUserId:(NSInteger)userId
{
    if (self.chatMemberMArray && [self.chatMemberMArray count])
    {
        NSMutableArray *deleteRows=[[NSMutableArray alloc] init];   // 生成要删除的序列
        for(NSIndexPath *indexPath in self.tableView.indexPathsForVisibleRows) //遍历当前屏幕上的cell的序列号
        {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if ([cell isKindOfClass:[AudienceCell class]]) //如果是观众cell
            {
                AudienceCell *audienceCell = (AudienceCell *)cell;
                if (audienceCell.userInfo.userId == userId) //找到匹配的userID时移出聊天数组/列表
                {
                    [deleteRows addObject:indexPath];
                    [self.chatMemberMArray removeObject:audienceCell.userInfo];
                }
            }
            else if([cell isKindOfClass:[AudieceToolCell class]]) //如果是对观众进行操作的cell （聊天，送礼，禁言，踢人，举报）
            {
                [deleteRows addObject:indexPath];
                self.currentSelectIndex = -2;                     //将currentSelectIndex重置为 -2
                break;
            }
        }
        if ([deleteRows count])
        {
            [self.tableView deleteRowsAtIndexPaths:deleteRows withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

#pragma mark - BaseTableViewDataSource
- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return 1;
}


- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    int nCount =  [self.chatMemberMArray count] + (self.currentSelectIndex == -2? 0:1);//如果currentSelectIndex不为 -2 则增加一个cell
    if ( self.touristCount > 0)
    {
        //所有游客只用1个Cell来表示
        nCount += 1;
    }
    return nCount;
}


- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EWPLog(@"indexPath:%ld",(long)indexPath.row);
    static NSString *cellIdentifier = @"Cell";
    static NSString *toolCellIdentifier = @"ToolCell";
    static NSString *touristCellIdentifier = @"touristCellIdentifier";
    UITableViewCell *cell = nil;
    if (self.currentSelectIndex == indexPath.row - 1)//生成的操作的cell应该与其上一个cell关联起来（点击的是currentSelectIndex的cell，生成的是indexPth.row的cell）
    {
        AudieceToolCell *audienceToolCell = [baseTableView dequeueReusableCellWithIdentifier:toolCellIdentifier];
        if (audienceToolCell == nil)
        {
            audienceToolCell = [[AudieceToolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:toolCellIdentifier];
            audienceToolCell.accessoryType = UITableViewCellAccessoryNone; //cell无样式(右边无箭头等 )
            audienceToolCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        EWPLog(@"count = %lu;indexPath.Row=%ld",(unsigned long)[self.chatMemberMArray count],(long)indexPath.row);
        audienceToolCell.userInfo = [self.chatMemberMArray objectAtIndex:self.currentSelectIndex];
        audienceToolCell.delegate = self;
        audienceToolCell.showType = self.showTpe;
        cell = audienceToolCell;
    }
    else
    {
        int nCount =  [self.chatMemberMArray count] + (self.currentSelectIndex == -2? 0:1); // currentSelectectIndex不为-2时，cell增加一个
        if ( self.touristCount > 0)//只要有游客，游客都显示为一个Cell即可
        {
            nCount += 1;
        }
        if (indexPath.row == nCount - 1) //如果当前的Cell是最后一个
        {
            if (self.touristCount > 0)  //且有游客
            {
                UITableViewCell *touristCell = [baseTableView dequeueReusableCellWithIdentifier:touristCellIdentifier];
                if (touristCell == nil)
                {
                    touristCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:touristCellIdentifier];
                    touristCell.backgroundColor = [UIColor clearColor];
                    touristCell.accessoryType = UITableViewCellAccessoryNone;
                    touristCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    touristCell.textLabel.font = [UIFont systemFontOfSize:15.0f];
                }
                
                NSString *countStr = [NSString stringWithFormat:@"%ld",(long)self.touristCount];
                NSInteger leng = [countStr length];
                NSString *tourStr = [NSString stringWithFormat:@"%@位游客",countStr];
                
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tourStr];
//                [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"ff6666"] range:NSMakeRange(0,leng)];
//                [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"575757"] range:NSMakeRange(leng,3)];
                [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"F7C250"] range:NSMakeRange(0,leng)];
                [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"A4A4A4"] range:NSMakeRange(leng,3)];
                touristCell.textLabel.attributedText = str;

                cell = touristCell;
            }
            else    //没有游客
            {
                AudienceCell *audienceCell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (audienceCell == nil)
                {
                    audienceCell = [[AudienceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    audienceCell.backgroundColor = [UIColor whiteColor];
                    audienceCell.accessoryType = UITableViewCellAccessoryNone;
                    audienceCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                if (self.currentSelectIndex == -2 || indexPath.row <= self.currentSelectIndex)
                {
                    audienceCell.userInfo = [self.chatMemberMArray objectAtIndex:indexPath.row];
                }
                else
                {
                    audienceCell.userInfo = [self.chatMemberMArray objectAtIndex:indexPath.row - 1];
                }
                
                
                if (self.currentSelectIndex == indexPath.row)
                {
                    audienceCell.IsOpen = YES;
                }
                else
                {
                    audienceCell.IsOpen = NO;
                }
                cell = audienceCell;
                
            }
        }
        else
        {
            AudienceCell *audienceCell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (audienceCell == nil)
            {
                audienceCell = [[AudienceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                audienceCell.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
                audienceCell.accessoryType = UITableViewCellAccessoryNone;
                audienceCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if (self.currentSelectIndex == -2 || indexPath.row <= self.currentSelectIndex)
            {
                audienceCell.userInfo = [self.chatMemberMArray objectAtIndex:indexPath.row];
            }
            else
            {
                audienceCell.userInfo = [self.chatMemberMArray objectAtIndex:indexPath.row - 1];
            }
            
            
            if (self.currentSelectIndex == indexPath.row)
            {
                audienceCell.IsOpen = YES;
            }
            else
            {
                audienceCell.IsOpen = NO;
            }
            cell = audienceCell;
            
        }
    }
    return cell;
    
}

#pragma mark - BaseTableViewDelegate
- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EWPLog(@"indexPath:%ld",(long)indexPath.row);
    
    if (self.currentSelectIndex == indexPath.row - 1)
    {
        return [AudieceToolCell heightOfShowType:self.showTpe];
    }
    else
    {
        int nCount =  [self.chatMemberMArray count] + (self.currentSelectIndex == -2? 0:1);
        if ([self.chatMemberMArray count] == self.recordCount && self.touristCount > 0)
        {
            //游客累计显示一个cell
            nCount += 1;
        }
        if (indexPath.row == nCount - 1)
        {
            if (self.touristCount > 0)
            {
                return 60.0f;
            }
            else
            {
                return [AudienceCell height];
            }
        }
        else
        {
            return [AudienceCell height];
        }
    }
    return [AudienceCell height];
}

- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EWPLog(@"didSelectIndex:%ld",(long)indexPath.row);
    int nOldSelectIndex = self.currentSelectIndex;
    
    UITableViewCell *cell = [baseTableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[AudienceCell class]])
    {
        AudienceCell *audienceCell = (AudienceCell *)cell;
        if (audienceCell.IsOpen)
        {
            self.currentSelectIndex = -2;
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationBottom];
        }
        else
        {
            if (self.currentSelectIndex != -2)
            {
                NSIndexPath *deleteIndexPath = [NSIndexPath indexPathForRow:self.currentSelectIndex inSection:0];
                self.currentSelectIndex = -2;
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:deleteIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
                
                if (indexPath.row > nOldSelectIndex + 1)//????????????
                {
                    self.currentSelectIndex = indexPath.row - 1;
                    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationBottom];
                }
                else                                    //?????????????
                {
                    self.currentSelectIndex = indexPath.row;
                    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationBottom];
                }
            }
            else
            {
                self.currentSelectIndex = indexPath.row;//?????????????
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationBottom];
            }
        }
        //更新currentSelectIndex
        [baseTableView reloadData];
    }
}

#pragma mark - AudienceToolDelegate
- (void)audieceToolCell:(AudieceToolCell *)audieceToolCell didSelectIndex:(int)index
{
    UserInfo *chatMember = [self.chatMemberMArray objectAtIndex:self.currentSelectIndex];
    NSInteger nIndex = index;
    if (self.showTpe == 3)
    {
        nIndex += 1;
    }
    switch (nIndex)
    {
        case 0:
        {
            //送ta礼物
            if (self.delegate && [self.delegate respondsToSelector:@selector(audienceViewController:showGift:)])
            {
                [self.delegate audienceViewController:self showGift:chatMember];
            }
        }
            break;
        case 1:
        {
            //与他聊天
            if (self.delegate && [self.delegate respondsToSelector:@selector(audienceViewController:chatWithUser:)])
            {
                [self.delegate audienceViewController:self chatWithUser:chatMember];
            }
            
        }
            break;
        case 2:
        {
            //踢出房间
            if (self.delegate && [self.delegate respondsToSelector:@selector(audienceViewController:kickPerson:)])
            {
                [self.delegate audienceViewController:self kickPerson:chatMember];
            }
        }
            break;
        case 3:
        {
            //禁言5分钟
            if (self.delegate && [self.delegate respondsToSelector:@selector(audienceViewController:forbidSpeak:)])
            {
                [self.delegate audienceViewController:self forbidSpeak:chatMember];
            }
        }
            break;
        case 4:
        {
            //举报TA
            if (self.delegate && [self.delegate respondsToSelector:@selector(audienceViewController:report:)])
            {
                [self.delegate audienceViewController:self report:chatMember];
            }
        }
            break;
        default:
            break;
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
