//
//  LiveRoomUserCarView.m
//  BoXiu
//
//  Created by andy on 16/3/22.
//  Copyright © 2016年 rexiu. All rights reserved.
//

#import "LiveRoomUserCarView.h"
#import "OHAttributedLabel.h"
@interface LiveRoomUserCarView()
@property (strong, nonatomic) UIView* viewBG;
@property (strong, nonatomic) UIView* viewShalw;
@property (strong, nonatomic)UIImageView* imageViewHead;
@property (strong, nonatomic)UIImageView* imageViewCar;
@property (strong, nonatomic)UILabel* label;

@end
@implementation LiveRoomUserCarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)initView:(CGRect)frame
{
    
    self.clipsToBounds = YES;
    _viewBG = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 40)];
      [self addSubview:_viewBG];
    _viewShalw = [[UIView alloc]initWithFrame:CGRectZero];
    _viewShalw.backgroundColor =  [CommonFuction colorFromHexRGB:@"000000" alpha:0.3];
    _viewShalw.frame = CGRectMake(10+20, 2.5, 200, 35);
    _viewShalw.layer.cornerRadius = 35/2;
        [_viewBG addSubview:_viewShalw];
    
    _imageViewHead = [[UIImageView alloc]initWithFrame:CGRectZero];
    _imageViewHead.frame = CGRectMake(10, 0, 40, 40);
    _imageViewHead.layer.cornerRadius = 20;
    [_viewBG addSubview:_imageViewHead];

    _label = [[UILabel alloc] init];
    _label.frame = CGRectMake(50+2.5, 5, 200, 100);
    _label.textColor = [UIColor blackColor];

    [_viewBG addSubview:_label];
    

    _imageViewCar = [[UIImageView alloc]initWithFrame:CGRectZero];
    [_viewBG addSubview:_imageViewCar];
    
  
    
}
-(void)showUserCarWithUserInfo:(UserInfo*)userInfo{
 
    //解决两个人同时进来情况，存一个数组，有数据了return，动画完成后清除数据，重复执行
   
    NSURL *headUrl = [NSURL URLWithString: [NSString stringWithFormat:@"%@/%@",[AppInfo shareInstance].res_server,userInfo.photo]];
    [_imageViewHead sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@"leftBtn_normal"]];//左侧头像
    
    NSString* str = [NSString stringWithFormat:@"%@\n进入了房间",userInfo.nick];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange range = [noteStr.string rangeOfString:@"进入了房间"];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range];
    [noteStr addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"ffd178"] range:range];
    
    NSRange range1 = [noteStr.string rangeOfString:userInfo.nick];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:range1];
    [noteStr addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"ffffff"] range:range1];
    _label.numberOfLines =0;
    [_label setAttributedText:noteStr] ;
    [_label sizeToFit];
    
    
       _imageViewCar.frame  = CGRectMake(_label.frameX+_label.frameWidth+10, 5, 45, 30.5);
    NSURL *headUrl1 = [NSURL URLWithString: [NSString stringWithFormat:@"%@/%@",[AppInfo shareInstance].res_server,userInfo.cardata.carimgsmall]];
    [_imageViewCar sd_setImageWithURL:headUrl1 placeholderImage:nil];//左侧头像
    _viewShalw.frame = CGRectMake(_viewShalw.frameX, _viewShalw.frameY, 20+_label.frameWidth+10+45/2, _viewShalw.frame.size.height);
    
    
        _viewBG.frame = CGRectMake(0, 40, SCREEN_WIDTH, 40);
    
 
    
    [UIView animateWithDuration:1.5 animations:^{
            _viewBG.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(changeFrame) withObject:nil afterDelay:2];
        
    }];
    
    

}
-(void)changeFrame{
        _viewBG.frame = CGRectMake(0, 40, SCREEN_WIDTH, 40);
}

@end
