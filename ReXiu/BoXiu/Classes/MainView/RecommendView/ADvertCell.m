//
//  ADvertCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-12-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ADvertCell.h"
#import "EWPADView.h"
#import "HomePageAdvertModel.h"

@interface ADvertCell ()

@property (nonatomic,strong) EWPADView *ewpAdView;
@property (nonatomic,strong) UIButton *closeBtn;
@end

@implementation ADvertCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _ewpAdView = [[EWPADView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [ADvertCell height]) placeHolderImg:[UIImage imageNamed:@"logoPoster"] adImgUrlArray:nil adBlock:^(int nIndex)
                                {
                                    if (self.delegate && [self.delegate respondsToSelector:@selector(adVertCell:indexOfAdImg:)])
                                    {
                                        [self.delegate adVertCell:self indexOfAdImg:nIndex];
                                    }
                                }];
        [self.contentView addSubview:_ewpAdView];
        
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"advertClose"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(OnClose) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_closeBtn];
    }
    return self;
}

-(void)setAdImgUrlArray:(NSMutableArray *)AdImgUrlArray
{
    _AdImgUrlArray = AdImgUrlArray;
    if (AdImgUrlArray)
    {
        NSMutableArray *imgUrlAry = [NSMutableArray array];
        
        for (HomePageAdData *adData in AdImgUrlArray)
        {
            NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,adData.imgurl];
            [imgUrlAry addObject:url];
        }
        _ewpAdView.adImgUrlArray = imgUrlAry;
    }
}


-(void)OnClose
{
    if (_delegate && [_delegate respondsToSelector:@selector(closeAdVertCell)])
    {
        [_delegate closeAdVertCell];
    }
}


-(void)layoutSubviews
{
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _ewpAdView.frame = CGRectMake(0, 0, self.frame.size.width, [ADvertCell height]);
    _closeBtn.frame = CGRectMake(self.frame.size.width - 40, 0, 40, 40);
}

+ (CGFloat)height
{
    return 180;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
