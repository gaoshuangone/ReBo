//
//  AudienceHeaderView.m
//  BoXiu
//
//  Created by andy on 15/12/8.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#define HeadWide 35
#define HeadHeitht 35
#import "AudienceHeaderView.h"
#import "LiveRoomUtil.h"
#import "ChatmemberModel.h"
#define Count_Per_Page (50)

@interface AudienceHeaderView()<UIScrollViewDelegate>
@property (strong, nonatomic)UIScrollView* scrollView;
@property (strong, nonatomic )EWPButton* buttonHead;
@property (strong,nonatomic)NSMutableArray* arrayData;
@property (assign , nonatomic) NSInteger index;
@property (assign , nonatomic) BOOL isCanLoadMore;

@property (assign, nonatomic)BOOL isMoreLimitCount;
@end

@implementation AudienceHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)cleanAudienceHeaderData{
    if (self.arrayData) {
        [self.arrayData removeAllObjects];
     
    }
    if (self.scrollView) {
        for (UIView* view in _scrollView.subviews) {
            [view removeFromSuperview];
        }
    }
}
- (void)initView:(CGRect)frame
{
    self.index=1;
    __weak typeof(self) weakSelf = self;
    if (self.arrayData) {
        [self.arrayData removeAllObjects];
    }
    if (self.scrollView) {
        for (UIView* view in _scrollView.subviews) {
            [view removeFromSuperview];
        }
    }
   
   
    [LiveRoomUtil shartLiveRoonUtil].utilGetLiveRoomDataBlock =^(id modelUil,NSString* strname){
        
        LiveRoomViewController *liveRoomViewController = (LiveRoomViewController *)weakSelf.rootLiveRoomViewController;
        if (modelUil== nil) {
            return ;
        }
        ChatmemberModel* model =(ChatmemberModel*)modelUil;
      
        
        if ( model.result==0) {
            if (weakSelf.arrayData== nil) {
                weakSelf.arrayData = [NSMutableArray array];
            }
            
            if (_index == 1) {
                NSInteger number = model.touristCount + model.memberCount;
                if (number<9950) {
                    liveRoomViewController.audienceLabel.text = [NSString stringWithFormat:@"%ld",(long)number];
                }
                else
                {
                    liveRoomViewController.audienceLabel.text = [NSString stringWithFormat:@"%.1fW",(float)number/10000];
                }
            }
       
                if ([model.chatMemberMArray count] < Count_Per_Page||model.pageIndex *model.pageSize  >= model.recordCount||[self.arrayData count]>=249 ) {
                    weakSelf.isCanLoadMore = NO;
                }else{
                     weakSelf.isCanLoadMore = YES;
                }
          
            
            if (self.index==1) {
                if (model.chatMemberMArray.count!= 0) {
                    [model.chatMemberMArray removeObjectAtIndex:0];
                }
                
            }
            
            
        for (UserInfo* usefInfoBj in model.chatMemberMArray) {
            
            BOOL chongfu = NO;

                for (UserInfo* usefInfoEd in self.arrayData) {
                    if (usefInfoBj.userId==usefInfoEd.userId) {
                         chongfu = YES;
                        break;
                    }
                }
            if (!chongfu) {
                [self.arrayData addObject:usefInfoBj];
            }
                
            }
            

            
            
          
//            [weakSelf.arrayData  addObjectsFromArray:model.chatMemberMArray];
            
            
//            if ([model.chatMemberMArray count] < Count_Per_Page || model.pageIndex *model.pageSize  >= model.recordCount || weakSelf.arrayData.count>250)//大于250头部刷新数据了，当人数变少了刷新数据
//            {
//                
//                
////                if ([model.chatMemberMArray count] < Count_Per_Page||model.pageIndex*model.pageSize>=model.recordCount)    //当前聊天的人数不足一页时(20人)
////                {
////                    self.tableView.totalPage = [model.chatMemberMArray count]/Count_Per_Page + ([model.chatMemberMArray count]%Count_Per_Page? 1:0);
////                    
////                    
////                }
//               
//                if (self.index<=maxpage) {
//                    if (weakSelf.arrayData.count>250) {
//                        self.isMoreLimitCount = YES;
//                    }
//                    weakSelf.isCanLoadMore = NO;
//                }el
//                
//                
//        
//            }
//            else
//            {
//                self.isMoreLimitCount = NO;
//                weakSelf.isCanLoadMore = YES;
//            }
//            
            
            
            [weakSelf sortArray];
            _scrollView.contentSize = CGSizeMake((HeadWide+7)*[self.arrayData count], self.frame.size.height);
            
            
            if (weakSelf.arrayData.count>0) {
                [self changeView];
                weakSelf.scrollView.hidden = NO;
                
              
              
            }
            
            
            
        }
        
        
        
    };
    
    self.backgroundColor = [UIColor clearColor];
    
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _scrollView.alwaysBounceHorizontal = NO;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
    [self addSubview:_scrollView];
    
    self.scrollView.hidden = YES;
    
}
-(void)addAudienceHeaderWithModel:(UserEnterRoomModel*)model{
    
    UserInfo* userInfo =[[UserInfo alloc]init];
    userInfo.clientId =model.memberData.clientId;
    userInfo.hidden = model.memberData.hidden;
    userInfo.hiddenindex = model.memberData.hiddenindex;
    userInfo.issupermanager = model.memberData.issupermanager;
    userInfo.consumerlevelweight = model.memberData.consumerlevelweight;
    userInfo.levelWeight = model.memberData.levelWeight;
    userInfo.nick =model.memberData.nick;
    userInfo.photo = model.memberData.photo;
    userInfo.privlevelweight = model.memberData.privlevelweight;
    //    userInfo.realUserId = [[chatMemberDic objectForKey:@"realUserId"] integerValue];
    //    userInfo.time =model.memberData.time;
    userInfo.userId = model.memberData.userId;
    userInfo.staruserid = model.memberData.staruserid;
    userInfo.idxcode =model.memberData.idxcode;
    userInfo.type = model.type;
//    lw = 15   plw = 2   _consumerlevelweight = 13
//    29       10       19
//    45         10             35
//    33          14   19
    
//    25              14          11
    if (self.arrayData == nil) {
//        self.arrayData = [NSMutableArray arrayWithCapacity:50];
        return;
    }
    
    if (userInfo.userId == [UserInfoManager shareUserInfoManager].getUserInfoModel.userInfo.userId) {//刚进入房间时候获取头像列表已经有自己了
        return;
    }
    
    for (UserInfo* usefInfoBj in self.arrayData) {//相同观众进入房间只显示一次
        if (usefInfoBj.userId == userInfo.userId   ) {
            return;
        }
    }
    
    for (UIView* view in _scrollView.subviews) {//清楚页面原有数据
        [view removeFromSuperview];
        
    }
    [self.arrayData addObject:userInfo];//将新观众加入
    [self sortArray];//排序
    _scrollView.contentSize = CGSizeMake((HeadWide+7)*[self.arrayData count], self.frame.size.height);//重新设置画框大小
    
    
    if ((HeadWide+7)*([self.arrayData count]-1)> _scrollView.frameWidth) {//如果画框满了，新观众自动往后移动一个头像的单位
        _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x+(HeadWide+7), 0);
    }
    if (self.arrayData.count>0) {
        self.scrollView.hidden = NO;
        [self changeView];//往画框上添加头像
    }
    
}
-(void)delAudienceHeaderWithModel:(UserEnterRoomModel*)model{
    

    UserInfo* userInfo =[[UserInfo alloc]init];
    userInfo.clientId =model.memberData.clientId;
    userInfo.hidden = model.memberData.hidden;
    userInfo.hiddenindex = model.memberData.hiddenindex;
    userInfo.issupermanager = model.memberData.issupermanager;
    userInfo.consumerlevelweight = model.memberData.consumerlevelweight;
    userInfo.levelWeight = model.memberData.levelWeight;
    userInfo.nick =model.memberData.nick;
    userInfo.photo = model.memberData.photo;
    userInfo.privlevelweight = model.memberData.privlevelweight;
    //    userInfo.realUserId = [[chatMemberDic objectForKey:@"realUserId"] integerValue];
    userInfo.time =model.memberData.time;
    userInfo.userId = model.memberData.userId;
    userInfo.staruserid = model.memberData.staruserid;
    userInfo.idxcode =model.memberData.idxcode;
    userInfo.type = model.type;
    
    if (self.arrayData == nil) {
        self.arrayData = [NSMutableArray arrayWithCapacity:50];
    }
    //    for (UserInfo* usefInfoBj in self.arrayData) {
    //        if (usefInfoBj.userId == userInfo.userId   ) {
    //            [self.arrayData removeObject:usefInfoBj];
    //        }
    //    }
    [self.arrayData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UserInfo* usefIfoBj = (UserInfo*)obj;
        
        NSLog(@"%ld",(long)usefIfoBj.userId);
        NSLog(@"%ld",(long)userInfo.userId);
        if (usefIfoBj.userId == userInfo.userId   ) {
            
            [self.arrayData removeObjectAtIndex:idx];
            *stop = YES;
        }
    }];
    
    
    for (UIView* view in _scrollView.subviews) {
        [view removeFromSuperview];
    }
    [self sortArray];
    _scrollView.contentSize = CGSizeMake((HeadWide+7)*[self.arrayData count], self.frame.size.height);
