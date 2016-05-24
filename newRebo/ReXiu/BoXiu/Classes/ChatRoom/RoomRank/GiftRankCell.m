//
//  GiftRankCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-5-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GiftRankCell.h"
#import "SpecialRankModel.h"
#import "UserInfoManager.h"
#import "UIImageView+WebCache.h"

@interface GiftRankCell ()

@property (nonatomic,strong) UIImageView *rankImageView;
@property (nonatomic,strong) UILabel *rankPos;
@property (nonatomic,strong) UILabel *ranknameLable;
@property (nonatomic,strong) UILabel *rankCountLable;
@property (nonatomic,strong) UIImageView *lineImg;

@end

@implementation GiftRankCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self initGiftRankCell];
    }
    return self;
}


- (void)initGiftRankCell
{
    _rankImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_rankImageView];
    
    _ranknameLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _ranknameLable.font = [UIFont boldSystemFontOfSize:13.0f];
    _ranknameLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [self.contentView addSubview:_ranknameLable];
    
    _rankCountLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _rankCountLable.font = [UIFont systemFontOfSize:12];
    _rankCountLable.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    [self.contentView addSubview:_rankCountLable];
    
    _rankPos = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_rankPos];
    
    _lineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _lineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
    [self.contentView addSubview:_lineImg];
}

- (void)setStarGift:(StarGift *)starGift
{
    _starGift = starGift;
    
    NSURL *giftImageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,starGift.giftImg]];
    [_rankImageView sd_setImageWithURL:giftImageUrl placeholderImage:[UIImage imageNamed:@"leftBtn_normal"]];

    _ranknameLable.text = starGift.giftName;
    
    NSString *countStr = [NSString stringWithFormat:@"%ld ",(long)starGift.value];
    NSInteger leng = [countStr length];
    NSString *mosaicStr = nil;
    if (starGift.giftUnit)
    {
        mosaicStr = [NSString stringWithFormat:@"共收到 %@%@ ",countStr,starGift.giftUnit];
    }
    else
    {
        mosaicStr = [NSString stringWithFormat:@" 共%@个 ",countStr];
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:mosaicStr];
    [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"959596"] range:NSMakeRange(0,4)];
    [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"f7c250"] range:NSMakeRange(4,leng)];
    [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"959596"] range:NSMakeRange(leng + 4,1)];
    
    _rankCountLable.attributedText = str;
    
    
    NSString *posLen = [NSString stringWithFormat:@"%ld",(long)starGift.rankPos];
    NSInteger lengNum = [posLen length];
    
    NSString *mutableStr = [NSString stringWithFormat:@"第 %@ 名",posLen];
    
    NSMutableAttributedString *rankPosStr = [[NSMutableAttributedString alloc] initWithString:mutableStr];
    
    NSMutableDictionary *param1 = [NSMutableDictionary dictionary];
    [param1 setObject:[CommonFuction colorFromHexRGB:@"454a4d"] forKey:NSForegroundColorAttributeName];
    [param1 setObject:[UIFont systemFontOfSize:12.0f] forKey:NSFontAttributeName];
    
    NSMutableDictionary *param2 = [NSMutableDictionary dictionary];
    [param2 setObject:[CommonFuction colorFromHexRGB:@"f7c250"] forKey:NSForegroundColorAttributeName];
    [param2 setObject:[UIFont boldSystemFontOfSize:15.0f] forKey:NSFontAttributeName];
    
    [rankPosStr addAttributes:param1 range:NSMakeRange(0,2)];
    [rankPosStr addAttributes:param2 range:NSMakeRange(2,lengNum)];
    [rankPosStr addAttributes:param1 range:NSMakeRange(lengNum+2,2)];

    [rankPosStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.f] range:NSMakeRange(0, 2)];
    [rankPosStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.f] range:NSMakeRange(2, lengNum)];
    [rankPosStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.f] range:NSMakeRange(lengNum + 2, 2)];
    
    _rankPos.attributedText = rankPosStr;
}

- (void)layoutSubviews
{
    int nXOffset = 10;

    CGSize rankSize = [_rankPos sizeThatFits:CGSizeMake(150, MAXFLOAT)];
    CGSize rankCountSize = [_rankCountLable sizeThatFits:CGSizeMake(200, MAXFLOAT)];
    
    _rankPos.frame = CGRectMake((SCREEN_WIDTH - rankSize.width - 16), (self.frame.size.height - rankSize.height)/2, rankSize.width, rankSize.height);
    _rankImageView.frame = CGRectMake(nXOffset, 15, 25, 25);
    nXOffset += 40;
    
    _ranknameLable.frame = CGRectMake(nXOffset, 10, 100, 20);
    _rankCountLable.frame = CGRectMake(nXOffset, rankSize.height + 11, rankCountSize.width,rankCountSize.height);
    
    self.lineImg.frame = CGRectMake(0, 55.5, SCREEN_WIDTH, 0.5);
}


+ (CGFloat)height
{
    return 55.0f;
}

@end
