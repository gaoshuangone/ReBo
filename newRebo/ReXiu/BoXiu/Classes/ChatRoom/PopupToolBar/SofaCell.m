 //
//  SofaCell.m
//  BoXiu
//
//  Created by andy on 14-5-14.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "SofaCell.h"
#import "UIImageView+WebCache.h"
#import "AppInfo.h"
#import "CommonFuction.h"
#import "UserInfoManager.h"

@implementation SofaData

@end

@interface SofaCell ()

@property (nonatomic,strong) UIImageView *headImgView;
@property (nonatomic,strong) UILabel *nick;

@end
@implementation SofaCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGFloat nYOffset = 10;
        
        UIImage *sofaImg = [UIImage imageNamed:@"sofa"];
        //sofaImg.size.width, sofaImg.size.height
        UIImageView *sofaImgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - sofaImg.size.width)/2, nYOffset, 40, 40)];
        sofaImgView.image = sofaImg;
        sofaImgView.userInteractionEnabled = YES;
        [sofaImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(robSofa)]];
        [self addSubview:sofaImgView];
        
        //43
        _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 43)/2-1, nYOffset + 4.5, 32, 32)];
        _headImgView.layer.cornerRadius = 17.0f;
        [_headImgView setClipsToBounds:YES];
        [self addSubview:_headImgView];
        
        _nick = [[UILabel alloc] initWithFrame:CGRectMake(-11,sofaImgView.frame.origin.y + sofaImgView.frame.size.height, frame.size.width+10, 20)];
        _nick.text = @"木有人";
        _nick.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
        _nick.font = [UIFont systemFontOfSize:10.0f];
        _nick.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nick];
    }
    return self;
}

- (void)robSofa
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sofaCell:sofaData:)])
    {
        [self.delegate sofaCell:self sofaData:self.sofaData];
    }
}

- (void)setSofaData:(SofaData *)sofaData
{
    _sofaData = sofaData;
    if (sofaData)
    {
        UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        if (userInfo)
        {
            if (sofaData.userid == userInfo.userId)
            {
//                self.nick.textColor = [UIColor redColor];
                self.nick.text = userInfo.nick;
                if (self.headImgView)
                {
                    NSString *photourl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,sofaData.photo];
                    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:photourl]];
                }
            }
            else
            {
                if (sofaData.hidden == 2)
                {
                    if (userInfo.issupermanager)
                    {
                        if (sofaData.issupermanager)
                        {
//                            _nick.textColor = [CommonFuction colorFromHexRGB:@"7F7A6D"];
                            
                            if (sofaData.nick)
                            {
                                self.nick.text = sofaData.hiddenindex;
                            }
                            else
                            {
                                _nick.text = @"木有人";
                            }
                            self.headImgView.image = [UIImage imageNamed:@"mysteriousHead"];
                        }
                        else
                        {
                            if (self.headImgView)
                            {
                                NSString *photourl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,sofaData.photo];
                                [self.headImgView sd_setImageWithURL:[NSURL URLWithString:photourl]];
                            }
                            self.nick.textColor = [UIColor redColor];
                            
                            if (sofaData.nick)
                            {
                                self.nick.text = sofaData.nick;
                            }
                            else
                            {
                                _nick.text = @"木有人";
                            }
                        }
                    }
                    else
                    {
//                        _nick.textColor = [CommonFuction colorFromHexRGB:@"7F7A6D"];
                        if (sofaData.nick)
                        {
                            self.nick.text = sofaData.hiddenindex;
                        }
                        else
                        {
                            _nick.text = @"木有人";
                        }
                        self.headImgView.image = [UIImage imageNamed:@"mysteriousHead"];
                    }
                }
                else
                {
                    if (self.headImgView)
                    {
                        NSString *photourl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,sofaData.photo];
                        [self.headImgView sd_setImageWithURL:[NSURL URLWithString:photourl]];
                        
                    }
//                    _nick.textColor = [CommonFuction colorFromHexRGB:@"7F7A6D"];
                    
                    if (sofaData.nick)
                    {
                        self.nick.text = sofaData.nick;
                    }
                    else
                    {
                        _nick.text = @"木有人";
                    }

                }
            }
        }
        else
        {
            if (sofaData.hidden == 2)
            {
//                _nick.textColor = [CommonFuction colorFromHexRGB:@"7F7A6D"];
                
                if (sofaData.nick)
                {
                    self.nick.text = sofaData.hiddenindex;
                }
                else
                {
                    _nick.text = @"木有人";
                }
                self.headImgView.image = [UIImage imageNamed:@"mysteriousHead"];
            }
            else
            {
                if (self.headImgView)
                {
                    NSString *photourl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,sofaData.photo];
                    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:photourl]];
                    
                }
//                _nick.textColor = [CommonFuction colorFromHexRGB:@"7F7A6D"];
                if (sofaData.nick)
                {
                    self.nick.text = sofaData.nick;
                }
                else
                {
                    _nick.text = @"木有人";
                }
                
            }

        }
    }
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
