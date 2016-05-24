//
//  PrivateMessageView.m
//  BoXiu
//
//  Created by andy on 15/6/17.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "PrivateMessageView.h"
#import "UnderLineLabel.h"
#import "UserInfoManager.h"
#import "EmotionManager.h"
#import "UIImage+RTTint.h"
#import "UIView+Tools.h"

#define HeadImageWidth         36.0f
#define LabelMarginWidth       10.0f
#define VerticalSpace          7.0f

@interface PrivateMessageView ()

@property (nonatomic,strong) NSMutableArray *messageMArray;
@property (nonatomic,strong) NSMutableArray *messageLableMArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *defaultContent;
@property (nonatomic,strong) NSLock  *lock;
@end

@implementation PrivateMessageView

- (void)viewWillAppear
{
    [super viewWillAppear];
    
}

- (void)viewwillDisappear
{
    [super viewwillDisappear];
}

- (void)initView:(CGRect)frame
{
    
    _lock = [[NSLock alloc] init];
    
    _messageMArray = [[NSMutableArray alloc] initWithCapacity:0];
    _messageLableMArray = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:_tableView];
    
}

- (void)addDefaultMessage
{
    if (![AppInfo shareInstance].bLoginSuccess)
    {
        _defaultContent = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 20)];
        UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 150, 20)];
        message.text = @"Star私聊你了,请";
        message.font = [UIFont systemFontOfSize:13.0f];
        message.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
        [_defaultContent addSubview:message];
        
        UnderLineLabel *toLoginLable = [[UnderLineLabel alloc] initWithFrame:CGRectMake(103, 0, 80, 20)];
        toLoginLable.text = @"点击查看";
        toLoginLable.font = [UIFont systemFontOfSize:13.0f];
        [toLoginLable setTextColor:[CommonFuction colorFromHexRGB:@"f7c250"]];
        [toLoginLable setBackgroundColor:[UIColor clearColor]];
        toLoginLable.shouldUnderline = YES;
        toLoginLable.userInteractionEnabled = YES;
        [toLoginLable addTarget:self action:@selector(toLogin)];
        
        [_defaultContent addSubview:toLoginLable];
        [self.tableView reloadData];
    }
}

- (void)toLogin
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(toLogin)])
    {
        [self.delegate toLogin];
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
        headString = [NSString stringWithFormat:@"{%ld}\n{%ld} ",(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
    }
    NSString *chatMessage = [NSString stringWithFormat:@"%@%@",headString,chatMessageModel.msg];
    [self creatLabelWithChatMessage:chatMessage userInfo:info isEnter:NO];
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
//    [_lock unlock];
    
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
            nick = [NSString stringWithFormat:@"@%@",nick];
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
    if (isEnter)
    {
        fontSize = 12;
    }
    [attString setFont:[UIFont systemFontOfSize:fontSize]];
    [messageLabel setBackgroundColor:[UIColor clearColor]];
    
    //设置行间距
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:1];
    [attString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attString length])];
    
    if (!isEnter && [outParam count])
    {
        NSDictionary *userInfo = [outParam firstObject];
        NSString *strRange = [userInfo objectForKey:@"range"];
        NSRange range = NSRangeFromString(strRange);
        [attString setFont:[UIFont systemFontOfSize:12] range:range];
    }

    
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
                [messageLabel addCustomLink:[NSURL URLWithString:userId] inRange:range color:[CommonFuction colorFromHexRGB:@"f7c250"]];
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
    labelRect.size = [messageLabel sizeThatFits:CGSizeMake(self.tableView.frame.size.width - headWidth - LabelMarginWidth, CGFLOAT_MAX)];
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
        linkColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    }
    else
    {
        //        linkColor = [CommonFuction colorFromHexRGB:@"00c1b9"];
        linkColor = [CommonFuction colorFromHexRGB:@"a4a4a4"];
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
            headImgeView.frame = CGRectMake(0, 5, 30, 0);
            headImgeView.tag = 100;
            headImgeView.backgroundColor = [UIColor clearColor];
            headImgeView.contentMode = UIViewContentModeScaleAspectFill;
            headImgeView.clipsToBounds = YES;
            headImgeView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
            [headImgeView addGestureRecognizer:tapGesture];
            
            UIView *labelBg = [[UIView alloc] init];
            labelBg.tag = labelBgTag;
            
            [cell.contentView addSubview:headImgeView];
            [cell.contentView addSubview:labelBg];
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
            label.textColor = [CommonFuction colorFromHexRGB:@"424242"];
        }
        

        [CustomMethod drawImage:label isAlpha:label.isEnter];
        
        label.frame = CGRectMake(LabelMarginWidth / 2, VerticalSpace / 2, label.frame.size.width, label.frame.size.height);
        UIView *labelBg = [cell.contentView viewWithTag:labelBgTag];
        labelBg.frame = CGRectMake(0, 0, label.frame.size.width + LabelMarginWidth,  label.frame.size.height + VerticalSpace);
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
            labelBg.backgroundColor = [UIColor whiteColor];
            labelBg.frame = CGRectMake(HeadImageWidth, VerticalSpace / 2, labelBg.frame.size.width, labelBg.frame.size.height);
            headImgeView.frame = CGRectMake(0, VerticalSpace / 2, HeadImageWidth, label.frame.size.height+ VerticalSpace);
            NSString *baseString = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,label.info.photo];
            [headImgeView sd_setImageWithURL:[NSURL URLWithString:baseString] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!image) {
                    headImgeView.image = [self imageWithBackGroundColorForUserId:label.info.userId onImage:[UIImage imageNamed:@"default_photo.png"]];
                }else{
                    headImgeView.image = [self imageWithBackGroundColorForUserId:label.info.userId onImage:image];
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
        
        [defaultMessagecell.contentView addSubview:_defaultContent];
        
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
        if (label)
        {
            height = label.frame.size.height;
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
    if (userInfo)
    {
        if (self.popupMenudelegate && [self.popupMenudelegate respondsToSelector:@selector(showPopupMenu:)])
        {
            [self.popupMenudelegate showPopupMenu:userInfo];
        }
    }
    
}

#pragma mark - layout
- (void)layoutSubviews
{
    self.tableView.frame = CGRectMake(10, 9, self.frame.size.width - 10, self.frame.size.height - 10-9);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ShowBarAndChat object:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
