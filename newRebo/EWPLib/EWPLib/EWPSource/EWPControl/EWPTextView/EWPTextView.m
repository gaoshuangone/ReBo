//
//  EWPTextView.m
//  MemberMarket
//
//  Created by andy on 13-11-14.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import "EWPTextView.h"
#import "EWPAlertView.h"

#define TEXTVIEWE_LIMIT_WARNING @"输入字数不能超过%d个字符"

@interface EWPTextView ()

@property(nonatomic,strong) UILabel *placeHolderLalbel;

@end
@implementation EWPTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        self.limitCharacterCount = 200;
        self.placeHolderColor = [UIColor grayColor];
        self.selectedRange = NSMakeRange(0,0);
        
        [self addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
        
        /*初始化placeHolderLalbel*/
        _placeHolderLalbel = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x + 10, frame.origin.y + 20, frame.size.width - 20, frame.size.height - 40)];
        _placeHolderLalbel.backgroundColor = [UIColor clearColor];
//        _placeHolderLalbel.enabled = NO;
        _placeHolderLalbel.textColor = self.placeHolderColor;
        _placeHolderLalbel.font = self.font;
        _placeHolderLalbel.lineBreakMode = NSLineBreakByWordWrapping;
        _placeHolderLalbel.numberOfLines = 0;
        [self addSubview:_placeHolderLalbel];
        
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    _placeHolderLalbel.text = self.placeHolder;
    [_placeHolderLalbel sizeToFit];
    
    [self sendSubviewToBack:_placeHolderLalbel];
    
    [super drawRect:rect];
}

- (void)layoutSubviews
{
    _placeHolderLalbel.frame = CGRectMake(5,5, self.frame.size.width - 10, 20);
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    _placeHolderLalbel.textColor = placeHolderColor;
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    [_placeHolderLalbel setText:placeHolder];
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (!textView.window.isKeyWindow)
    {
        [textView.window makeKeyAndVisible];
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    [self resignFirstResponder];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{

    if([self.text length] == 0)
    {
        [_placeHolderLalbel setAlpha:1];
    }
    else
    {
        [_placeHolderLalbel setAlpha:0];
    }
    
    if (range.length > 0)
    {
        if ([text length] > 0)
        {
            if (([textView.text length] - range.length + [text length]) > _limitCharacterCount)
            {
                [self showLimitWaring];
                return NO;
            }
        }
        return YES;
    }
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    else if(range.location >= 140)
    {
        [self showLimitWaring];
        return NO;
    }
    if ([textView.text length] + [text length]> 0)
    {
        if (([textView.text length] + [text length]) > _limitCharacterCount)
        {
            [self showLimitWaring];
            return NO;
        }
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if([self.text length] == 0)
    {
        [_placeHolderLalbel setAlpha:1];
    }
    else
    {
        [_placeHolderLalbel setAlpha:0];
    }
}

#pragma mark - KVO监测字体属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self == object)
    {
        UIFont *font = [self valueForKey:keyPath];
        _placeHolderLalbel.font = font;
        [self removeObserver:self forKeyPath:@"font"];
    }
}

/*显示警告*/
- (void)showLimitWaring
{
    NSString *message = [NSString stringWithFormat:TEXTVIEWE_LIMIT_WARNING,_limitCharacterCount];
    EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"提示" message:message confirmBlock:nil cancelBlock:nil];
    [alertView show];
    
}
@end
