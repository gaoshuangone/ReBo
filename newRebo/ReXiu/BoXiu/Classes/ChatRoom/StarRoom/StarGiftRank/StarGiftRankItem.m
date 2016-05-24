//
//  StarGiftRankItem.m
//  BoXiu
//
//  Created by andy on 14-12-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "StarGiftRankItem.h"
#import "UIImageView+WebCache.h"

@interface StarGiftRankItem ()
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *countLabel;
@property (nonatomic,strong) UILabel *nickLabel;
@end

@implementation StarGiftRankItem

- (void)initView:(CGRect)frame
{
    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_imgView];
    
    _countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _countLabel.textColor = [CommonFuction colorFromHexRGB:@"f79350"];
    _countLabel.font = [UIFont boldSystemFontOfSize:11.0f];
    [self addSubview:_countLabel];
    
    _nickLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nickLabel.font = [UIFont systemFontOfSize:11];
    _nickLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    [self addSubview:_nickLabel];
}

- (void)setItemData:(StarGiftRankItemData *)itemData
{
    _itemData = itemData;
    if (itemData)
    {
        NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,itemData.giftimg];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
        
        _countLabel.text = [NSString stringWithFormat:@"x %d",itemData.count];
        
        _nickLabel.text = itemData.nick;
    }
}

- (void)layoutSubviews
{
    _imgView.frame = CGRectMake(11, (self.frame.size.height - 16)/2, 16, 16);
    
    CGSize countSize = [CommonFuction sizeOfString:_countLabel.text maxWidth:70 maxHeight:15 withFontSize:12.0f];
    _countLabel.frame = CGRectMake(35, (self.frame.size.height - countSize.height)/2, countSize.width, countSize.height);
    
    CGSize nickSize = [CommonFuction sizeOfString:_nickLabel.text maxWidth:(self.frame.size.width - 82) maxHeight:15 withFontSize:11.0f];
    
    _nickLabel.frame = CGRectMake(78, (self.frame.size.height - nickSize.height)/2, nickSize.width, nickSize.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
