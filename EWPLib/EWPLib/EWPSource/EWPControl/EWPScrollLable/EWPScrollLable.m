//
//  EWPScrollLable.m
//  BoXiu
//
//  Created by andy on 14-7-2.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "EWPScrollLable.h"
#import "CommonFuction.h"

@interface EWPScrollLable ()
@property (nonatomic,strong) UILabel *lable;
@end

@implementation EWPScrollLable

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _lable.font = [UIFont systemFontOfSize:13.0f];
        _lable.textAlignment = NSTextAlignmentLeft;
        _lable.textColor = [UIColor whiteColor];
        [self addSubview:_lable];
        
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _lable.textColor = textColor;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    _lable.font = font;
}

- (void)setText:(NSString *)text
{
    _text = text;
    _lable.text = text;
     [_lable sizeToFit];
    [_lable setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    float width  = self.frame.size.width;
    
    CGSize size = [CommonFuction sizeOfString:_text maxWidth:1000 maxHeight:20 withFontSize:13];
    
    if (width >= size.width)
    {
        return;
    }
    
    CGRect frame = self.lable.frame;
    frame.origin.x = width;
    self.lable.frame = frame;
    
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:10];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount: LONG_MAX];
    
    frame = self.lable.frame;
    frame.origin.x = -frame.size.width ;
    self.lable.frame = frame;
    [UIView commitAnimations];
}


@end
