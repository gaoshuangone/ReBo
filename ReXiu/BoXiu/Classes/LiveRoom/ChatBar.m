//
//  ChatBar.m
//  BoXiu
//
//  Created by andy on 15/6/13.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "ChatBar.h"

@interface ChatBar ()<UITextFieldDelegate>

@property (nonatomic,strong) UIView *bkView;
@property (nonatomic,strong) UITextField *messageCotent;

//主要用于第三方输入法多次调用键盘显示消息
@property (nonatomic,assign) NSInteger animationCount;
@property (nonatomic,assign) NSInteger animationFinishCount;

@end
@implementation ChatBar

- (void)dealloc
{
    [self removeAllObserver];
}

- (void)initView:(CGRect)frame
{
    [self addAllObserver];
    
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.5;
    

    _messageCotent = [[UITextField alloc] initWithFrame:CGRectMake(50 , 20, 200, 27)];
    _messageCotent.font = [UIFont systemFontOfSize:14.0f];
    _messageCotent.textColor = [CommonFuction colorFromHexRGB:@"9a9a9c"];
    _messageCotent.delegate = self;
    _messageCotent.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _messageCotent.clearButtonMode = UITextFieldViewModeWhileEditing;
    _messageCotent.layer.borderWidth = 0.5;
    _messageCotent.layer.borderColor = [CommonFuction colorFromHexRGB:@"575757"].CGColor;
    _messageCotent.layer.masksToBounds = YES;
    _messageCotent.layer.cornerRadius = 13.5;
    _messageCotent.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _messageCotent.leftViewMode = UITextFieldViewModeAlways;
    _messageCotent.returnKeyType = UIReturnKeySend;
    [self addSubview:_messageCotent];
}

- (void)addAllObserver
{
    //通过kvo监测当前view的hide属性值，而设置键盘的隐藏和现实
    [self addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:nil];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(keyboardWillChangeFrame:)
                               name:UIKeyboardWillChangeFrameNotification
                             object:nil];

}

- (void)removeAllObserver
{
    [self removeObserver:self forKeyPath:@"hidden" context:nil];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];

    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
    if (yOffset != 0)
    {
       [self moveInputBarWithKeyboardHeight:yOffset withDuration:animationDuration];
    }
}


- (void)moveInputBarWithKeyboardHeight:(float)keyboardHeight withDuration:(NSTimeInterval)animationDuration
{
    
    [UIView animateWithDuration:animationDuration delay:animationDuration options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _animationCount++;
        CGRect frame = self.frame;
        frame.origin.y = frame.origin.y + keyboardHeight;
        self.frame = frame;
    } completion:^(BOOL finished) {
        if (finished)
        {
            _animationFinishCount++;
            if (_animationCount == _animationFinishCount)
            {
                _animationCount = 0;
                _animationFinishCount = 0;
                if (self.hidden)
                {
                    if (_bkView)
                    {
                        [_bkView removeFromSuperview];
                        _bkView = nil;
                    }
                }
                else
                {
                    if (_bkView == nil)
                    {
                        _bkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height - self.frame.origin.y)];
                        _bkView.alpha = 1;
                        [_bkView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClickBKControl:)]];
                        [self.superview addSubview:_bkView];
                    }
                    else
                    {
                        if (self.delegate && [self.delegate respondsToSelector:@selector(tapOutViewOfChatBar:)])
                        {
                            [self.delegate tapOutViewOfChatBar:self];
                        }
                    }
                }

            }
        }
    }];
}

- (void)OnClickBKControl:(UITapGestureRecognizer *)gestureRecognizer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapOutViewOfChatBar:)])
    {
        [self.delegate tapOutViewOfChatBar:self];
    }
}


- (void)showKeyBoard
{
    if (_messageCotent)
    {
        [_messageCotent becomeFirstResponder];
    }
}

- (void)hideKeyBoard
{
    if (_messageCotent)
    {
        [_messageCotent resignFirstResponder];
        
    }
    
}

- (void)setText:(NSString *)text
{
    _messageCotent.text = text;
}

- (NSString *)text
{
    return _messageCotent.text;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(chatTbarSendAction:)])
    {
        [self.delegate chatTbarSendAction:self];
    }
    return NO;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"hidden"])
    {
        BOOL hidden = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        if (hidden)
        {
            [self hideKeyBoard];
        }
        else
        {
            [self showKeyBoard];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
