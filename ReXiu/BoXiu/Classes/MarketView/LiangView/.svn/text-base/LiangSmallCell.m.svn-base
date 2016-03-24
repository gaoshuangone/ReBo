//
//  LiangSmallCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-9-3.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "LiangSmallCell.h"
#import "CommonFuction.h"

@interface LiangSmallCell()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIButton *buyBtn;

@property (nonatomic,strong) UIImageView *liangImg;
@property (nonatomic,strong) UILabel *IdxcodeLable;

@property (nonatomic,strong) UILabel *coinNameLable;
@property (nonatomic,strong) UILabel *unitLabel;

@end

@implementation LiangSmallCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self initSubView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame liangData:(LiangData *)liangData;
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initSubView];
        
        self.liangData = liangData;
    }
    return self;
}

- (void)initSubView
{
    self.backgroundColor = [UIColor clearColor];
    
    _backView = [[UIView alloc] initWithFrame:CGRectZero];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    
    _liangImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_backView addSubview:_liangImg];
    
    _IdxcodeLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _IdxcodeLable.textAlignment = NSTextAlignmentLeft;
    _IdxcodeLable.font = [UIFont boldSystemFontOfSize:13.0f];
    _IdxcodeLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [_backView addSubview:_IdxcodeLable];
    
    
    _coinNameLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _coinNameLable.textAlignment = NSTextAlignmentCenter;
    _coinNameLable.font = [UIFont boldSystemFontOfSize:12.0f];
    _coinNameLable.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    _coinNameLable.backgroundColor = [UIColor clearColor];
    [_backView addSubview:_coinNameLable];
    
    _unitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _unitLabel.textAlignment = NSTextAlignmentLeft;
    _unitLabel.font = [UIFont systemFontOfSize:10.0f];
    _unitLabel.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    _unitLabel.backgroundColor = [UIColor clearColor];
    [_backView addSubview:_unitLabel];
    
    _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buyBtn setImage:[UIImage imageNamed:@"buyIdxcode_select"] forState:UIControlStateNormal];
//    [_buyBtn setImage:[UIImage imageNamed:@"buyIdxcode_select"] forState:UIControlStateHighlighted];
    [_buyBtn addTarget:self action:@selector(OnBuy:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buyBtn];
}

-(void)setLiangData:(LiangData *)liangData
{
    _liangData = liangData;
    if (liangData)
    {
        [_liangImg setImage:[UIImage imageNamed:@"liang"]];
        _IdxcodeLable.text = [NSString stringWithFormat:@"%ld",(long)liangData.Idxcode];

        _coinNameLable.text = [NSString stringWithFormat:@"%lld",liangData.coin];
        if (liangData.timeunit == 1)
        {
            _unitLabel.text = @"热币/月";
        }
        else if(liangData.timeunit == 2)
        {
            _unitLabel.text = @"热币/年";
        }
        else
        {
            _unitLabel.text = @"热币/永久";
        }
    }

}

- (void)OnBuy:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(liangSmallCell:buyIdxcode:)])
    {
        [self.delegate liangSmallCell:self buyIdxcode:self.liangData];
    }
}

- (void)layoutSubviews
{
    self.backView.frame = CGRectMake(35, 24, 98, 50);
    CGSize idxcodeSize = [CommonFuction sizeOfString:self.IdxcodeLable.text maxWidth:90 maxHeight:20 withFontSize:14];
    self.liangImg.frame = CGRectMake((self.backView.frame.size.width - 13 - idxcodeSize.width - 5)/2, 10, 13, 13);
    self.IdxcodeLable.frame = CGRectMake(self.liangImg.frame.origin.x + self.liangImg.frame.size.width + 5, 8, idxcodeSize.width, idxcodeSize.height);
    
    CGSize coinSize = [CommonFuction sizeOfString:self.coinNameLable.text maxWidth:60 maxHeight:20 withFontSize:13.0f];
    CGSize unitSize = [CommonFuction sizeOfString:self.unitLabel.text maxWidth:50 maxHeight:20 withFontSize:10];
    self.coinNameLable.frame = CGRectMake((self.backView.frame.size.width - coinSize.width - unitSize.width - 2)/2, 28, coinSize.width, coinSize.height);
    self.unitLabel.frame = CGRectMake(self.coinNameLable.frame.origin.x + self.coinNameLable.frame.size.width + 2, 30, unitSize.width, unitSize.height);
    self.buyBtn.frame = CGRectMake(25, 66, 120, 31);
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
