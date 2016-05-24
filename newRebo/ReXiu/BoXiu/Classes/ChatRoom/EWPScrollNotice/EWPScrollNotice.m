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

@property (nonatomic,assign) CGFloat normalHeight;

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
        self.normalHeight = frame.size.height;
        _fontSize = 14.0f;
        _textColor = @"ffffff";
        self.layer.masksToBounds = YES;
        self.scrollCircleCount = SCROLL_CIRCLE_COUNT;
        self.linkColor =  [CommonFuction colorFromHexRGB:@"F1E534"];
        [self addMessage:message];
        
        self.parentView = parentView;
        self.backgroundColor = [CommonFuction colorFromHexRGB:@"000000" alpha:0.5];
    }
    return self;
}

- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
}


- (OHAttributedLabel *)addMessage:(NSString *)message
{
    if (message == nil)
    {
        return nil;
    }
    if (_messageList == nil)
    {
        _messageList = [NSMutableArray array];
    }
    
    [self.superview bringSubviewToFront:self];
    
    OHAttributedLabel *messagelable = (OHAttributedLabel *)[self creatLabelWithChatMessage:message];
    
    [self.messageList addObject:messagelable];
    return messagelable;
}

- (OHAttributedLabel *)creatLabelWithChatMessage:(NSString *)chatMessage
{
    OHAttributedLabel *messageLabel = [self createMessageLabelWithMessage:chatMessage];
    [CustomMethod drawImage:messageLabel];
    return messageLabel;
}

- (OHAttributedLabel *)createMessageLabelWithMessage:(NSString *)message
{
    OHAttributedLabel *messageLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
    messageLabel.linkColor = self.linkColor;
    messageLabel.font = [UIFont systemFontOfSize:_fontSize];
    
    
    //处理用户名
    NSMutableArray *outParam = [NSMutableArray array];
    NSString *text = message;
    NSArray *userArray = [CustomMethod addObjectArr:text beginFlage:@"{" endFlag:@"}"];
    if (userArray && [userArray count])
    {
        NSDictionary *chatMemberDic = [[UserInfoManager shareUserInfoManager] allUserIdAndNick];
        for (NSString *flagUserId in userArray)
        {
            
//            NSRange rang = [text rangeOfString:@"'>"];
//            NSString * str1 =[text substringFromIndex:rang.location+2] ;
//            NSString* str2 = [text substringToIndex:rang.location+2];//'>以前的
//            NSRange rang_img = [str1  rangeOfString:@"<img"];
//            NSString* str3 = nil;
//            if (rang_img.location != NSNotFound) {
//                
//                str3 = [str1 substringFromIndex:rang_img.location];//<img以后的，图标
//                
//                str1 = [str1 substringToIndex:rang_img.location];
//            }
//            str1 =[str1 stringByReplacingOccurrencesOfString:@"<" withString:@"&lt"];//'>与<img之间位置也就是昵称,
//            str1 =[str1 stringByReplacingOccurrencesOfString:@">" withString:@"&gt"];//'>与<img之间位置也就是昵称,
//            //     str1 =[str1 stringByReplacingOccurrencesOfString:@"^" withString:@"$!,"];//'>与<img之间位置也就是昵称,
//            if (str3== nil) {//如果有图标
//                text = [NSString stringWithFormat:@"%@%@",str2,str1];
//            }else{
//                text = [NSString stringWithFormat:@"%@%@%@",str2,str1,str3];
//            }

            

            NSString *userId = [[NSString alloc] initWithString:[flagUserId substringWithRange:NSMakeRange(1, [flagUserId length] - 2)]];
            NSString *nick = [chatMemberDic objectForKey:[NSNumber numberWithInteger: [userId integerValue]]];
           nick= [nick stringByReplacingOccurrencesOfString:@"<" withString:@"&lt"];
           nick= [nick stringByReplacingOccurrencesOfString:@">" withString:@"&gt"];
            nick = [NSString stringWithFormat:@"[ %@ ]",nick];
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
    
    //处理其他图片，可以根据需求之地鞥大小
    text = [CustomMethod transformStringToWebImage:text imgSize:CGSizeMake(25, 25)];
//    text = [NSString stringWithFormat:@"<font color='white' strokeColor='white' size='%f' face='宋体'>%@",_fontSize,text];
    text = [NSString stringWithFormat:@"<font color='white' size='%f' face='宋体'>%@",_fontSize,text];
    
    MarkupParser *wk_markupParser = [[MarkupParser alloc] init];
    NSMutableAttributedString* attString = [wk_markupParser attrStringFromMarkup: text];
    [attString setFont:[UIFont systemFontOfSize:14]];
    [messageLabel setBackgroundColor:[UIColor clearColor]];
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
    
    CGRect labelRect = messageLabel.frame;
    labelRect.size.width = [messageLabel sizeThatFits:CGSizeMake(5000.0f, CGFLOAT_MAX)].width;
    labelRect.size.height = [messageLabel sizeThatFits:CGSizeMake(5000.0f, CGFLOAT_MAX)].height;
    labelRect.origin.y = (self.normalHeight - labelRect.size.height)/2;
    messageLabel.frame = labelRect;
    messageLabel.underlineLinks = NO;//链接是否带下划线
    [messageLabel.layer display];
    [messageLabel setNeedsDisplay];
    return messageLabel;
}

- (void)start
{
    if (self.showing == NO)
    {
        self.showing = YES;
        self.hidden = NO;
        CGRect selfFrame = self.frame;
        CGFloat normalHeight = self.normalHeight;
        selfFrame.size.height = 0;
        self.frame = selfFrame;
        selfFrame.size.height = normalHeight;
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = selfFrame;
        } completion:^(BOOL finished) {
            [self scrollNextMessage];
        }];
        
    }
    else
    {
//        [self scrollNextMessage];
    }
    
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    
    
    if ([self.messageList count] > 0)
    {
        [self scrollNextMessage];
        for (UIView *view in self.subviews)
        {
            [view removeFromSuperview];
        }
    }
    else
    {
        [self stop];
    }
}

- (void)scrollNextMessage
{
    OHAttributedLabel *messageLable = [self getMessageFromList];
    if (messageLable)
    {
        self.hidden = NO;
        [self addSubview:messageLable];
        [messageLable sizeToFit];
        __block CGRect frame = messageLable.frame;
        frame.origin.x = 320;
        messageLable.frame = frame;
        
//        [UIView beginAnimations:@"Animation" context:NULL];
//        [UIView setAnimationDuration:8.8f];
//        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//        [UIView setAnimationDelegate:self];
//        [UIView setAnimationRepeatAutoreverses:NO];
//        [UIView setAnimationRepeatCount:self.scrollCircleCount];
        
        [UIView animateWithDuration:8.8f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            frame = messageLable.frame;
            frame.origin.x = -frame.size.width;
            messageLable.frame = frame;
        } completion:^(BOOL finished) {
            [messageLable removeFromSuperview];
            if ([self.messageList count] > 0)
            {
                [self scrollNextMessage];
            }
            else
            {
                [self stop];
            }
        }];
        
        
//        [UIView commitAnimations];
        
    }
    else
    {
        if (self.hidden == NO)
        {
            [self stop];
        }
    }

}

- (void)stop
{
    CGRect selfFrame = self.frame;
//    selfFrame.origin.y = selfFrame.size.height;
    selfFrame.size.height = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = selfFrame;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.showing = NO;
//        [self removeFromSuperview];
    }];
    
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
