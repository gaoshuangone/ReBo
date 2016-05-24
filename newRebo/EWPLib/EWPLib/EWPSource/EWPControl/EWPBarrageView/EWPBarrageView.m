//
//  EWPBarrageView.m
//  BoXiu
//
//  Created by andy on 14-12-18.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "EWPBarrageView.h"

@interface EWPBarrageView ()
@property (nonatomic,assign) CGFloat itemHeight;
@property (nonatomic,assign) CGFloat itemSpace;
@property (nonatomic,strong) NSMutableArray *barrageMessageItemMArray;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) dispatch_queue_t barrageQueue;
@end

@implementation EWPBarrageView

- (void)dealloc
{
    [self.timer invalidate];
}

- (void)initView:(CGRect)frame
{
    self.hidden = YES;
    self.itemHeight = frame.size.height;
    self.itemSpace = 0;
    self.userInteractionEnabled = NO;
    self.fontSize = 14.0;
    _textColors = [NSMutableArray arrayWithObjects:[UIColor redColor],[UIColor yellowColor],[UIColor blueColor], nil];
    self.duration = 8.8f;
    _barrageQueue = dispatch_queue_create("BarrageQueue", DISPATCH_QUEUE_SERIAL);
}

- (void)setTextColors:(NSMutableArray *)textColors
{
    if ([textColors count])
    {
        [_textColors removeAllObjects];
        [_textColors addObjectsFromArray:textColors];
    }

}

- (void)reloadData
{
    if (_barrageMessageItemMArray == nil)
    {
        _barrageMessageItemMArray = [NSMutableArray array];
    }
    else
    {
        return;
    }
    
    NSInteger nRowCount = 1;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfBarrageViewItem)])
    {
        nRowCount = [self.dataSource numberOfBarrageViewItem];
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(heightOfBarrageViewItem)])
    {
        self.itemHeight = [self.dataSource heightOfBarrageViewItem];
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(spaceOfBarrageViewItem)])
    {
        self.itemSpace = [self.dataSource spaceOfBarrageViewItem];
    }

    CGRect frame = self.frame;
    if (nRowCount > 1)
    {
        frame.size.height = nRowCount * self.itemHeight + (nRowCount - 1) * self.itemSpace;
        self.frame = frame;
    }

    [_barrageMessageItemMArray removeAllObjects];
    
    for(NSInteger nIndex = 0 ;nIndex <= nRowCount - 1; nIndex++)
    {
        CGFloat nYPos = nIndex * (self.itemSpace + self.itemHeight);
        BarrageItem *barrageMessageItem = [[BarrageItem alloc] initWithFrame:CGRectMake(0, nYPos , frame.size.width, self.itemHeight) showInView:self];
        [self addSubview:barrageMessageItem];
        [_barrageMessageItemMArray addObject:barrageMessageItem];
    }
}

- (void)showBarrageView
{
    [self.superview bringSubviewToFront:self];
    if (_timer == nil)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(getBarrageMessage) userInfo:nil repeats:YES];
    }
}

- (void)hideBarrageView
{
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
    self.hidden = YES;
}

- (void)getBarrageMessage
{
    if (_barrageMessageItemMArray == nil || [_barrageMessageItemMArray count] == 0)
    {
        return;
    }
    
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(GetBarrageMessageFromQueue)])
    {
        dispatch_async(_barrageQueue, ^{
            for (BarrageItem *barrageItem in _barrageMessageItemMArray)
            {
               
                if (barrageItem.canAddBarrageMessage)
                {
                    NSString *barrageMessage = [self.dataSource GetBarrageMessageFromQueue];
                    if(barrageMessage)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.hidden = NO;
                        });
                        
                        int colorIndex = rand()%_textColors.count;
                        UIColor *textColor = [_textColors objectAtIndex:colorIndex];
                        [barrageItem addBarrageMessage:barrageMessage textColor:textColor];
                    }
                    else
                    {
                        BOOL commpleteState = YES;
                        for (BarrageItem *barrageItem in _barrageMessageItemMArray)
                        {
                            commpleteState = [barrageItem commpleteStateOfBarrageItem];
                            if (!commpleteState)
                            {
                                break;
                            }
                        }
                        if (commpleteState)
                        {
                            [_timer invalidate];
                            _timer = nil;
                            dispatch_async(dispatch_get_main_queue(), ^{
                                self.hidden = YES;
                            });
                            
                        }
                    }
                     break;
                }
            }

        });
    }
}

- (void)layoutSubviews
{
    [self reloadData];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
