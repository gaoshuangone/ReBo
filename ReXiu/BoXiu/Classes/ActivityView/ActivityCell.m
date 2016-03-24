//
//  ActivityCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-6-13.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ActivityCell.h"
#import "UIImageView+WebCache.h"

@interface ActivityCell()
@property(nonatomic,strong) UIView *backView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIImageView *activityImage;

@end

@implementation ActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = [UIColor clearColor];
    if (self) {
        // Initialization code
        _backView = [[UIView alloc] initWithFrame:CGRectZero];
        _backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _backView.layer.borderWidth = 0.5;
        _backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_backView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _titleLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
        [_backView addSubview:_titleLabel];
        
        _activityImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_backView addSubview:_activityImage];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _backView.frame = CGRectMake(16,16,self.bounds.size.width - 32,199);
    _activityImage.frame = CGRectMake(10,10,_backView.frame.size.width - 20,150);
    _titleLabel.frame = CGRectMake(8,170,_backView.frame.size.width - 16,20);
}

+ (CGFloat)height
{
    return 220.0f;
}

- (void) setRobActivity:(RobActivity *)robActivity
{
    _robActivity = robActivity;
    
    _titleLabel.text = _robActivity.title;
    NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,_robActivity.imgurlmobile];
    [_activityImage sd_setImageWithURL:[NSURL URLWithString:url]];
}
@end
