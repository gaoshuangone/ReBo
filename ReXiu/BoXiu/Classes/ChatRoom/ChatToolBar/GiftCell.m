//
//  GiftCell.m
//  BoXiu
//
//  Created by andy on 14-4-24.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GiftCell.h"
#import "UIImageView+WebCache.h"
#import "AppInfo.h"
#import "CommonFuction.h"

@interface GiftCell ()
@property (nonatomic,strong) UIImageView *selectedImageView;
@property (nonatomic,strong) UIImageView *giftImgView;
@property (nonatomic,strong) UILabel *giftName;
@property (nonatomic,strong) UILabel *coinLable;
@property (nonatomic,strong) UIImageView *luckyImgView;

@end

@implementation GiftCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initView:(CGRect)frame
{
    _selectedImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _selectedImageView.backgroundColor = [UIColor blackColor];
    _selectedImageView.alpha = 0.5;
    _selectedImageView.hidden = YES;
    [self addSubview:_selectedImageView];
    
    _giftImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_giftImgView];
    
    _giftName = [[UILabel alloc] initWithFrame:CGRectZero];
    _giftName = [[UILabel alloc] initWithFrame:CGRectZero];
    _giftName.textColor = [UIColor whiteColor];
    _giftName.textAlignment = NSTextAlignmentCenter;
    _giftName.font = [UIFont systemFontOfSize:10.0f];
    [self addSubview:_giftName];
    
    _coinLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _coinLable.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _coinLable.textAlignment = NSTextAlignmentCenter;
    _coinLable.font = [UIFont systemFontOfSize:10.0f];
    [self addSubview:_coinLable];
    
    _luckyImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_luckyImgView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClickGift:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)setGiftData:(GiftData *)giftData
{
    _giftData = giftData;
    if (giftData)
    {
        NSString *giftImgUrl = [NSString stringWithFormat:@"%@/%@",[AppInfo shareInstance].res_server,giftData.giftimg];
        [self.giftImgView sd_setImageWithURL:[NSURL URLWithString:giftImgUrl] placeholderImage:[UIImage imageNamed:@"gift"]];
        self.giftName.text = giftData.giftname;
        self.coinLable.text = [NSString stringWithFormat:@"%ld热币",(long)giftData.coin];
        if (giftData.luckyflag == 1)
        {
            _luckyImgView.image = [UIImage imageNamed:@"luckyflag"];
        }
    }
}

- (void)SetSelect:(BOOL)bSelected
{
    if (bSelected)
    {
        self.selectedImageView.hidden = NO;
    }
    else
    {
        self.selectedImageView.hidden = YES;
    }
}

- (void)OnClickGift:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gitfCell:didSelectItemWithTag:)])
    {
        [self.delegate gitfCell:self didSelectItemWithTag:self.giftData.giftid];
    }
}

- (void)layoutSubviews
{
    self.selectedImageView.frame = CGRectMake((self.frame.size.width - 45)/2, 0, 45, 45);
    self.giftImgView.frame = CGRectMake((self.frame.size.width - 40)/2, 2.5, 40, 40);
    self.giftName.frame = CGRectMake(0, 47, self.frame.size.width, 15);
    self.coinLable.frame = CGRectMake(0, 60, self.frame.size.width, 15);
    self.luckyImgView.frame = CGRectMake(8, 0, 16, 18);

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
