//
//  EWPCheckBox.m
//
//
//  Created by andy on 13-7-9.
//  Copyright (c) 2013年 ivan. All rights reserved.
//

#import "EWPCheckBox.h"

#define CHECKBOX_ICON_WH                    (20.0)
#define ChECKBOX_ICON_TITLE_MARGIN                (5.0)

@implementation EWPCheckBox

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
        _iconWH = CHECKBOX_ICON_WH;
        self.exclusiveTouch = YES;
        [self setImage:[UIImage imageNamed:@"radio_unchecked.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"radio_checked.png"] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(checkboxBtnChecked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setChecked:(BOOL)checked
{
    if (_checked == checked)
    {
        return;
    }
    
    _checked = checked;
    self.selected = checked;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)])
    {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

- (void)checkboxBtnChecked
{
    BOOL canEdit = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ewpCheckBoxShouldCanEditing:)])
    {
        canEdit = [self.delegate ewpCheckBoxShouldCanEditing:self];
    }
    if (!canEdit)
    {
        return;
    }
    
    self.selected = !self.selected;
    _checked = self.selected;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)])
    {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, (CGRectGetHeight(contentRect) - _iconWH)/2.0, _iconWH, _iconWH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(_iconWH + ChECKBOX_ICON_TITLE_MARGIN, 0,
                      CGRectGetWidth(contentRect) - _iconWH - _iconWH,
                      CGRectGetHeight(contentRect));
}

- (void)dealloc
{
     _delegate = nil;
}

@end
