//
//  CarSmallCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-9-2.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "CarSmallCell.h"
#import "UIImageView+WebCache.h"
#import "CommonFuction.h"

@interface CarSmallCell()
@property (nonatomic,strong) UIButton *buyCarBtn;
@property (nonatomic,strong) UIImageView *carImg;
@property (nonatomic,strong) UIImageView *carBKImg;
@property (nonatomic,strong) UIImageView *carBrandImg;
@property (nonatomic,strong) UILabel *carNameLable;
@property (nonatomic,strong) UILabel *coinNameLable;
@property (nonatomic,strong) UILabel *unitLabel;

@end

@implementation CarSmallCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self initSubView];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame carData:(MallCarData *)carData
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initSubView];
        self.carData = carData;
    }
    return self;
}

- (void)initSubView
{
    self.backgroundColor = [UIColor whiteColor];
    
    _buyCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buyCarBtn setImage:[UIImage imageNamed:@"buyCar_normal"] forState:UIControlStateNormal];
    [_buyCarBtn setImage:[UIImage imageNamed:@"buCar_select"] forState:UIControlStateHighlighted];
    [_buyCarBtn addTarget:self action:@selector(OnBuy:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buyCarBtn];
    
    _carBKImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _carBKImg.image = [UIImage imageNamed:@"carBK"];
    [self addSubview:_carBKImg];
    
    _carImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_carImg];
    
    _carBrandImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_carBrandImg];
    
    
    _carNameLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _carNameLable.textAlignment = NSTextAlignmentCenter;
    _carNameLable.font = [UIFont systemFontOfSize:12.0f];
    _carNameLable.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    _carNameLable.backgroundColor = [UIColor clearColor];
    [self addSubview:_carNameLable];
    
    
    _coinNameLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _coinNameLable.textAlignment = NSTextAlignmentRight;
    _coinNameLable.font = [UIFont boldSystemFontOfSize:12.0f];
    _coinNameLable.textColor = [CommonFuction colorFromHexRGB:@"f79350"];
   _coinNameLable.backgroundColor = [UIColor clearColor];
    [self addSubview:_coinNameLable];
    
    _unitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _unitLabel.textAlignment = NSTextAlignmentLeft;
    _unitLabel.font = [UIFont systemFontOfSize:10.0f];
    _unitLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    _unitLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_unitLabel];
}

- (void)setCarData:(MallCarData *)carData
{
    _carData = carData;
    if (carData)
    {
         NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,carData.carimg];
        [_carImg sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:nil];
  
        url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,carData.brandimg];
        [_carBrandImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];

        _carNameLable.text = carData.carName;
        
        _coinNameLable.text = [NSString stringWithFormat:@"%lld",carData.coin];
        
        if (carData.timeunit == 1)
        {
            _unitLabel.text = @"热币/月";
        }
        else
        {
            _unitLabel.text = @"热币/年";
        }
    }
}

- (void)OnBuy:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(carSmallCell:buyCar:)])
    {
        [self.delegate carSmallCell:self buyCar:self.carData];
    }
}

- (void)layoutSubviews
{
    self.buyCarBtn.frame = CGRectMake(12, 12, 40, 40);
    
    self.carBKImg.frame = CGRectMake((self.frame.size.width - 100)/2, 74, 100, 20);
    self.carImg.frame = CGRectMake((self.frame.size.width - 74)/2, 43, 74, 50);
    
    CGSize carNameSize = [CommonFuction sizeOfString:self.carNameLable.text maxWidth:100 maxHeight:20 withFontSize:12.0f];
    
    self.carBrandImg.frame = CGRectMake((self.frame.size.width - 25 - carNameSize.width - 5)/2,101, 25, 25);
    self.carNameLable.frame = CGRectMake(self.carBrandImg.frame.origin.x + 25 + 5,105, carNameSize.width, carNameSize.height);
    
    CGSize coinSize = [CommonFuction sizeOfString:[NSString stringWithFormat:@"%lld",self.carData.coin] maxWidth:100 maxHeight:20 withFontSize:13.0f];
    CGSize unitSize = [CommonFuction sizeOfString:_unitLabel.text maxWidth:50 maxHeight:20 withFontSize:10.0f];
    self.coinNameLable.frame = CGRectMake(( self.frame.size.width - coinSize.width - unitSize.width - 5)/2, 123, coinSize.width, 20);
    self.unitLabel.frame = CGRectMake(self.coinNameLable.frame.origin.x + coinSize.width + 5, 126, unitSize.width, 15);
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
