//
//  RoomRankMenuBar.m
//  BoXiu
//
//  Created by andy on 15/5/22.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//由于此模块需求菜单固定，直接位置不动态布局

#import "RoomRankMenuBar.h"

@interface RoomRankMenuBar ()

@property (nonatomic,assign) NSInteger currentIndex;

@property (nonatomic,strong) NSMutableArray *buttons;

@end
@implementation RoomRankMenuBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)initView:(CGRect)frame
{
    self.backgroundColor = [CommonFuction colorFromHexRGB:@"292429" alpha:0.92];
    
    _buttons = [NSMutableArray array];
    
    NSArray *menuTitle = @[@"     本场粉丝榜     |",@"     超级粉丝榜     |",@"抢星榜"];
    CGFloat nbuttonWidth = SCREEN_WIDTH/menuTitle.count;
    
    for (int nIndex = 0; nIndex < menuTitle.count; nIndex++)
    {
        CGFloat nXPos = nIndex * nbuttonWidth;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[menuTitle objectAtIndex:nIndex] forState:UIControlStateNormal];
        [button setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
        [button setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        button.tag = nIndex;
        if (nIndex == 0)
        {
            button.selected = YES;
            self.currentIndex = 0;
        }
        button.frame = CGRectMake(nXPos, 0, nbuttonWidth, 40);
        [button addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [_buttons addObject:button];
    }
}

- (void)OnClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (_roomRankMenuBarBlock)
    {
        UIButton *oldButton = [_buttons objectAtIndex:_currentIndex];
        oldButton.selected = NO;
        
        _currentIndex = button.tag;
        button.selected = YES;
        _roomRankMenuBarBlock(button.tag);
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
