//
//  EWPActionSheet.m
//  MemberMarket
//
//  Created by andy on 13-11-18.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import "EWPActionSheet.h"
//#import "AppDelegate.h"

@implementation EWPActionSheet

- (id)initWithTitle:(NSString *)title buttonTitles:(NSArray *)buttonTitles actionSheetBlock:(ActionSheetBlock)actionSheetBlock
{
    self = [super initWithFrame:CGRectMake(0, 50, 320, 100)];
    if (self)
    {
        self.delegate = self;
        [self setTitle:title];
        for (int nIndex = 0; nIndex < buttonTitles.count; nIndex++)
        {
            [self addButtonWithTitle:[buttonTitles objectAtIndex:nIndex]];
        }
        if (actionSheetBlock)
        {
            _actionSheetBlock = [actionSheetBlock copy];
        }
    }
    return  self;
}

- (void)setActionSheetBlock:(ActionSheetBlock)actionSheetBlock
{
    if (actionSheetBlock)
    {
        _actionSheetBlock = nil;
        _actionSheetBlock = [actionSheetBlock copy];
    }
}

- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self showInView:keyWindow];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_actionSheetBlock)
    {
        _actionSheetBlock(buttonIndex);
        [self dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
}

@end