//    if ((HeadWide+7)*[self.arrayData count]< _scrollView.frameWidth) {
//        _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x-(HeadWide+7), 0);
//    }
    
    [self changeView];
    
}
-(void)sortArray{
    
 NSArray* temp = [self.arrayData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        UserInfo* uf1 = (UserInfo*)obj1;
        UserInfo* uf2 = (UserInfo*)obj2;
      NSComparisonResult resu =  [self comPareSortWithInfo:uf1 withUserInfo:uf2];
        return resu;
    }];
    [self.arrayData removeAllObjects];
    self.arrayData = nil;
    self.arrayData = [NSMutableArray arrayWithArray:temp];
    
}

-(NSComparisonResult)comPareSortWithInfo:(UserInfo*)userInfo1 withUserInfo:(UserInfo*)userInfo2{
    
    if (userInfo1.staruserid == userInfo2.staruserid) {
        if (userInfo1.userId == userInfo2.userId) {
            return 0;
        }
    }
    
    if (userInfo1.type ==2 && userInfo2.type!=2) {
        return 1;
    }
    if (userInfo1.type != 2 && userInfo2.type ==2) {
        return -1;
    }
    
    
    if (userInfo1.levelWeight > userInfo2.levelWeight) {
        return -1;
    }else if (userInfo1.levelWeight < userInfo2.levelWeight){
        return 1;
    }else if (userInfo1.levelWeight == userInfo2.levelWeight){
        if (userInfo1.consumerlevelweight > userInfo2.consumerlevelweight) {
            return -1;
        }else if (userInfo1.consumerlevelweight < userInfo2.consumerlevelweight){
            return 1;
        }
    }
    
    if (userInfo1.userId < userInfo2.userId) {
        return -1;
    }else if (userInfo2.userId < userInfo1.userId){
        return 1;
    }
    
    
    
    
    
    
//    
//    if (userInfo1.privlevelweight==14 && userInfo2.privlevelweight==14) {
//        
//    }
//    if (userInfo1.staruserid == userInfo2.staruserid) {
//        if (userInfo1.userId == userInfo2.userId) {
//            return 0;
//        }
//        
//        if (userInfo1.privlevelweight <userInfo2.privlevelweight) {
//            return 1;
//        }else if (userInfo1.privlevelweight> userInfo2.privlevelweight){
//            return -1;
//        }else if (userInfo1.privlevelweight == userInfo2.privlevelweight){
//            if (userInfo1.consumerlevelweight > userInfo2.consumerlevelweight) {
//                return -1;
//            }else if (userInfo1.consumerlevelweight < userInfo2.consumerlevelweight){
//                return 1;
//            }
//        }
//        
//        
//        if (userInfo1.userId < userInfo2.userId) {
//            return -1;
//        }else if (userInfo2.userId < userInfo1.userId){
//            return 1;
//        }
//        
//    }else{
//        if (userInfo1.staruserid < userInfo2.staruserid) {
//            return -1;
//        }else if (userInfo2.staruserid < userInfo1.staruserid){
//            return 1;
//        }
//    }
    return 0;
    
    
}

