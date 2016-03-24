//
//  TheCarCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-8-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "TheCarCell.h"
#import "AppInfo.h"
#import "UIButton+WebCache.h"
#import "CarSmallCell.h"

@interface TheCarCell()

@property (nonatomic,strong) UIButton *buyCarBtn;
@property (nonatomic,strong) UIImageView *carImg;
@property (nonatomic,strong) UIImageView *carBKImg;
@property (nonatomic,strong) UIImageView *carBrandImg;
@property (nonatomic,strong) UILabel *carNameLable;
@property (nonatomic,strong) UILabel *coinNameLable;
@property (nonatomic,strong) UILabel *unitLabel;
@property (nonatomic,strong) UIImageView *hLineImgeView;
@property (nonatomic,strong) UILabel *lineLable;
@end

@implementation TheCarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initSubView];
        
    }
    return self;
}

- (void)initSubView
{
    self.backgroundColor = [UIColor whiteColor];
    UIImage *rechargeImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(68, 25)];
    UIImage *rechargeImgNOR = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(68, 25)];
    

    UIImage *img = [CommonFuction imageWithColor:[UIColor colorWithWhite:1 alpha:0.3] size:CGSizeMake(68, 25)];
    _buyCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buyCarBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
     [_buyCarBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    [_buyCarBtn setTitle:@"拥有Ta" forState:UIControlStateNormal];
    _buyCarBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    _buyCarBtn.layer.cornerRadius = 12.5;
    [_buyCarBtn setBackgroundImage:rechargeImgNOR forState:UIControlStateNormal];
     [_buyCarBtn setBackgroundImage:rechargeImg forState:UIControlStateHighlighted];
    _buyCarBtn.layer.masksToBounds = YES;
    _buyCarBtn.layer.borderColor =[CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    _buyCarBtn.layer.borderWidth = 0.5;
    [_buyCarBtn addTarget:self action:@selector(OnBuy:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_buyCarBtn];
    
    _carBKImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _carBKImg.image = [UIImage imageNamed:@"carBK"];
//    [self.contentView addSubview:_carBKImg];
    
    _carImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_carImg];
    
    _carBrandImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_carBrandImg];
    
    _carNameLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _carNameLable.textAlignment = NSTextAlignmentLeft;
    _carNameLable.font = [UIFont systemFontOfSize:12.0f];
    _carNameLable.textColor =[CommonFuction colorFromHexRGB:@"454a4d"];
    _carNameLable.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_carNameLable];
    
    
    _coinNameLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _coinNameLable.textAlignment = NSTextAlignmentRight;
    _coinNameLable.font = [UIFont boldSystemFontOfSize:13.0f];
    _coinNameLable.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    _coinNameLable.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_coinNameLable];
    
    _unitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _unitLabel.textAlignment = NSTextAlignmentLeft;
    _unitLabel.font = [UIFont systemFontOfSize:11.0f];
    _unitLabel.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    _unitLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_unitLabel];
    
    _hLineImgeView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _hLineImgeView.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
    _hLineImgeView.alpha=0.35;
    [self.contentView addSubview:_hLineImgeView];
    
    _lineLable = [[UILabel alloc] initWithFrame:CGRectMake(95, 79, SCREEN_WIDTH - 95, 1)];
    _lineLable.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
    [self.contentView addSubview:_lineLable];

    
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(buyCarWithData:)])
    {
        [self.delegate buyCarWithData:self.carData];
    }
}

- (void)layoutSubviews
{
    self.contentView.frame = self.bounds;
    self.buyCarBtn.frame = CGRectMake(235, 23.5, 63, 25);
    
    self.carBKImg.frame = CGRectMake(10, 41, 100, 20);
    self.carImg.frame = CGRectMake(23, 19, 60, 36);
    
    CGSize carNameSize = [CommonFuction sizeOfString:self.carNameLable.text maxWidth:100 maxHeight:20 withFontSize:12.0f];
    
    self.carBrandImg.frame = CGRectMake(self.carBKImg.frame.origin.x + self.carBKImg.frame.size.width,16, 25, 25);
    self.carNameLable.frame = CGRectMake(self.carBrandImg.frame.origin.x + self.carBrandImg.frame.size.width + 5,21, carNameSize.width + 18 , carNameSize.height);
    
    CGSize coinSize = [CommonFuction sizeOfString:[NSString stringWithFormat:@"%lld",self.carData.coin] maxWidth:100 maxHeight:20 withFontSize:14.0f];
    CGSize unitSize = [CommonFuction sizeOfString:_unitLabel.text maxWidth:50 maxHeight:20 withFontSize:11.0f];
    self.coinNameLable.frame = CGRectMake(self.carBKImg.frame.origin.x + self.carBKImg.frame.size.width, 42, coinSize.width, coinSize.height);
    self.unitLabel.frame = CGRectMake(self.coinNameLable.frame.origin.x + coinSize.width + 5, 44, unitSize.width, unitSize.height);
    
    _hLineImgeView.frame = CGRectMake(120, self.frame.size.height - 0.5, self.frame.size.width - 20, 0.5);
}

+ (CGFloat)height
{
    return 80.0f;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
