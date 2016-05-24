//
//  LiveBottomView.m
//  BoXiu
//
//  Created by andy on 15/12/10.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "LiveBottomView.h"

@implementation LiveBottomView
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self)
//    {
//        
//        
//            
//        }
//        
//    }
//    return self;
//}
-(id)initView:(CGRect)frame withType:(BottomType)type{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.type = type;
        if (type == BottomType_GuanZHong) {
            
           
            NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];//官方审核开关
            if (hideSwitch != 1)
            {
            }
          NSArray* array  = [NSArray arrayWithObjects:@"LRgongLiao",@"LRsiLiao.png",@"LRshare.png",@"LRgift.png",@"LRclose.png", nil];
        
            for (int i =0; i<5; i++) {
                
                
                NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];//官方审核开关
                if (hideSwitch == 1  && i==2  )
                {
                    
                    continue;
                }
                
                
                EWPButton* button = [EWPButton buttonWithType:UIButtonTypeCustom];
                    button.isSoonCliCKLimit = YES;
                [button setImage:[UIImage imageNamed:[array objectAtIndex:i]] forState:UIControlStateNormal];
                if (i==0) {
                    button.frame = CGRectMake(10, 0, 35, 35);
                }else {
                    button.frame = CGRectMake(SCREEN_WIDTH-10-(5-i)*(35+7)+7, 0, 35, 35);
                }
                if (i==1) {
                    _imageviewRound = [[UIImageView alloc] init];
                    _imageviewRound.hidden = YES;
                    _imageviewRound. frame = CGRectMake(SCREEN_WIDTH-10-(5-i)*(35+7)+7+35-3, 0,7, 7);
                    _imageviewRound.backgroundColor = [UIColor redColor];
                    _imageviewRound.layer.cornerRadius =3.5;
                    [_imageviewRound.layer setMasksToBounds:YES];
                    [self addSubview:_imageviewRound];
                }
                button.tag = i;
                button.buttonBlock = ^(id sender){
                    UIButton* button = sender;
                    self.LiveBottomViewTouch (button.tag);
                };
                [self addSubview:button];
                
            }
        }
        
        
        if (type == BottomType_ZhuBo) {
            NSArray* array = [NSArray arrayWithObjects:@"LRgongLiao",@"LRsiLiao.png",@"LRcca.png",@"LRclose.png", nil];
            
            for (int i =0; i<4; i++) {
                EWPButton* button = [EWPButton buttonWithType:UIButtonTypeCustom];
                button.isSoonCliCKLimit = YES;
                [button setImage:[UIImage imageNamed:[array objectAtIndex:i]] forState:UIControlStateNormal];
                if (i==0) {
                    button.frame = CGRectMake(10, 0, 35, 35);
                }else {
                    button.frame = CGRectMake(SCREEN_WIDTH-10-(4-i)*(35+7)+7, 0, 35, 35);
                }
                if (i==1) {
                    _imageviewRound = [[UIImageView alloc] init];
                    _imageviewRound.hidden = YES;
                    _imageviewRound. frame = CGRectMake(SCREEN_WIDTH-10-(4-i)*(35+7)+7+35-3, 0,7, 7);
                    _imageviewRound.backgroundColor = [UIColor redColor];
                    _imageviewRound.layer.cornerRadius =3.5;
                    [_imageviewRound.layer setMasksToBounds:YES];
                    [self addSubview:_imageviewRound];
                }
                button.tag = i;
                button.buttonBlock = ^(id sender){
                    UIButton* button = sender;
                    self.LiveBottomViewTouch (button.tag);
                };
                [self addSubview:button];
                
            }
            
        }
        
        
    }
    
    
    
    
    
    return self;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
