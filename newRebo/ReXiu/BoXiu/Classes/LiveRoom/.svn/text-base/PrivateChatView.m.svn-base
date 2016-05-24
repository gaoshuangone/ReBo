//
//  PrivateChatView.m
//  BoXiu
//
//  Created by andy on 15/12/9.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "PrivateChatView.h"
#import "UIView+Tools.h"
#import "DropList.h"
#import "UIImage+RTTint.h"
#define HeadImageWidth         40.0f
#define LabelMarginWidth       30.0f
#define VerticalSpace          10

@interface PrivateChatView()<DropListDelegate,DropListDataSource>
@property (nonatomic,strong) NSMutableArray *messageMArray;
@property (nonatomic,strong) NSMutableArray *messageLableMArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSLock  *lock;
@property (nonatomic,strong) UIControl* controlGes;
@property (nonatomic,strong) DropList *memberList;
@property (nonatomic,strong) UserInfo *targetUserInfo;
@property (nonatomic,strong) NSMutableArray *memberInfoMArray;//聊天成员列表

@end
@implementation PrivateChatView
- (void)viewWillAppear
{
    [super viewWillAppear];
    
}
- (void)initView:(CGRect)frame
{
    _controlGes =[[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_controlGes addTarget:self action:@selector(controlGe) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview: _controlGes];
    
    UIControl* controlTopView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 76/2)];
    controlTopView.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [self addSubview:controlTopView];
    
    EWPButton* buttonColose = [EWPButton buttonWithType:UIButtonTypeCustom];
    [buttonColose setImage:[UIImage imageNamed:@"LRprivateChatclose.png"] forState:UIControlStateNormal];
    buttonColose.frame = CGRectMake(SCREEN_WIDTH-10-22-4, 0, 38, 38);
    __weak typeof(self) weakSelf  = self;
    buttonColose.buttonBlock = ^(EWPButton* sender){
        [weakSelf hidPrivateChatViewWithisHid:YES];
    };
    [self addSubview:buttonColose];
    self.backgroundColor =[CommonFuction colorFromHexRGB:@"f6f6f6"];
    
    
    
    
    
    _lock = [[NSLock alloc] init];
    _messageMArray = [[NSMutableArray alloc] initWithCapacity:0];
    _messageLableMArray = [NSMutableArray array];
    
    _memberList = [[DropList alloc] initWithFrame:CGRectMake(9, 8, 100, 22) showInView:self.containerView];
    _memberList.delegate = self;
    _memberList.dataSource = self;
    _memberList.strControllerNeeded = @"PrivateChatView";
    
    _memberList.selectTextColor = [CommonFuction colorFromHexRGB:@"959596"];
    _memberList.selectBackColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _memberList.listBackColor = [UIColor whiteColor];
    
    _memberList.listTextColor = [CommonFuction colorFromHexRGB:@"959596"];
    _memberList.backView.layer.borderColor = [UIColor clearColor].CGColor;
    _memberList.layer.borderColor = [CommonFuction colorFromHexRGB:@"cbcbcb"].CGColor;
    _memberList.layer.borderWidth = 0.5;
    [self addSubview:_memberList];
    
    
    
    
    
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.frame = CGRectMake(0, 96/2, SCREEN_WIDTH, 570/2-96/2-33-(96-76)/2);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:_tableView];
}
- (void)setTargetUserInfo:(UserInfo *)targetUserInfo
{
    _targetUserInfo = targetUserInfo;
    self.memberList.selectedText = targetUserInfo.nick;
    
    LiveRoomViewController* lr = (LiveRoomViewController*)self.rootLiveRoomViewController;
    [lr lrTaskNumberWithParms:targetUserInfo withMumber:4];
    
}
- (void)changeFieldText{
    self.targetUserInfo = _targetUserInfo;
}

