//
//  InviterNumCell.m
//  BoXiu
//
//  Created by tongmingyu on 15-6-9.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "InviterNumCell.h"
#import "ViewController.h"
#import "InviterCell.h"
#import "InviterNumCell.h"
#import "UserInfo.h"
#import "UserInfoManager.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"

#import "LiveRoomLeftView.h"

@interface InviterNumCell()
@property (nonatomic,strong) UILabel *numTitle;
@property (nonatomic,strong)  UIButton *inviter;

@property (nonatomic,strong) EWPButton *point;
@property (nonatomic,strong) NSString *friend;

@end

@implementation InviterNumCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
        
    }
    return self;
}

- (void)initSubView
{
    int YOffset =13;
    
    UILabel *rechargeTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, YOffset, 90, 20)];
    rechargeTitle.font = [UIFont systemFontOfSize:14.0f];
    rechargeTitle.text = Invite_num;
    rechargeTitle.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [self.contentView addSubview:rechargeTitle];
    
    
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(80, 25)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"c34845"] size:CGSizeMake(80, 25)];
    
    _inviter = [UIButton buttonWithType:UIButtonTypeCustom];
    _inviter.frame = CGRectMake((SCREEN_WIDTH - 88),(43 - 25)/2+2, 73, 25);
    [_inviter setTitle:Invite_Friends_Title forState:UIControlStateNormal];
    _inviter.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
  
    
    [_inviter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_inviter setBackgroundImage:normalImg forState:UIControlStateNormal];
    [_inviter setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    [_inviter setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    _inviter.layer.masksToBounds = YES;
    _inviter.layer.cornerRadius = 12.0;
    _inviter.layer.borderWidth = 0.5;
    _inviter.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [_inviter addTarget:self action:@selector(shareBoxiu2:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_inviter];
    
    
    
    _numTitle = [[UILabel alloc] init];
    _numTitle.font = [UIFont boldSystemFontOfSize:16.0f];
    _numTitle.frame = CGRectMake(74, YOffset - 4, 20, 20);
    //    _numTitle.textAlignment= NSTextAlignmentCenter;
    _numTitle.lineBreakMode = NSLineBreakByWordWrapping;
    _numTitle.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    [self.contentView addSubview:_numTitle];
    
    _point = [EWPButton buttonWithType:UIButtonTypeRoundedRect];
    _point.frame = CGRectMake( 102 ,YOffset-5, 98 , 21);
    _point.tag = 3380;
    [_point setImage:[UIImage imageNamed:@"Doubt"] forState:UIControlStateNormal];
    _point.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [_point setTintColor:[CommonFuction colorFromHexRGB:@"e67e22"]];
    
    __weak typeof(self) weakself = self;
    _point.buttonBlock = ^(id sender)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:Info_message delegate:weakself cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        [alert show];
        
    };
    [self.contentView addSubview: _point];
    
}

- (void)setSuccessCount:(NSInteger)successCount
{
    _successCount = successCount;
    _numTitle.text = [NSString stringWithFormat:@"%ld",(long)_successCount];
    
    _friend=[NSString stringWithFormat:@"%ld",(long)_successCount];
    NSInteger lengNum = [_friend length];
    _numTitle.frame = CGRectMake(52 + 9, 14, lengNum * 10 , 20);
    
    _point.frame = CGRectMake( 52 + 15 + lengNum * 10 , 13 , 98 , 21);
    
    
}

-(void)shareBoxiu2:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(inviteFriend)])
    {
        [self.delegate inviteFriend];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
