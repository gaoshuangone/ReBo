//
//  ChooseBar.m
//  BrandShow
//
//  Created by CaiZetong on 15/2/3.
//  Copyright (c) 2015年 cc. All rights reserved.
//

#import "ChooseBar.h"
#define LeftMargin      27

#define COLOR(r,g,b)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

//#define PinkColor       COLOR(255, 66, 129)
#define YellowColor       COLOR(247, 194, 80)
#define NormalColor     COLOR(151, 151, 151)
#define MarkViewHeight  4

@implementation ChooseBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        _selectedIndex = -1;
        
    }
    return self;
}


- (void)setStringArray:(NSMutableArray *)stringArray
{
    [self.topItems removeAllObjects];
    [self.bottomItems removeAllObjects];
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    self.itemBottomView = [[UIView alloc] init];
    self.itemTopView = [[UIView alloc] init];
    self.topItems = [[NSMutableArray alloc] init];
    self.bottomItems = [[NSMutableArray alloc] init];
    
    [self addSubview:self.itemBottomView];
    [self addSubview:self.itemTopView];
    
    CGFloat middleMargin = 40;
    CGFloat leftX = 0;
    NSInteger i = 0;
    CGFloat itemHeight = self.frame.size.height;
//    CGFloat itemWidth = 120;
    for (NSString *title in stringArray)
    {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.tintColor = NormalColor;
        [item setTitle:title forState:UIControlStateNormal];
        item.tag = i;
        item.titleLabel.font = [UIFont systemFontOfSize:14];
        [item setTitleColor:NormalColor forState:UIControlStateNormal];
        CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, itemHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:item.titleLabel.font} context:nil];
        
        item.frame = CGRectMake(leftX, 0, rect.size.width, itemHeight);
        [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.itemBottomView addSubview:item];
        [self.bottomItems addObject:item];
        
        leftX = CGRectGetMaxX(item.frame) + middleMargin;
        i++;
    }
    self.itemBottomView.frame = CGRectMake(LeftMargin, 0, leftX - middleMargin, itemHeight);
    
    leftX = 0;
    i = 0;
    for (NSString *title in stringArray)
    {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
//        item.backgroundColor = [UIColor yellowColor];
        item.tintColor = YellowColor;
        [item setTitle:title forState:UIControlStateNormal];
        item.tag = i;
        item.titleLabel.font =  [UIFont systemFontOfSize:14];
        [item setTitleColor:YellowColor forState:UIControlStateNormal];
        CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, itemHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:item.titleLabel.font} context:nil];
        item.frame = CGRectMake(leftX, 0, rect.size.width, itemHeight);
        [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.itemTopView addSubview:item];
        [self.topItems addObject:item];
        
        leftX = CGRectGetMaxX(item.frame) + middleMargin;
        i++;
    }
    self.itemTopView.frame = CGRectMake(LeftMargin, 0, leftX - middleMargin, itemHeight);
    
    UIView *pinkLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.itemTopView.frame.size.height - 6, self.itemTopView.frame.size.width, 2)];
    pinkLineView.backgroundColor = YellowColor;
    [self.itemTopView addSubview:pinkLineView];
    
//    self.selectedMark = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, itemHeight)];
//    self.selectedMark.backgroundColor = [UIColor colorWithRed:2/255.0f green:228/255.0f blue:255/255.0f alpha:1];
//    
//    self.itemTopView.maskView = self.selectedMark;
//    
    
//    
        self.selectedMarkLayer = [CALayer layer] ;
        self.selectedMarkLayer.frame = CGRectMake(0, 0, 100, itemHeight);
        self.selectedMarkLayer.backgroundColor =([UIColor colorWithRed:2/255.0f green:228/255.0f blue:255/255.0f alpha:1].CGColor);

    [self.itemTopView.layer setMask:self.selectedMarkLayer];
    self.itemTopView.userInteractionEnabled = NO;
    
    CGRect selfFrame = self.frame;
    selfFrame.size.width = 2 * LeftMargin + self.itemTopView.frame.size.width;
    self.frame = selfFrame;

}


- (void)itemAction:(UIButton *)item
{
    [self setSelectedIndex:item.tag animated:YES];
    
    
    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    [self setSelectedIndex:selectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated
{
    if (_selectedIndex == selectedIndex)
    {
        
    }
    else
    {
        _selectedIndex = selectedIndex;
        if (_selectedIndex >= 0 && _selectedIndex < self.topItems.count)
        {
            UIButton *item = [self.topItems objectAtIndex:_selectedIndex];
            
            if (animated)
            {
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{

//                    self.selectedMark.frame = item.frame;
                      self.selectedMarkLayer.frame = item.frame;
                } completion:^(BOOL finished) {
                    
                }];
            }
            else
            {
//                self.selectedMark.frame = item.frame;
                     self.selectedMarkLayer.frame = item.frame;
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(chooseBar:didSelectIndex:)])
        {
            [self.delegate chooseBar:self didSelectIndex:selectedIndex];
        }
    }
    
    
}
@end