- (void)addChatMember:(UserInfo *)userInfo
{
    if(_memberInfoMArray == nil)
    {
        _memberInfoMArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    BOOL bHasUserInfo = NO;
    for (UserInfo *user in self.memberInfoMArray)
    {
        if (userInfo.userId == user.userId)
        {
            bHasUserInfo = YES;
            break;
        }
    }
    if (!bHasUserInfo)
    {
        [self.memberInfoMArray addObject:userInfo];
    }
    
    if (self.memberInfoMArray.count==1) {
        self.targetUserInfo =userInfo;
    }
    
}
#pragma mark - DropListDelegate

- (void)dropList:(DropList *)dropList didSelectedIndex:(NSInteger)index
{
    UserInfo *userInfo = [_memberInfoMArray objectAtIndex:index];
    if (userInfo)
    {
        self.targetUserInfo = userInfo;
    }
    
}
- (void)dropList:(DropList *)dropList didSelectedItem:(UserInfo *)userInfo
{
    if (userInfo)
    {
        self.targetUserInfo = userInfo;
    }
}

#pragma mark -DropListDataSource

- (NSInteger)numberOfRowsInDropList:(DropList *)dropList
{
    return [self.memberInfoMArray count];
}

- (NSString *)dropList:(DropList *)dropList textOfRow:(NSInteger)row
{
    UserInfo *userInfo = [self.memberInfoMArray objectAtIndex:row];
    return userInfo.nick;
}
-(void)controlGe{
    [self hidPrivateChatViewWithisHid:YES];
}
-(void)hidPrivateChatViewWithisHid:(BOOL)isHid{
    self.hidden = isHid;
    _controlGes.hidden = isHid;
    
    if (isHid) {
        LiveRoomViewController* lr =(LiveRoomViewController*)self.rootLiveRoomViewController;
        [lr lrTaskNumberWithParms:nil withMumber:3];
    }
}
- (void)clearAllMessage
{
    if (_messageMArray )
    {
        [_messageMArray removeAllObjects];
    }
    
    if (_messageLableMArray)
    {
        [_messageLableMArray removeAllObjects];
    }
}
- (void)addChatMessage:(ChatMessageModel *)chatMessageModel
{
    
    
    if (chatMessageModel != nil) {
        
        UserInfo *info = nil;
        if (chatMessageModel.userid != 0 && [chatMessageModel.nick length] > 0)
        {
            UserInfo *userInfo = [[UserInfo alloc] init];
            userInfo.userId = chatMessageModel.userid;
            userInfo.nick = chatMessageModel.nick;
            userInfo.hidden = chatMessageModel.hidden;
            userInfo.hiddenindex = chatMessageModel.hiddenindex;
            userInfo.issupermanager = chatMessageModel.issupermanager;
            userInfo.photo = chatMessageModel.photo;
            [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
            info = userInfo;
        }
        
        if (_messageMArray == nil)
        {
            _messageMArray = [NSMutableArray array];
        }
        //    NSString *headString = nil;
        //    headString = [NSString stringWithFormat:@"{%ld}对{%ld}说: ",(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
        //
        //    NSString *chatMessage = [NSString stringWithFormat:@"%@%@",headString,chatMessageModel.msg];
        
        NSString *headString = nil;
        if (chatMessageModel.targetUserid == 0)
        {   //对所有人说：发言用户头像+@发言用户昵称+换行+发言内容
            headString =[NSString stringWithFormat:@"{%ld}\n",(long)chatMessageModel.userid];
        }
        else
        {   //对别人说：发言用户头像+@发言用户昵称+换行+@发言对象昵称+空格+发言内容
            //        headString = [NSString stringWithFormat:@"{%ld}\n ",(long)chatMessageModel.userid];
            
            if (  [UserInfoManager shareUserInfoManager].currentUserInfo.userId==chatMessageModel.userid) {
                headString = [NSString stringWithFormat:@"{%ld} ",(long)chatMessageModel.targetUserid];
            }else{
                headString = [NSString stringWithFormat:@"{%ld}\n",(long)chatMessageModel.userid];
            }
        }
        NSString *chatMessage = [NSString stringWithFormat:@"%@%@",headString,chatMessageModel.msg];
        
        [self creatLabelWithChatMessage:chatMessage userInfo:info isEnter:NO];
    }else{//默认的主播话语
        
        [self  clearAllMessage];

        ChatMessageModel *model = [[ChatMessageModel alloc] init];
        StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
        model.userid = starInfo.userId;
        model.nick = starInfo.nick;
        model.photo = starInfo.photo;
        model.msg = @"欢迎进入我的房间，快来跟我聊天吧！";
        self.targetUserInfo = starInfo;
        
        [self addChatMember:starInfo];

        [self addChatMessage:model];
    }
    
}

- (BOOL)IsScrollToBottom
{
    NSArray *cellArray =  self.tableView.visibleCells;
    if (cellArray && [cellArray count])
    {
        UITableViewCell *cell = [cellArray objectAtIndex:[cellArray count] - 1];
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        
        if (path.row == self.messageMArray.count - 1 || path.row == self.messageMArray.count - 2)
        {
            return YES;
        }
        return NO;
    }
    return NO;
}

- (void)addMessageLabel:(OHAttributedLabel *)messageLabel
{
    if (messageLabel == nil)
    {
        return;
    }
    if (_messageLableMArray.count > 100)
    {
        [_messageLableMArray removeObjectAtIndex:0];
        [_messageMArray removeObjectAtIndex:0];
    }
    [_messageLableMArray addObject:messageLabel];
    
}

- (void)creatLabelWithChatMessage:(NSString *)chatMessage userInfo:(UserInfo *)userInfo;
{
    [self creatLabelWithChatMessage:chatMessage userInfo:userInfo isEnter:YES];
    
}

- (void)creatLabelWithChatMessage:(NSString *)chatMessage userInfo:(UserInfo *)userInfo isEnter:(BOOL)isEnter;
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ShowBarAndChat object:nil];
    [_lock lock];
    [self.messageMArray addObject:[CustomMethod escapedString:chatMessage]];
    OHAttributedLabel *messageLabel = [self createMessageLabelWithMessage:chatMessage isEnter:isEnter];
    messageLabel.isEnter = isEnter;
    messageLabel.info = userInfo;
    [self addMessageLabel:messageLabel];
    [CustomMethod drawImage:messageLabel];
    [_lock unlock];
    [self.tableView reloadData];
    
    if ([self IsScrollToBottom])
    {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.messageMArray count] - 1 inSection:0]
                              atScrollPosition: UITableViewScrollPositionBottom
                                      animated:YES];
        
    }
    //    [self createHeadImageWithMessage:chatMessage];
    [_lock unlock];
    
    //    if ([self IsScrollToBottom])
    //    {
    //        if (_messageLableMArray.count)
    //        {
    //            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[_messageLableMArray count] - 1 inSection:0]
    //                                  atScrollPosition: UITableViewScrollPositionBottom
    //                                          animated:YES];
    //        }
    //    }
}

