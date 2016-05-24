//
//  LiveShareView.m
//  BoXiu
//
//  Created by andy on 15/12/19.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "LiveShareView.h"
@interface LiveShareView()
@property (strong, nonatomic)UIControl* controlGes;
@end
@implementation LiveShareView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)initView:(CGRect)frame
{
    self.frameTemp = frame;
    _controlGes =[[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_controlGes addTarget:self action:@selector(controlGe) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview: _controlGes];
    
    
}
-(void)setRootLiveRoomViewController:(LiveRoomViewController *)rootLiveRoomViewController{
    
    CGRect frame = self.frameTemp;
    if (rootLiveRoomViewController.liveRoomUserType == liveRoomUserType_NormalUser) {
        
        UIControl* control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self addSubview: control];
        
        UIControl* controlBG =[[UIControl alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-6)];
        controlBG.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        [controlBG.layer setMasksToBounds:YES];
        controlBG.layer.cornerRadius = 6;
        [control addSubview:controlBG];
        
        UIImageView* iamgeViewBG = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-4.5, frame.size.height-6, 9, 6)];
        iamgeViewBG.image = [UIImage imageNamed:@"LRSarrow.png"];
        [control addSubview:iamgeViewBG];
        
        NSArray* arrrayTitlt =  [NSArray arrayWithObjects:@"微信", @"朋友圈", @"QQ", @"QQ空间", @"微博", nil];
        NSArray* arrrayImage =  [NSArray arrayWithObjects:@"LRSwei.png", @"LRSp.png", @"LRSq.png", @"LRSk.png", @"LRSbo.png", nil];
        
        for (int i = 0; i<5; i++) {
            EWPButton * button = [EWPButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, (frame.size.height-6)/5*i, frame.size.width, (frame.size.height-6)/5);
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            button.tag = i;
            button.buttonBlock  = ^(EWPButton* button){
                self.liveShareViewTouche(button.tag);
                [self hidSelfWithisHid:YES];
            };
            
            [button setTitle:[arrrayTitlt objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            [button setImage:[UIImage imageNamed:[arrrayImage objectAtIndex:i]] forState:UIControlStateNormal];
            [control addSubview:button];
        }
    }else{

        
        UIControl* control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview: control];
        
        UIControl* controlBG =[[UIControl alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-6)];
        controlBG.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        [controlBG.layer setMasksToBounds:YES];
        controlBG.layer.cornerRadius = 6;
        [control addSubview:controlBG];
        
        UIImageView* iamgeViewBG = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-4.5, frame.size.height-6, 9, 6)];
        iamgeViewBG.image = [UIImage imageNamed:@"LRSarrow.png"];
        [control addSubview:iamgeViewBG];
        
        NSArray* arrrayTitlt =  [NSArray arrayWithObjects:@"闪光灯", @"翻转", nil];
        NSArray* arrrayImage =  [NSArray arrayWithObjects:@"LRnewS.png", @"LRNEqh.png", nil];
        
        for (int i = 0; i<2; i++) {
            EWPButton * button = [EWPButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, (frame.size.height-3)/2*i, frame.size.width, (frame.size.height-3)/2);
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            button.tag = i;
            [button setTitle:[arrrayTitlt objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            [button setImage:[UIImage imageNamed:[arrrayImage objectAtIndex:i]] forState:UIControlStateNormal];
            __weak typeof(self) weakSelf =self;
            button.isSoonCliCKLimit = YES;
            button.buttonBlock  = ^(EWPButton* button){
                
                button.userInteractionEnabled = NO;
            
                if (button.tag == 0) {
                    
                    
                    
                    
                    
                    if (rootLiveRoomViewController.isFrontCamera == YES) {
                       
                    }else{
                    if (weakSelf.isAVCaptureTorchModeOn) {
                        weakSelf.isAVCaptureTorchModeOn = NO;
                        [button setImage:[UIImage imageNamed:[arrrayImage objectAtIndex:0]] forState:UIControlStateNormal];
                    }else{
                        weakSelf.isAVCaptureTorchModeOn = YES;
                        
                        [button setImage:[UIImage imageNamed:@"LRNEWk.png"] forState:UIControlStateNormal];
                    }
                    }
                }
                weakSelf.liveShareViewTouche(button.tag);
                
            };
            
            
            [control addSubview:button];
        }
    }

}

-(void)controlGe{
    self.hidden = YES;
    _controlGes.hidden = YES;
}
-(void)hidSelfWithisHid:(BOOL)isHid{
    self.hidden = isHid;
    _controlGes.hidden = isHid;
}


- (void)viewWillAppear
{
    [super viewWillAppear];
}


- (void)viewwillDisappear
{
    [super viewwillDisappear];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
