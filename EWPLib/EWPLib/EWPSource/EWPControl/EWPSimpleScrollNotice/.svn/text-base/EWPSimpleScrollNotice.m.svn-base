//
//  EWPSimpleScrollNotice.m
//  BoXiu
//
//  Created by andy on 14-7-2.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "EWPSimpleScrollNotice.h"


#define SCROLL_CIRCLE_COUNT (1)

@interface EWPSimpleScrollNotice ()

@property (nonatomic,strong) NSMutableArray *messageList;
@property (nonatomic,strong) UIView *parentView;
@property (nonatomic,assign) BOOL showing;

@end


@implementation EWPSimpleScrollNotice

- (id)initWithFrame:(CGRect)frame message:(NSString *)message inParrentView:(UIView *)parentView
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.scrollCircleCount = SCROLL_CIRCLE_COUNT;
        self.textColor = [UIColor blackColor];
        self.textFont = [UIFont systemFontOfSize:15.0f];
        [self addMessage:message];
        
        self.parentView = parentView;
        self.backgroundColor = [UIColor clearColor];
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
    
    UILabel *messagelable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    messagelable.clipsToBounds = YES;
    messagelable.textColor = self.textColor;
    messagelable.font = self.textFont;
    messagelable.text = message;;
    [self.messageList addObject:messagelable];
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
        [self removeFromSuperview];
    }
}

- (void)scrollNextMessage
{
    UILabel *messageLable = [self getMessageFromList];
    if (messageLable)
    {
        [self addSubview:messageLable];
        [self.parentView addSubview:self];
        [messageLable sizeToFit];
        CGRect frame = messageLable.frame;
        frame.origin.x = frame.origin.x + frame.size.width;
        messageLable.frame = frame;
        
        [UIView beginAnimations:@"Animation" context:NULL];
        [UIView setAnimationDuration:8.8f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView setAnimationRepeatCount:self.scrollCircleCount];
        
        frame = messageLable.frame;
        frame.origin.x = -self.frame.size.width;
        messageLable.frame = frame;
        [UIView commitAnimations];
    }
    
}

- (void)stop
{
    [self removeFromSuperview];
}

- (UILabel *)getMessageFromList
{
    if (self.messageList && [self.messageList count] > 0)
    {
        UILabel *messageLable = [self.messageList objectAtIndex:0];
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