- (OHAttributedLabel *)createMessageLabelWithMessage:(NSString *)message isEnter:(BOOL)isEnter
{
    
    OHAttributedLabel *messageLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.linkColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    //    messageLabel.font = [UIFont systemFontOfSize:14.0f];
    //    [messageLabel setNeedsDisplay];
    
    
    //处理用户名
    NSMutableArray *outParam = [NSMutableArray array];
    NSString *text = message;
    NSArray *userArray = [CustomMethod addObjectArr:text beginFlage:@"{" endFlag:@"}"];
    
    
    if (userArray && [userArray count])
    {
        NSDictionary *chatMemberDic = [[UserInfoManager shareUserInfoManager] allUserIdAndNick];
        for (NSString *flagUserId in userArray)
        {
            
            NSString *userId = [[NSString alloc] initWithString:[flagUserId substringWithRange:NSMakeRange(1, [flagUserId length] - 2)]];
            NSString *nick = [chatMemberDic objectForKey:[NSNumber numberWithInteger: [userId integerValue]]];
            NSLog(@"%ld~~~~~~~~~~",[UserInfoManager shareUserInfoManager].currentUserInfo.userId);
            
            if (  [text rangeOfString:@"\n"].length==0) {
                messageLabel.isSelf = YES;
                nick = [NSString stringWithFormat:@"@%@",nick];
            }else{
                
                nick = [NSString stringWithFormat:@"%@",nick];
            }
            
            if (nick)
            {
                NSRange soureRange = [text rangeOfString:flagUserId];
                text =  [text stringByReplacingCharactersInRange:NSMakeRange(soureRange.location, soureRange.length) withString:nick];
                
                NSInteger nickLength = [nick length];
                NSRange desRange = NSMakeRange(soureRange.location, nickLength);
                
                NSMutableDictionary *userInfoDic = [NSMutableDictionary dictionary];
                [userInfoDic setObject:userId forKey:@"userid"];
                [userInfoDic setObject:NSStringFromRange(desRange) forKey:@"range"];
                [outParam addObject:userInfoDic];
            }
        }
    }
    
    
    //处理表情,现在表情都是从网络获取，缓冲到本地。
    NSArray *emotionArray = [CustomMethod addObjectArr:text beginFlage:@"[" endFlag:@"]"];
    if (emotionArray && [emotionArray count])
    {
        for (NSString *flagEmotion in emotionArray)
        {
            NSString *emotion = [[NSString alloc] initWithString:[flagEmotion substringWithRange:NSMakeRange(1, [flagEmotion length] - 2)]];
            EmotionData *emotionData = [[[EmotionManager shareInstance] allEmotion] objectForKey:emotion];
            if (emotionData)
            {
                CGFloat width = emotionData.width;
                CGFloat height = emotionData.height;
                if (height > 13)
                {
                    width = width * 13 / height;
                    height = 13;
                }
                if (emotionData.emotionType==2) {//VIP表情
                    width = 35;
                    height =    35;
                }
                
                NSRange emotionRange = [text rangeOfString:flagEmotion];
                NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,emotionData.mlink];
                NSString *imageHtml = [NSString stringWithFormat:@"<img src='%@' width='%.1f' height='%.1f'>",url,width,height];
                text = [text stringByReplacingCharactersInRange:NSMakeRange(emotionRange.location, [flagEmotion length]) withString:imageHtml];
            }
        }
    }
    
    //处理其他图片，可以根据需求之地鞥大小
    text = [CustomMethod transformStringToWebImage:text imgSize:CGSizeZero];
    text = [NSString stringWithFormat:@"<font color='#7a7a7a' strokeColor='#7a7a7a' face='Palatino-Roman'>%@",text];
    
    NSRange rang = [text rangeOfString:@"'>"];
    NSString * str1 =[text substringFromIndex:rang.location+2] ;
    NSString* str2 = [text substringToIndex:rang.location+2];//'>以前的
    NSRange rang_img = [str1  rangeOfString:@"<img"];
    NSString* str3 = nil;
    if (rang_img.location != NSNotFound) {
        
        str3 = [str1 substringFromIndex:rang_img.location];//<img以后的，图标
        
        str1 = [str1 substringToIndex:rang_img.location];
    }
    str1 =[str1 stringByReplacingOccurrencesOfString:@"<" withString:@"&lt"];//'>与<img之间位置也就是昵称,
    str1 =[str1 stringByReplacingOccurrencesOfString:@">" withString:@"&gt"];//'>与<img之间位置也就是昵称,
    //     str1 =[str1 stringByReplacingOccurrencesOfString:@"^" withString:@"$!,"];//'>与<img之间位置也就是昵称,
    if (str3== nil) {//如果有图标
        text = [NSString stringWithFormat:@"%@%@",str2,str1];
    }else{
        text = [NSString stringWithFormat:@"%@%@%@",str2,str1,str3];
    }
    MarkupParser *wk_markupParser = [[MarkupParser alloc] init];
    NSMutableAttributedString* attString = [wk_markupParser attrStringFromMarkup:text];
    
    
    //    if ([attString.string rangeOfString:@",~,"].location != NSNotFound) {//把原来的“<”替换过来
    //        attString   = [[NSMutableAttributedString alloc]initWithString:[attString.string stringByReplacingOccurrencesOfString:@",~," withString:@"<"]];
    //    }
    //    if ([attString.string rangeOfString:@"!~!"].location != NSNotFound) {//把原来的“<”替换过来
    //        attString   = [[NSMutableAttributedString alloc]initWithString:[attString.string stringByReplacingOccurrencesOfString:@",~," withString:@"<"]];
    //    }
    //    if ([attString.string rangeOfString:@"$!,"].location != NSNotFound) {//把原来的“<”替换过来
    //        attString   = [[NSMutableAttributedString alloc]initWithString:[attString.string stringByReplacingOccurrencesOfString:@",~," withString:@"^"]];
    //    }
    
    
    
    CGFloat fontSize = 13;
    //    if (isEnter)
    //    {
    //        fontSize = 12;
    //    }
    [attString setFont:[UIFont systemFontOfSize:fontSize]];
    [messageLabel setBackgroundColor:[UIColor clearColor]];
    
    //设置行间距
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:1];
    [attString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attString length])];
    
    //    if (!isEnter && [outParam count])
    //    {
    //        NSDictionary *userInfo = [outParam firstObject];
    //        NSString *strRange = [userInfo objectForKey:@"range"];
    //        NSRange range = NSRangeFromString(strRange);
    //        [attString setFont:[UIFont systemFontOfSize:12] range:range];
    //    }
    
    
    [messageLabel setAttString:attString withImages:wk_markupParser.images];
    
    //增加链接
    if ([outParam count])
    {
        for (NSDictionary *userInfo in outParam)
        {
            NSInteger index = [outParam indexOfObject:userInfo];
            NSString *strRange = [userInfo objectForKey:@"range"];
            NSRange range = NSRangeFromString(strRange);
            NSString *userId = [userInfo objectForKey:@"userid"];
            [messageLabel addCustomLink:[NSURL URLWithString:userId] inRange:range];
            
            if (index > 0)
            {
                [messageLabel addCustomLink:[NSURL URLWithString:userId] inRange:range color:[CommonFuction colorFromHexRGB:@"f792a0"]];
            }
            else
            {
                [messageLabel addCustomLink:[NSURL URLWithString:userId] inRange:range];
            }
        }
    }
    
    CGFloat headWidth = HeadImageWidth;
    if (isEnter)
    {
        headWidth = 0;
    }
    
    messageLabel.delegate = self;
    CGRect labelRect = messageLabel.frame;
    
    labelRect.size = [messageLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH - 120-21, CGFLOAT_MAX)];
    //    labelRect.size.height = [messageLabel sizeThatFits:CGSizeMake(self.tableView.frame.size.width - headWidth, CGFLOAT_MAX)].height;
    messageLabel.frame = labelRect;
    messageLabel.underlineLinks = NO;//链接是否带下划线
    [messageLabel.layer display];
    return messageLabel;
}

