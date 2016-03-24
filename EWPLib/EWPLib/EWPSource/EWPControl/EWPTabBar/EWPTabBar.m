//
//  EWPTabBar.m
//  BoXiu
//
//  Created by andy on 14-4-23.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "EWPTabBar.h"
#import "CommonFuction.h"

#define Item_Space (0)

@interface EWPTabBar ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,assign) NSInteger defaultItemTag;
@end
@implementation EWPTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView:frame];
    }
    return self;
}

- (void)initView:(CGRect)frame
{
    self.xOffset = 0;
    [self setClipsToBounds:YES];
    self.backgroundColor = [UIColor clearColor];
    self.normalTextColor = [UIColor blackColor];
    self.selectedTextColor = [UIColor whiteColor];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _scrollView.backgroundColor = [UIColor clearColor];

    [self addSubview:_scrollView];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    [self setItemWithTag:selectedIndex];
}

- (void)reloadData
{
    for(UIView *subview in self.scrollView.subviews){
        [subview removeFromSuperview];
    }
     
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItems)])
    {
        int nItemCount = [self.dataSource numberOfItems];
        CGFloat totalItemWidth = 0;
        for (int nIndex = 0; nIndex < nItemCount; nIndex++)
        {
            int itemWidth = 0;
            int itemHeight = 0;
            if ([self.dataSource respondsToSelector:@selector(widthOfItem:)])
            {
                itemWidth = [self.dataSource widthOfItem:nIndex];
            }
            
            if ([self.dataSource respondsToSelector:@selector(heightOfItem)])
            {
                itemHeight = [self.dataSource heightOfItem];
            }
            
            if ([self.dataSource respondsToSelector:@selector(titleOfItem:)])
            {
                NSString *title = [self.dataSource titleOfItem:nIndex];
                UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [itemBtn setClipsToBounds:YES];
                itemBtn.frame = CGRectMake(Item_Space * (nIndex + 1) + totalItemWidth + self.xOffset, (self.frame.size.height - itemHeight)/2, itemWidth, itemHeight);
                if ([self.dataSource respondsToSelector:@selector(tagOfItem:)])
                {
                    itemBtn.tag = [self.dataSource tagOfItem:nIndex];
                }
                else
                {
                  itemBtn.tag = nIndex;
                }
                if (nIndex == 0)
                {
                    self.defaultItemTag = itemBtn.tag;
                }
                
                itemBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
                [itemBtn setTitle:title forState:UIControlStateNormal];
                [itemBtn setTitleColor:[UIColor colorWithRed:160/255.0 green:150/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
                [itemBtn setTitleColor:self.selectedTextColor forState:UIControlStateSelected];
                
                if (self.normalImage)
                {
                    [itemBtn setBackgroundImage:self.normalImage forState:UIControlStateNormal];
                }
                else
                {
                    if (self.tabNormalBKColor)
                    {
                        [itemBtn setBackgroundImage:[CommonFuction imageWithColor:self.tabNormalBKColor size:itemBtn.frame.size] forState:UIControlStateNormal];
                    }
                    
                }
                
                if (self.selectedImage)
                {
                    [itemBtn setBackgroundImage:self.selectedImage forState:UIControlStateSelected];
                }
                else
                {
                    if (self.tabSelectedBKColor)
                    {
                        [itemBtn setBackgroundImage:[CommonFuction imageWithColor:self.tabSelectedBKColor size:itemBtn.frame.size] forState:UIControlStateSelected];
                    }
                    
                }
                
                [itemBtn setTitleColor:self.normalTextColor forState:UIControlStateNormal];
                [itemBtn setTitleColor:self.selectedTextColor forState:UIControlStateSelected];
                [itemBtn addTarget:self action:@selector(tapItem:) forControlEvents:UIControlEventTouchUpInside];

                [self.scrollView addSubview:itemBtn];
            }
            totalItemWidth += itemWidth;
        }
        CGFloat contentWidth = (totalItemWidth > self.frame.size.width)? (totalItemWidth + nItemCount * Item_Space) : self.frame.size.width;
        self.scrollView.contentSize = CGSizeMake(contentWidth, self.frame.size.height);
        [self setItemWithTag:self.defaultItemTag];
    }
}

- (void)tapItem:(id )sender
{
    UIButton *itemBtn = (UIButton *)sender;
    [self setItemWithTag:itemBtn.tag];
}

- (void)setItemWithTag:(NSInteger)itemTag
{
    for (UIView *view in [self.scrollView subviews])
    {
        if (view && [view isKindOfClass:[UIButton class]])
        {
            UIButton *itemBtn = (UIButton *)view;
            if (itemBtn.tag == itemTag)
            {
                itemBtn.selected = YES;
            }
            else
            {
                itemBtn.selected = NO;
            }
        }
    }
    _selectedIndex = itemTag;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectItemWithTag:)])
    {
        [self.delegate tabBar:self didSelectItemWithTag:itemTag];
    }
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
