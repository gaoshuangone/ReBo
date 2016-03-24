//
//  PrivateView.m
//  BoXiu
//
//  Created by Andy on 14-3-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "PrivateView.h"
#import "ChatRoomViewController.h"
#import "CustomMethod.h"
#import "UserInfo.h"
#import "ChatMessageModel.h"
#import "ExpressionManager.h"
#import "UserInfoManager.h"
#import "RightMenuCell.h"
#import "UnderLineLabel.h"
#import "EmotionManager.h"

@interface PrivateView ()

@property (nonatomic,strong) NSMutableArray *messageMArray;
@property (nonatomic,strong) NSMutableArray *messageLableMArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *defaultContent;


@end

@implementation PrivateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

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
        message.font = [UIFont systemFontOfSize:14.0f];
        message.textColor = [CommonFuction colorFromHexRGB:@"d14c49"];
        [_defaultContent addSubview:message];
        
        UnderLineLabel *toLoginLable = [[UnderLineLabel alloc] initWithFrame:CGRectMake(110, 0, 80, 20)];
        toLoginLable.text = @"点击查看";
        toLoginLable.font = [UIFont systemFontOfSize:14.0f];
        [toLoginLable setTextColor:[CommonFuction colorFromHexRGB:@"ff6666"]];
        [toLoginLable setBackgroundColor:[UIColor clearColor]];
        toLoginLable.shouldUnderline = YES;
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
    if (_messageMArray == nil)
    {
        _messageMArray = [NSMutableArray array];
    }
    NSString *headString = nil;
    headString = [NSString stringWithFormat:@"{%ld}对{%ld}说: ",(long)chatMessageModel.userid,(long)chatMessageModel.targetUserid];
    
    NSString *chatMessage = [NSString stringWithFormat:@"%@%@",headString,chatMessageModel.msg];
    [self creatLabelWithChatMessage:chatMessage];
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

- (void)creatLabelWithChatMessage:(NSString *)chatMessage
{
    [self.messageMArray addObject:[CustomMethod escapedString:chatMessage]];
    
    OHAttributedLabel *messageLabel = [self createMessageLabelWithMessage:chatMessage];
    
    [self addMessageLabel:messageLabel];
    [CustomMethod drawImage:messageLabel];
    
    [self.tableView reloadData];
    if ([self IsScrollToBottom])
    {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.messageMArray count] - 1 inSection:0]
                              atScrollPosition: UITableViewScrollPositionBottom
                                      animated:YES];
        
    }
}

- (OHAttributedLabel *)createMessageLabelWithMessage:(NSString *)message
{
    OHAttributedLabel *messageLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.linkColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    messageLabel.font = [UIFont systemFontOfSize:14.0f];
    [messageLabel setNeedsDisplay];
    
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
                NSRange emotionRange = [text rangeOfString:flagEmotion];
                NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,emotionData.mlink];
                NSString *imageHtml = [NSString stringWithFormat:@"<img src='%@' width='%.1f' height='%.1f'>",url,emotionData.width,emotionData.height];
                text = [text stringByReplacingCharactersInRange:NSMakeRange(emotionRange.location, [flagEmotion length]) withString:imageHtml];
            }
        }
    }
    
    //处理其他图片，可以根据需求之地鞥大小
    text = [CustomMethod transformStringToWebImage:text imgSize:CGSizeZero];
    text = [NSString stringWithFormat:@"<font color='#7a7a7a' strokeColor='#7a7a7a' face='Palatino-Roman'>%@",text];
    
    MarkupParser *wk_markupParser = [[MarkupParser alloc] init];
    NSMutableAttributedString* attString = [wk_markupParser attrStringFromMarkup: text];
    [attString setFont:[UIFont systemFontOfSize:14]];
    [messageLabel setBackgroundColor:[UIColor clearColor]];
    
    //设置行间距
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attString length])];
    
    [messageLabel setAttString:attString withImages:wk_markupParser.images];
    
    //增加链接
    if ([outParam count])
    {
        for (NSDictionary *userInfo in outParam)
        {
            NSString *strRange = [userInfo objectForKey:@"range"];
            NSRange range = NSRangeFromString(strRange);
            NSString *userId = [userInfo objectForKey:@"userid"];
            [messageLabel addCustomLink:[NSURL URLWithString:userId] inRange:range];
        }
    }
    
    messageLabel.delegate = self;
    CGRect labelRect = messageLabel.frame;
    labelRect.size.width = [messageLabel sizeThatFits:CGSizeMake(self.tableView.frame.size.width, CGFLOAT_MAX)].width;
    labelRect.size.height = [messageLabel sizeThatFits:CGSizeMake(self.tableView.frame.size.width, CGFLOAT_MAX)].height;
    messageLabel.frame = labelRect;
    messageLabel.underlineLinks = NO;//链接是否带下划线
    [messageLabel.layer display];
    return messageLabel;
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
   
    
    UITableViewCell *cell = nil;
    if ([AppInfo shareInstance].bLoginSuccess)
    {
         UITableViewCell *messageCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (messageCell == nil)
        {
            messageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            messageCell.selectionStyle = UITableViewCellSelectionStyleNone;
            messageCell.backgroundColor = [UIColor clearColor];
        }
        for (UIView *view in messageCell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        //view内添加上label视图
        OHAttributedLabel *label = [self.messageLableMArray objectAtIndex:indexPath.row];
        [label setCenter:cell.contentView.center];
        label.textColor = [CommonFuction colorFromHexRGB:@"7a7a7a"];
        label.frame = CGRectMake(0, 5, label.frame.size.width, label.frame.size.height);
        [messageCell.contentView addSubview:label];
        
        UILabel *hLineImgeView = [[UILabel alloc] init];
        hLineImgeView.frame = CGRectMake(0, label.frame.size.height + 9.5, self.frame.size.width, 0.5);
        hLineImgeView.tag = 22;
        hLineImgeView.backgroundColor = [CommonFuction colorFromHexRGB:@"dfdfdf"];
        [messageCell.contentView addSubview:hLineImgeView];
        
        cell = messageCell;
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
        
        UIImageView *hLineImgeView = [[UIImageView alloc] init];
        hLineImgeView.frame = CGRectMake(0,39.5, self.frame.size.width, 0.5);
        hLineImgeView.tag = 22;
        hLineImgeView.backgroundColor = [CommonFuction colorFromHexRGB:@"dfdfdf"];
        [defaultMessagecell.contentView addSubview:hLineImgeView];
        cell = defaultMessagecell;
        
    }
    return cell;
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
            height += 10;
        }
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - layout
- (void)layoutSubviews
{
    self.tableView.frame = CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 10);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