-(UIImage *)imageWithBackGroundColorForUserId:(NSInteger)userId onImage:(UIImage *)image
{
    if (!image)
    {
        return nil;
    }
    UIImage *colorImage;
    NSInteger i = userId % 4;
    switch (i) {
        case 0:
            colorImage = [image rt_tintedImageWithColor:[CommonFuction colorFromHexRGB:@"37ef74"] level:.5f];
            break;
        case 1:
            colorImage = [image rt_tintedImageWithColor:[CommonFuction colorFromHexRGB:@"ff6666"] level:.5f];
            break;
        case 2:
            colorImage = [image rt_tintedImageWithColor:[CommonFuction colorFromHexRGB:@"12a1ff"] level:.5f];
            break;
        case 3:
            colorImage = [image rt_tintedImageWithColor:[CommonFuction colorFromHexRGB:@"f7c250"] level:.5f];
            break;
        default:
            break;
    }
    
    return colorImage;
    
}

#pragma mark - OHAttributedLabelDelegate

- (BOOL)attributedLabel:(OHAttributedLabel *)attributedLabel shouldFollowLink:(NSTextCheckingResult *)linkInfo
{
    NSString *requestString = [linkInfo.URL absoluteString];
    EWPLog(@"%@",requestString);
    NSInteger userId = [requestString intValue];
    UserInfo *userInfo = [[[UserInfoManager shareUserInfoManager] allMemberInfo] objectForKey:[NSNumber numberWithInteger:userId]];
    if (userInfo)
    {
        if (self.popupMenudelegate && [self.popupMenudelegate respondsToSelector:@selector(showPopupMenu:)])
        {
            [self.popupMenudelegate showPopupMenu:userInfo];
        }
    }
    
    return NO;
}

