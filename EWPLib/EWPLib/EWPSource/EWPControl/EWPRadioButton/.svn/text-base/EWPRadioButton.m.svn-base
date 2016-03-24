//
//  EIRadioButton.m
//  EInsure
//
//  Created by ivan on 13-7-9.
//  Copyright (c) 2013年 ivan. All rights reserved.
//

#import "EWPRadioButton.h"

#define EWP_RADIO_ICON_WH                     (16.0)
#define EWP_ICON_TITLE_MARGIN                 (5.0)


static NSMutableDictionary *_groupRadioDic = nil;

@implementation EWPRadioButton

- (id)initWithDelegate:(id)delegate groupId:(NSString*)groupId
{

    self = [super init];
    if (self)
    {
        _bReadOnly = FALSE;
        _delegate = delegate;
        _iconWH = EWP_RADIO_ICON_WH;
        
        _groupId = [groupId copy];
        
        [self addToGroup];
        

        
//        self.exclusiveTouch = YES;
//        self = [UIButton buttonWithType:UIButtonTypeCustom];
        [self setImage:[UIImage imageNamed:@"radio_unchecked.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"radio_checked.png"] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(radioBtnChecked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)addToGroup
{
    if(!_groupRadioDic)
    {
        _groupRadioDic = [NSMutableDictionary dictionary];
    }
    
    NSMutableArray *_gRadios = [_groupRadioDic objectForKey:_groupId];
    if (!_gRadios)
    {
        _gRadios = [NSMutableArray array];
    }
    [_gRadios addObject:self];
    [_groupRadioDic setObject:_gRadios forKey:_groupId];
}

- (void)removeFromGroup
{
    if (_groupRadioDic)
    {
        NSMutableArray *_gRadios = [_groupRadioDic objectForKey:_groupId];
        if (_gRadios)
        {
            [_gRadios removeObject:self];
            if (_gRadios.count == 0)
            {
                [_groupRadioDic removeObjectForKey:_groupId];
            }
        }
    }
}

- (void)uncheckOtherRadios
{
    NSMutableArray *_gRadios = [_groupRadioDic objectForKey:_groupId];
    if (_gRadios.count > 0)
    {
        for (EWPRadioButton *_radio in _gRadios)
        {
            if (_radio.checked && ![_radio isEqual:self])
            {
                _radio.checked = NO;
            }
        }
    }
}

- (void)setChecked:(BOOL)checked
{
    if (_checked == checked)
    {
        return;
    }
    
    _checked = checked;
    self.selected = checked;
    
    if (self.selected)
    {
        [self uncheckOtherRadios];
    }
    
    if (self.selected && _delegate && [_delegate respondsToSelector:@selector(didSelectedRadioButton:groupId:)])
    {
        [_delegate didSelectedRadioButton:self groupId:_groupId];
        
    }
}

- (void)radioBtnChecked
{
    BOOL canEdit = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ewpRadioButtonShouldCanEditing:)])
    {
        canEdit = [self.delegate ewpRadioButtonShouldCanEditing:self];
    }
    if (!canEdit)
    {
        return;
    }
    
    if (self.bReadOnly)
    {
        return;
    }
    if (_checked)
    {
        return;
    }
    
    self.selected = !self.selected;
    _checked = self.selected;
    
    if (self.selected)
    {
        [self uncheckOtherRadios];
    }
    
    if (self.selected && _delegate && [_delegate respondsToSelector:@selector(didSelectedRadioButton:groupId:)])
    {
        [_delegate didSelectedRadioButton:self groupId:_groupId];
        
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, (CGRectGetHeight(contentRect) - _iconWH)/2.0, _iconWH, _iconWH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(_iconWH + EWP_ICON_TITLE_MARGIN, 0,
                      CGRectGetWidth(contentRect) - _iconWH - _iconWH,
                      CGRectGetHeight(contentRect));
}

- (void)dealloc
{
    [self removeFromGroup];
    
}


@end
