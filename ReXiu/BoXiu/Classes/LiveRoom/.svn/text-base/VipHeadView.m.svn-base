//
//  VipHeadView.m
//  BoXiu
//
//  Created by 李杰 on 15/7/18.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "VipHeadView.h"
#import "UserInfoManager.h"

@implementation VipHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake(3, 12, self.frame.size.width - 6, self.frame.size.width - 6)];
        headimage.layer.masksToBounds = YES;
        headimage.layer.cornerRadius  = (self.frame.size.width - 6) / 2;
        headimage.image = [UIImage imageNamed:@"defaultHeadIMG"];
        self.headImgView = headimage;
        
//        UIImageView *huan = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-6, self.frame.size.width-6)];
//        huan.layer.masksToBounds = YES;
//        huan.layer.cornerRadius= (self.frame.size.width-6) / 2;
//        huan.image = [UIImage imageNamed:@"huan"];
//        huan.center = headimage.center;leftBtn_normal
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = headimage.frame;
        [button addTarget:self action:@selector(getSite) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
//        抢沙发的昵称
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headimage.frame)+5, self.frame.size.width + 5, 20)];
        nameLabel.center = CGPointMake(headimage.center.x, headimage.center.y +headimage.frame.size.height / 2 + nameLabel.frame.size.height / 2+8);
        nameLabel.text = @" ";
        nameLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = [UIFont systemFontOfSize:11];
        self.nick = nameLabel;
   
        UIImage *normalImg = [CommonFuction imageWithColor:[UIColor whiteColor] size:CGSizeMake(51, 21)];
        UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(51, 21)];
        
        
        UIButton *getSiteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame)+5
                                                                             , self.frame.size.width, 21)];
        [getSiteButton setTitle:@"抢座" forState:UIControlStateNormal];
        [getSiteButton setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
        [getSiteButton setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
        getSiteButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [getSiteButton setBackgroundImage:normalImg forState:UIControlStateNormal];
        [getSiteButton setBackgroundImage:selectImg forState:UIControlStateHighlighted];
        [getSiteButton addTarget:self action:@selector(getSite) forControlEvents:UIControlEventTouchUpInside];
        
        getSiteButton.layer.masksToBounds = YES;
        getSiteButton.layer.cornerRadius = 10;  //圆角（圆形）
        getSiteButton.layer.borderWidth = 0.5f; //描边
        getSiteButton.layer.borderColor  = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
        
//        [self addSubview:huan];
        [self addSubview:headimage];
        [self addSubview:nameLabel];
        [self addSubview:getSiteButton];
    }
    return self;
}

//抢沙发
-(void)getSite
{
    if ([self.delegate respondsToSelector:@selector(didSelectedCell:)])
    {
        [self.delegate didSelectedCell:self];
    }
}

- (void)setData:(SofaData *)data
{
    _data = data;
    if (_data)
    {
        UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        if (userInfo)
        {
            if (_data.userid == userInfo.userId)
            {
                self.nick.text = userInfo.nick;
                if (self.headImgView)
                {
                    NSString *photourl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,_data.photo];
                    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:photourl] placeholderImage:[UIImage imageNamed:@"defaultHeadIMG"]];
                }
            }
            else
            {
//              神秘用户抢沙发的 信息
                if (_data.hidden == 2)
                {
                    if (userInfo.issupermanager)
                    {
                        if (_data.issupermanager)
                        {
                            //                            _nick.textColor = [CommonFuction colorFromHexRGB:@"7F7A6D"];
                            
                            if (_data.nick)
                            {
                                self.nick.text = _data.hiddenindex;
                            }
                            else
                            {
//                                _nick.text = @"木有人";
                            }
//                            self.headImgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
                            self.headImgView.image = [UIImage imageNamed:@"mysteriousHead"];
                        }
                        else
                        {
                            if (self.headImgView)
                            {
                                NSString *photourl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,_data.photo];
                                [self.headImgView sd_setImageWithURL:[NSURL URLWithString:photourl] placeholderImage:[UIImage imageNamed:@"defaultHeadIMG"]];
                            }
                            self.nick.textColor = [UIColor redColor];
                            
                            if (_data.nick)
                            {
                                self.nick.text = _data.nick;
                            }
                            else
                            {
//                                _nick.text = @"木有人";
                            }
                        }
                    }
                    else
                    {
                        self.headImgView.image = [UIImage imageNamed:@"defaultHeadIMG"];

                        if (_data.nick)
                        {
                            self.nick.text = _data.hiddenindex;
                            self.headImgView.image = [UIImage imageNamed:@"mysteriousHead"];
                        }
                        else
                        {
                            _nick.text = @"";
                        }
//                        self.headImgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
                    }
                }
                else
                {
                    if (self.headImgView)
                    {
                        NSString *photourl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,_data.photo];
                        [self.headImgView sd_setImageWithURL:[NSURL URLWithString:photourl] placeholderImage:[UIImage imageNamed:@"defaultHeadIMG"]];
                    }
                    //                    _nick.textColor = [CommonFuction colorFromHexRGB:@"7F7A6D"];
                    if (_data.nick)
                    {
                        self.nick.text = _data.nick;
                    }
                    else
                    {
//                        _nick.text = @"木有人";
                    }
                }
            }
        }
        else
        {
            if (_data.hidden == 2)
            {
                //                _nick.textColor = [CommonFuction colorFromHexRGB:@"7F7A6D"];
                
                if (_data.nick)
                {
                    self.nick.text = _data.hiddenindex;
                    self.headImgView.image = [UIImage imageNamed:@"mysteriousHead"];

                }
                else
                {
//                    _nick.text = @"木有人";
                }
//                self.headImgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
                self.headImgView.image = [UIImage imageNamed:@"defaultHeadIMG"];

            }
            else
            {
                if (self.headImgView)
                {
                    NSString *photourl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,_data.photo];
                    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:photourl] placeholderImage:[UIImage imageNamed:@"defaultHeadIMG"]];
                    
                }
                //                _nick.textColor = [CommonFuction colorFromHexRGB:@"7F7A6D"];
                if (_data.nick)
                {
                    self.nick.text = _data.nick;
                }
                else
                {
//                    _nick.text = @"木有人";
                }
            }
        }
    }
}

@end
