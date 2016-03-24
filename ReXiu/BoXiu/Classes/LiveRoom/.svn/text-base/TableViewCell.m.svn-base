//
//  TableViewCell.m
//  BoXiu
//
//  Created by 李杰 on 15/7/21.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        _headIMG = [[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 55, 55)];
        _headIMG.image = [UIImage imageNamed:@"defaultHeadIMG"];
        
        //排名奖牌
        _medal = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 25, 30)];
        _medal.center = CGPointMake(20, _headIMG.center.y);
        
        //姓名
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width / 4 + 25, 15, self.frame.size.width *2 / 3 - 25, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.text = @"小时候的我们";
        _nameLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
        
        //皇冠图标
        _crown = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.frame.origin.x, CGRectGetMaxY(_nameLabel.frame), 50, 20)];
        _crown.image = [UIImage imageNamed:@"star_13"];
        
        //头像的圆环背景
//        UIImageView *huanIMG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _headIMG.frame.size.width, _headIMG.frame.size.height)];
//        huanIMG.image = [UIImage imageNamed:@"huan"];
//        huanIMG.layer.masksToBounds = YES;
//        huanIMG.layer.cornerRadius = huanIMG.frame.size.height / 2;
//        huanIMG.center = _headIMG.center;

        //分割线
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.frame.origin.x, 65, self.frame.size.width - self.bounds.size.width / 4 - 25, 1)];
        line.backgroundColor = [CommonFuction colorFromHexRGB:@"E2E2E2"];
        
        [self.contentView addSubview:_headIMG];
//        [self.contentView addSubview:huanIMG];
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:line];
        [self.contentView addSubview:_medal];
        [self.contentView addSubview:_crown];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