-(void)changeView{
    
//    if (self.arrayData.count<250) {
//        if (self.isMoreLimitCount) {
//            self.isCanLoadMore = YES;
//        }
//    }
    
    
    
    
    for (int i =0; i< [self.arrayData count];i++) {
        
        UserInfo* userInfo = [self.arrayData objectAtIndex:i];
        
        if (userInfo.privlevelweight==10) {//黄V
            UIImageView* imageViewKing = [[UIImageView alloc]initWithFrame:CGRectMake((HeadWide+7)*i, 7.2, 12, 12)];
            imageViewKing.image = [UIImage imageNamed:@"kingyell.png"];
            [_scrollView addSubview:imageViewKing];
        }else if (userInfo.privlevelweight==14){//紫V
            UIImageView* imageViewKing = [[UIImageView alloc]initWithFrame:CGRectMake((HeadWide+7)*i,7.2, 12, 12)];
            imageViewKing.image = [UIImage imageNamed:@"kingzi.png"];
            [_scrollView addSubview:imageViewKing];
        }
        
        
        
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake((HeadWide+7)*i, 14, HeadWide, HeadHeitht)];
        imageView.userInteractionEnabled = YES;
        
        NSURL *headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,userInfo.photo]];
        [imageView sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@"LRheadList70.png"]];
        //        imageView.image =[UIImage imageNamed:@"LRheadList70.png"];
        [imageView.layer setMasksToBounds:YES];
        imageView.layer.borderWidth = 0.5;
        imageView.layer.borderColor = [CommonFuction colorFromHexRGB:@"ffffff"].CGColor;
        imageView.layer.cornerRadius =17.5;
        [_scrollView addSubview:imageView];
        
        UIControl* control =[[UIControl alloc]initWithFrame:imageView.frame];
        control.tag = i+100;
        [control addTarget:self action:@selector(controlTouch:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:control];
        
    }
}
-(void)controlTouch:(UIControl*)sender{
    
    UIControl* control = sender;
    control.userInteractionEnabled = NO;
    [self performSelector:@selector(delayTimer:) withObject:control afterDelay:3];
    UserInfo* userInfo = [self.arrayData objectAtIndex:sender.tag-100];
    self.audienceHeaderViewTouch(userInfo);
}
-(void)delayTimer:(UIControl*)sender{
    UIControl* control = sender;
    control.userInteractionEnabled = YES;
}
-(void)initAudienceHeaderViewData{
    [[LiveRoomUtil shartLiveRoonUtil]utilGetDataFromRoomUtilWithParams:[NSNumber numberWithInteger:self.index] withServerMothod:Get_ChatMember_Method];
    
}
- (void)viewWillAppear
{
    [super viewWillAppear];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    CGPoint offset = scrollView.contentOffset;
    
    
    
    CGRect bounds = scrollView.bounds;
    
    
    
    CGSize size = scrollView.contentSize;
    
    
    
    UIEdgeInsets inset = scrollView.contentInset;
    
    
    
    CGFloat currentOffset = offset.x + bounds.size.width - inset.right;
    
    
    
    CGFloat maximumOffset = size.width;
    
    
    
    //当currentOffset与maximumOffset的值相等时，说明scrollview已经滑到底部了。也可以根据这两个值的差来让他做点其他的什么事情
    
    
    
    if(currentOffset==maximumOffset)
        
    {
        
        NSLog(@"-----我要刷新数据-----");
        
        if (self.isCanLoadMore) {
            self.index++;
            [self initAudienceHeaderViewData];
        }
    }
    
    
}

- (void)viewwillDisappear
{
    [super viewwillDisappear];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