- (UIColor*)attributedLabel:(OHAttributedLabel *)label colorForLink:(NSTextCheckingResult *)linkInfo underlineStyle:(int32_t *)underlineStyle
{
    NSString *linkStr = [linkInfo.URL absoluteString];
    EWPLog(@"%@",linkStr);
    UIColor *linkColor;
    if (label.isEnter)
    {
        linkColor = [CommonFuction colorFromHexRGB:@"f792a0"];
    }
    else
    {
        if (label.isSelf) {
            linkColor = [CommonFuction colorFromHexRGB:@"f792a0"];//名字的颜色
        }else{
            linkColor = [CommonFuction colorFromHexRGB:@"ffd178"];//名字的颜色
        }
        
    }
    return linkColor;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger nCount = 0;
    
    if ([AppInfo shareInstance].bLoginSuccess)
    {
        if ([_messageLableMArray count] > 0)
        {
            nCount = [_messageLableMArray count];
        }
    }
    else
    {
        nCount = 1;
    }
    return nCount;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    static NSString *defaultMessageIdentifier = @"defaultMessageIdentifier";
    
    
    UITableViewCell *theCell = nil;
    if ([AppInfo shareInstance].bLoginSuccess)
    {
        static NSInteger labelBgTag = 101;
        static NSInteger hedImageTag = 100;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            UIImageView *headImgeView = [[UIImageView alloc]init];
            headImgeView.userInteractionEnabled = YES;
            headImgeView.frame = CGRectMake(10, 5, 30, 0);
            headImgeView.tag = 100;
            headImgeView.backgroundColor = [UIColor clearColor];
            headImgeView.contentMode = UIViewContentModeScaleAspectFill;
            headImgeView.clipsToBounds = YES;
            headImgeView.userInteractionEnabled = YES;
            
            
            
            UIImageView *labelBg = [[UIImageView alloc] init];
            labelBg.userInteractionEnabled = YES;
            labelBg.tag = labelBgTag;
            
            [cell.contentView addSubview:headImgeView];
            [cell.contentView addSubview:labelBg];
            
            UILongPressGestureRecognizer *tapGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
            tapGesture.minimumPressDuration = 0.5;
            [headImgeView addGestureRecognizer:tapGesture];
        }
        OHAttributedLabel *label = (OHAttributedLabel *)[cell.contentView viewWithTag:100000];
        if (label)
        {
            [label removeFromSuperview];
        }
        //view内添加上label视图
        label = [self.messageLableMArray objectAtIndex:indexPath.row];
        label.tag = 100000;
        if (label.isEnter)
        {
            label.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
        }
        
        
        else
        {
            label.textColor = [CommonFuction colorFromHexRGB:@"70727f"];//聊天内容颜色
        }
        
        
        [CustomMethod drawImage:label isAlpha:label.isEnter];
        
        //LRprivateChatkuangRight.png 文字距离labelBg左侧为7+7 距离右侧为7
        
        if (label.isSelf) {
            label.frame = CGRectMake(7, VerticalSpace / 2, label.frame.size.width, label.frame.size.height);//label的位置   label在labelBG上放着
        }else{
            label.frame = CGRectMake(14, VerticalSpace / 2, label.frame.size.width, label.frame.size.height);//label的位置   label在labelBG上放着
            
        }
        
        //        label.backgroundColor = [UIColor redColor];
        //        labelBg.backgroundColor = [UIColor orangeColor];
        
        UIImageView *labelBg = [cell.contentView viewWithTag:labelBgTag];
        labelBg.frame = CGRectMake(0, 0, label.frame.size.width + 21,  label.frame.size.height + VerticalSpace);
        [labelBg addSubview:label];
        
        UIImageView *headImgeView = (UIImageView *)[cell.contentView viewWithTag:hedImageTag];
        if (label.isEnter)
        {
            labelBg.backgroundColor = [UIColor clearColor];
            labelBg.frame = CGRectMake( 0, VerticalSpace / 2, labelBg.frame.size.width, labelBg.frame.size.height);
            labelBg.backgroundColor = [UIColor colorWithWhite:0  alpha:0.15];
            headImgeView.hidden = YES;
            
        }
        else
        {
            headImgeView.hidden = NO;
            
            
            
            if (label.isSelf) {
                labelBg.image = [[UIImage imageNamed:@"LRprivateChatkuangRight.png"]stretchableImageWithLeftCapWidth:1 topCapHeight:35];
                labelBg.frame = CGRectMake(SCREEN_WIDTH- 60-labelBg.frame.size.width, VerticalSpace / 2, labelBg.frame.size.width, labelBg.frame.size.height);//labelBG的位置
                headImgeView.frame = CGRectMake( SCREEN_WIDTH- 10-HeadImageWidth, VerticalSpace / 2, HeadImageWidth, HeadImageWidth);//头像
            }else{
                labelBg.image = [[UIImage imageNamed:@"LRprivateChatkuang.png"]stretchableImageWithLeftCapWidth:20 topCapHeight:35];
                labelBg.frame = CGRectMake(60, VerticalSpace / 2, labelBg.frame.size.width, labelBg.frame.size.height);//labelBG的位置
                headImgeView.frame = CGRectMake(10, VerticalSpace / 2, HeadImageWidth, HeadImageWidth);//头像
                
            }
            
            
            headImgeView.layer.cornerRadius = 20;
            NSString *baseString = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,label.info.photo];
            [headImgeView sd_setImageWithURL:[NSURL URLWithString:baseString] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!image) {
                    headImgeView.image =[UIImage imageNamed:@"default_photo.png"];
                }else{
                    
                    headImgeView.image =image;
                };
            }];
        }
        headImgeView.userId = [NSString stringWithFormat:@"%ld", label.info.userId];
        
        theCell = cell;
    }
    else
    {
        UITableViewCell *defaultMessagecell = [tableView dequeueReusableCellWithIdentifier:defaultMessageIdentifier];
        if (defaultMessagecell == nil)
        {
            defaultMessagecell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultMessageIdentifier];
            defaultMessagecell.selectionStyle = UITableViewCellSelectionStyleNone;
            defaultMessagecell.backgroundColor = [UIColor clearColor];
        }
        for (UIView *view in defaultMessagecell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        
        //        [defaultMessagecell.contentView addSubview:_defaultContent];
        
        //        UIImageView *hLineImgeView = [[UIImageView alloc] init];
        //        hLineImgeView.frame = CGRectMake(0,39.5, self.frame.size.width, 0.5);
        //        hLineImgeView.tag = 22;
        //        hLineImgeView.backgroundColor = [CommonFuction colorFromHexRGB:@"dfdfdf"];
        //        [defaultMessagecell.contentView addSubview:hLineImgeView];
        theCell = defaultMessagecell;
        
    }
    return theCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 40;
    if (self.messageLableMArray.count > 0)
    {
        OHAttributedLabel *label = [self.messageLableMArray objectAtIndex:indexPath.row];
        //          NSLogRect(label.frame);
        if (label)
        {
            height = label.frame.size.height;
            if (label.frameHeight<=20) {
                height = 25;
            }
            height += VerticalSpace * 2;
            
            
            
            
        }
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)onTap:(UIGestureRecognizer *)recognizer
{
    UIView *view = recognizer.view;
    CGPoint pt = [recognizer locationInView:view];
    
    CGPoint windowPoint = [view convertPoint:pt toView:[UIApplication sharedApplication].keyWindow];
    [[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGPoint(windowPoint) forKey:@"popupPoint"];
    NSInteger userId = [view.userId integerValue];
    
    UserInfo *userInfo = [[[UserInfoManager shareUserInfoManager] allMemberInfo] objectForKey:[NSNumber numberWithInteger:userId]];
    
    NSLog(@"%@",[[UserInfoManager shareUserInfoManager] allMemberInfo] );
    if (userInfo)
    {
        
        self.targetUserInfo =userInfo;
        //        if (self.popupMenudelegate && [self.popupMenudelegate respondsToSelector:@selector(showPopupMenu:)])
        //        {
        //            [self.popupMenudelegate showPopupMenu:userInfo];
        //        }
    }
    
}

#pragma mark - layout
- (void)layoutSubviews
{
    //    self.tableView.frame = CGRectMake(10, 9, self.frame.size.width - 10, self.frame.size.height - 10-9);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ShowBarAndChat object:nil];
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
