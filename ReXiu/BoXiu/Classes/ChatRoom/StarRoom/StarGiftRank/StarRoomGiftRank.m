//
//  StarRoomGiftRank.m
//  BoXiu
//
//  Created by andy on 14-12-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "StarRoomGiftRank.h"
#import "UserInfoManager.h"
#import "StarGiftRankModel.h"
#import "StarGiftRankItem.h"

@interface StarRoomGiftRank ()

@property (nonatomic,assign) NSInteger staruserid;
@property (nonatomic,strong) UILabel *tipLable;
@property (nonatomic,strong) NSMutableArray *starGiftRankItems;
@end

@implementation StarRoomGiftRank

- (void)initView:(CGRect)frame
{
    self.userInteractionEnabled = NO;
    self.layer.cornerRadius = 8;
    UIImageView *bkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    bkImageView.image = [UIImage imageNamed:@"ReBoRoom_giftbk"];
    [self addSubview:bkImageView];
    
    _tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0,(frame.size.height - 15)/2, frame.size.width, 15)];
    _tipLable.hidden = YES;
    _tipLable.font = [UIFont systemFontOfSize:14.0f];
    _tipLable.text = @"没有礼物记录";
    _tipLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_tipLable];
}

- (void)reloadData:(NSArray *)dataArray
{
    if (dataArray && dataArray.count > 0)
    {
        if (_starGiftRankItems == nil)
        {
            _starGiftRankItems = [NSMutableArray array];
        }
        
        for (StarGiftRankItem *starGiftRankItem in _starGiftRankItems)
        {
            [starGiftRankItem removeFromSuperview];
        }
        [_starGiftRankItems removeAllObjects];

        _tipLable.hidden = YES;
        int nCount = dataArray.count > 5? 5 : dataArray.count;
        for (int nIndex = 0;nIndex < nCount;nIndex++)
        {
            StarGiftRankItemData *data = [dataArray objectAtIndex:nIndex];
            CGFloat height = 15;
            CGFloat nY = nIndex * (height + 15) + 15;
            StarGiftRankItem *starGiftRankItem = [[StarGiftRankItem alloc] initWithFrame:CGRectMake(0, nY, self.frame.size.width, height) showInView:self];
            starGiftRankItem.itemData = data;
            [self addSubview:starGiftRankItem];
            [_starGiftRankItems addObject:starGiftRankItem];
        }
    }
    else
    {
        _tipLable.hidden = NO;
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
