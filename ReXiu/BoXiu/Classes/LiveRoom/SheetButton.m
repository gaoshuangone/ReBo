//
//  SheetButton.m
//  BoXiu
//
//  Created by 李杰 on 15/7/18.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "SheetButton.h"
#import "UserInfoManager.h"
@interface SheetButton()

@end

@implementation SheetButton
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self initButtonState];

//        [self setImage:[UIImage imageNamed:@"norSET"] forState:UIControlStateNormal];
//        _point = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2 - 10, 17, 17)];
//        _point.image = [UIImage imageNamed:@"yuanSET"];
//        [self addSubview:_point];
//        
//        _yellowButtonAboveView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,51,20)];
//        _yellowButtonAboveView.center = self.center;
//        _yellowButtonAboveView.image = [UIImage imageNamed:@"selSET"];
//        
//        _yellowButtonAboveView.center = self.imageView.center;
//        _yellowButtonAboveView.alpha = 0
//        [self insertSubview:_yellowButtonAboveView belowSubview:_point];

    }
    return self;
}

-(void)loadFrame
{
    NSLog(@"%d",self.hid);
    if (self.hid) {
        _point.frame=CGRectMake(57, 10+1.5, 17, 17);
        _yellowButtonAboveView.alpha = 1;
        return ;
    }
    
    switch (self.type) {
        case ButtonTypeChat:
        {
                _point.center = CGPointMake(self.frame.size.width - 10, self.frame.size.height/2);
                _yellowButtonAboveView.alpha = 1;
          
        }
            break;
            case ButtonTypeDanmu:
        {
                _point.center = CGPointMake(self.frame.size.width - 10, self.frame.size.height/2);
                _yellowButtonAboveView.alpha = 1;

        }
            break;
            case ButtonTypeAudio:
        {
                _point.center = CGPointMake(self.frame.size.width - 10, self.frame.size.height/2);
                _yellowButtonAboveView.alpha = 1;
        }

        default:
            break;
    }
}
//1
-(void)initButtonState
{
    NSLog(@"%d",self.hid);
    if (self.hid) {
        [self setImage:[UIImage imageNamed:@"norSET"] forState:UIControlStateNormal];
        _point.frame=CGRectMake(26.4, 10+1.5, 17, 17);
        _point.image = [UIImage imageNamed:@"yuanSET"];
        [self addSubview:_point];
        
        _yellowButtonAboveView.frame = CGRectMake(0,0,51,20);
        _yellowButtonAboveView.center = self.center;
        _yellowButtonAboveView.image = [UIImage imageNamed:@"selSET"];
        
        _yellowButtonAboveView.center = self.imageView.center;
        _yellowButtonAboveView.alpha = 0;
        [self insertSubview:_yellowButtonAboveView belowSubview:_point];
        return;
    
    }
    [self setImage:[UIImage imageNamed:@"norSET"] forState:UIControlStateNormal];
    _point = [[UIImageView alloc]initWithFrame:CGRectMake(2.4, self.frame.size.height/2 - 10+1.5, 17, 17)];
    _point.image = [UIImage imageNamed:@"yuanSET"];
    [self addSubview:_point];
    
    _yellowButtonAboveView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,51,20)];
    _yellowButtonAboveView.center = self.center;
    _yellowButtonAboveView.image = [UIImage imageNamed:@"selSET"];
    
    _yellowButtonAboveView.center = self.imageView.center;
    _yellowButtonAboveView.alpha = 0;
    [self insertSubview:_yellowButtonAboveView belowSubview:_point];
}

-(void)initButtonhide
{
    NSLog(@"%d",self.hid);

    [self setImage:[UIImage imageNamed:@"selSET"] forState:UIControlStateNormal];
    _point = [[UIImageView alloc]initWithFrame:CGRectMake(30, self.frame.size.height/2 - 10+1, 17, 17)];
    _point.image = [UIImage imageNamed:@"yuanSET"];
    [self addSubview:_point];
    
    _yellowButtonAboveView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,51,20)];
    _yellowButtonAboveView.center = self.center;
    _yellowButtonAboveView.image = [UIImage imageNamed:@"norSET"];
    
    _yellowButtonAboveView.center = self.imageView.center;
    _yellowButtonAboveView.alpha = 0;
    [self insertSubview:_yellowButtonAboveView belowSubview:_point];

}



//-(void)buttonDidClicked
//{
//    self.clicked = !_clicked;
//    
//}

- (void)setClicked:(BOOL)clicked

{
//    if ((self.type = ButtonTypeInvisible)) {
//        _clicked = clicked;
//        if (_clicked)
//        {
//            [UIView animateWithDuration:.25f animations:^{
//                _point.frame = CGRectMake(0, self.frame.size.height/2 - 10, 20, 20);
//                _yellowButtonAboveView.alpha = 0;
//            }];
//        }
//        else
//        {
//           
//            [UIView animateWithDuration:.25f animations:^{
//                _point.center = CGPointMake(self.frame.size.width - 10, self.frame.size.height/2);
//                _yellowButtonAboveView.alpha = 1;
//            }];
//
//        }
//    }
//    else
//    {
    
    //235+15+8, 10, 51, 20

    if (self.hid) {
        _clicked = clicked;
        if (_clicked) {
            [UIView animateWithDuration:.25f animations:^{
                _point.frame=CGRectMake(57, 10+1.5, 17, 17);
                _yellowButtonAboveView.alpha = 1;
                
            }];
        }
        else
        {
            [UIView animateWithDuration:.25f animations:^{
                _point.frame=CGRectMake(26.5, 10+1.5, 17, 17);
                _yellowButtonAboveView.alpha = 0;
            }];
        }
        return ;
    }
        _clicked = clicked;
        if (_clicked) {
            [UIView animateWithDuration:.25f animations:^{
                _point.center = CGPointMake(self.frame.size.width - 11, self.frame.size.height/2);
                _yellowButtonAboveView.alpha = 1;

            }];
        }
        else
        {
            [UIView animateWithDuration:.25f animations:^{
                _point.center = CGPointMake(self.frame.size.width - 39.5, self.frame.size.height/2);
                _yellowButtonAboveView.alpha = 0;
            }];
        }
    
//    }

}





@end
