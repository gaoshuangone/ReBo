//
//  EWPScrollNotice.m
//  BoXiu
//
//  Created by andy on 14-5-14.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "EWPScrollNotice.h"
#import "NSAttributedString+Attributes.h"
#import "MarkupParser.h"
#import "OHAttributedLabel.h"
#import "CustomMethod.h"
#import "UserInfoManager.h"
#import "ExpressionManager.h"

#define SCROLL_CIRCLE_COUNT (1)

@interface EWPScrollNotice ()

@property (nonatomic,strong) NSMutableArray *messageList;
@property (nonatomic,strong) UIView *parentView;
@property (nonatomic,assign) BOOL showing;
@end

@implementation EWPScrollNotice

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame message:(NSString *)message inParrentView:(UIView *)parentView
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.scrollCircleCount = SCROLL_CIRCLE_COUNT;
        self.linkColor =  [CommonFuction colorFromHexRGB:@"e75c9d"];
        [self addMessage:message];
        
        self.parentView = parentView;
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.8;
    }
    return self;
}

- (void)addMessage:(NSString *)message
{
    if (message == nil)
    {
        return;
    }
    if (_messageList == nil)
    {
        _messageList = [NSMutableArray array];
    }
    
    OHAttributedLabel *messagelable = (OHAttributedLabel *)[self creatLabelWithMessage:message];
    
    [self.messageList addObject:messagelable];
}

- (OHAttributedLabel *)creatLabelWithMessage:(NSString *)message
{
    CGSize messageSize = [CommonFuction sizeOfString:message maxWidth:1000.0f maxHeight:1000.0f withFontSize:15.0f];
    OHAttributedLabel *label = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
    label.linkColor = self.linkColor;
    [self creatAttributedLabel:message Label:label];
    label.frame = CGRectMake(0, 0, messageSize.width, self.frame.size.height);
    [CustomMethod drawImage:label];
    return label;
}

- (void)creatAttributedLabel:(NSString *)o_text Label:(OHAttributedLabel *)label
{
    [label setNeedsDisplay];
    NSMutableArray *outParam = [NSMutableArray array];
    
    NSMutableDictionary *userIdAndNickDic = [NSMutableDictionary dictionary];
    for (NSNumber *userId in [[[UserInfoManager shareUserInfoManager] allMemberInfo] allKeys])
    {
        UserInfo *userInfo = [[[UserInfoManager shareUserInfoManager] allMemberInfo] objectForKey:userId];
        [userIdAndNickDic setObject:userInfo.nick forKey:[NSNumber numberWithInteger:userInfo.userId]];
    }
    
    NSString *text  = [CustomMethod replaceUserIdWithUserName:o_text chatMemberDic:userIdAndNickDic outParam:outParam];
    text = [CustomMethod transformString:text emojiDic:[[ExpressionManager shareInstance] expressionDictionary]];
    text = [CustomMethod transformStringToWebImage:text];
    text = [NSString stringWithFormat:@"<font color='white' strokeColor='gray' face='Palatino-Roman'>%@",text];
    
    MarkupParser *wk_markupParser = [[MarkupParser alloc] init];
    NSMutableAttributedString* attString = [wk_markupParser attrStringFromMarkup: text];
    [attString setFont:[UIFont systemFontOfSize:16]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setAttString:attString withImages:wk_markupParser.images];
    
    if ([outParam count])
    {
        for (NSDictionary *userInfo in outParam)
        {
            NSString *strRange = [userInfo objectForKey:@"range"];
            NSRange range = NSRangeFromString(strRange);
            
            NSString *userId = [userInfo objectForKey:@"userid"];
            userId  = [userId substringWithRange:NSMakeRange(1, userId.length - 2)];
            
            [label addCustomLink:[NSURL URLWithString:userId] inRange:range];
        }
    }
    
    //暂时不让点击linktext
//    label.delegate = self;
    CGRect labelRect = label.frame;
    labelRect.size.width = [label sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)].width;
    labelRect.size.height = [label sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)].height;
    label.frame = labelRect;
    label.underlineLinks = NO;//链接是否带下划线
    [label.layer display];
}



- (void)start
{
    if (self.showing == NO)
    {
        self.showing = YES;
        [self scrollNextMessage];
    }
    
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    if ([self.messageList count] > 0)
    {
        [self scrollNextMessage];
    }
    else
    {
        self.showing = NO;
        [self removeFromSuperview];
    }
}

- (void)scrollNextMessage
{
    OHAttributedLabel *messageLable = [self getMessageFromList];
    if (messageLable)
    {
        [self addSubview:messageLable];
        [self.parentView addSubview:self];
        [messageLable sizeToFit];
        CGRect frame = messageLable.frame;
        frame.origin.x = 320;
        messageLable.frame = frame;
        
        [UIView beginAnimations:@"Animation" context:NULL];
        [UIView setAnimationDuration:8.8f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView setAnimationRepeatCount:self.scrollCircleCount];
        
        frame = messageLable.frame;
        frame.origin.x = -frame.size.width;
        messageLable.frame = frame;
        [UIView commitAnimations];
    }

}

- (void)stop
{
     [self removeFromSuperview];
}

- (OHAttributedLabel *)getMessageFromList
{
    if (self.messageList && [self.messageList count] > 0)
    {
        OHAttributedLabel *messageLable = (OHAttributedLabel *)[self.messageList objectAtIndex:0];
        [self.messageList removeObjectAtIndex:0];
        return messageLable;
    }
    return nil;
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
