//
//  EWPTextField.m
//  MemberMarket
//
//  Created by andy on 13-11-14.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import "EWPTextField.h"
#import "EWPAlertView.h"

#define TEXTFIELD_LIMIT_WARNING @"输入字数不能超过%d个字符"

@implementation EWPTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _textField.delegate = self;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.layer.cornerRadius = 5.0f;
        _textField.layer.borderWidth = 1.0f;
        _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"PersonalCenterBg"]];
        [self addSubview:_textField];

        self.limitCharacterCount = 50;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)layoutSubviews
{
    _textField.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _textField.placeholder = placeholder;
}

- (NSString *)text
{
    self.text = _textField.text;
    return _text;
}

#pragma mark - UITextFiledDelegate

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text = @"";
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!textField.window.isKeyWindow)
    {
        [textField.window makeKeyAndVisible];
    }

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.length > 0)
    {
        if ([string length] > 0) {
            if (([textField.text length] - range.length + [string length]) > _limitCharacterCount) {
                [self showLimitWaring];
                return NO;
            }
        }
        else
        {
            if (([textField.text length] - range.length) > _limitCharacterCount) {
                [self showLimitWaring];
                return NO;
            }
            
        }
        return YES;
    }
    if ([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        return NO;
    }
    else if(range.location >= 140)
    {
        [self showLimitWaring];
        return NO;
    }
    if ([textField.text length] + [string length]> 0) {
        if (([textField.text length] + [string length]) > _limitCharacterCount) {
            [self showLimitWaring];
            return NO;
        }
    }
    return YES;

}

- (void)showLimitWaring
{
    NSString *message = [NSString stringWithFormat:TEXTFIELD_LIMIT_WARNING,_limitCharacterCount];
    EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"提示" message:message confirmBlock:nil cancelBlock:nil];
    [alertView show];
    
}
@end
