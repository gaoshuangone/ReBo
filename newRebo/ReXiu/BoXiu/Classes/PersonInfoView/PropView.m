//
//  PropView.m
//  BoXiu
//
//  Created by andy on 14-7-15.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "PropView.h"
#import "UIButton+WebCache.h"
#import "AppInfo.h"
#import "GetUserCarModel.h"
#import "UserInfoManager.h"
@implementation PropData

@end

@interface PropView ()
@property (nonatomic,strong) NSMutableArray *cellMArray;
@property (nonatomic,strong) PropData* lastProData;
@property (nonatomic,assign) NSInteger LastIndex;
@property (nonatomic,strong) NSMutableArray* array;
@property (nonatomic,assign) BOOL isHaveVIP;

@end
@implementation PropView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)initView:(CGRect)frame
{
    _cellMArray = [NSMutableArray array];
}

- (void)setDataMArray:(NSMutableArray *)dataMArray
{
    
    if (self.isFromPersonInfo) {
        self.lastProData = nil;
        self.isFromPersonInfo = NO;
    }
    
    _dataMArray = dataMArray;
    if (dataMArray && [dataMArray count])
    {
        
        for (int nIndex = 0; nIndex < [_cellMArray count]; nIndex++)
        {
            UIControl *button = [self.cellMArray objectAtIndex:nIndex];
            [button removeFromSuperview];
        }
        [self.cellMArray removeAllObjects];
        
        for (int nIndex =  0 ; nIndex < [dataMArray count]; nIndex++)
            
        {
            PropData *propData = [dataMArray objectAtIndex:nIndex];
            
            
            if (propData.type == 0)
            {
                self.isHaveVIP = YES;
            }
            
            if (propData.useflag == 1 && propData.type != 0 ) {
                if (self.isSelfUserInfo && !self.isChanged) {
                    if (self.isHaveVIP) {
                      
                        [dataMArray  exchangeObjectAtIndex:1 withObjectAtIndex:nIndex];
                        
                    }else{
                        [dataMArray exchangeObjectAtIndex:0 withObjectAtIndex:nIndex];
                    }
                      _dataMArray = dataMArray;
                }
            }
            
            
        }
        
        
        
        
        
        for (int nIndex =  0 ; nIndex < [dataMArray count]; nIndex++)
        {
            
            UIControl* control1 = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
            
            
            
            UIImageView* control2 =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 50)];
            control2.userInteractionEnabled = YES;
            control2.layer.cornerRadius = 3;
            
            
            PropData *propData = [dataMArray objectAtIndex:nIndex];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(12, 10, 45, 30);
            button.backgroundColor = [UIColor clearColor];
            
            if (propData.type == 0)
            {
                [button setImage:[[UserInfoManager shareUserInfoManager] imageOfVip:[propData.imgUrl integerValue]] forState:UIControlStateNormal];
//                self.isHaveVIP = YES;
            }
            else if (propData.type == 1)
            {
                NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,propData.imgUrl];
                [button sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:nil];
                if (self.isSelfUserInfo) {
                    [button addTarget:self action:@selector(OnTouch:) forControlEvents:UIControlEventTouchUpInside];
                }
//                self.isHaveVIP = YES;
            }
//            else if (propData.type == 2)
//            {
//                [button setImage:[UIImage imageNamed:propData.imgUrl] forState:UIControlStateNormal];
//            }
            button.tag = 100+nIndex;
            
            
            
            UIImageView* buttonIcon = [[UIImageView alloc]initWithFrame:CGRectMake(12, 5, 20, 20)];
            buttonIcon.tag = 100+nIndex;
            
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 70, 15)];
            label.backgroundColor = [UIColor clearColor];
            label.center = CGPointMake(button.center.x, CGRectGetMaxY(button.bounds) +10+20);
            label.font = [UIFont systemFontOfSize:11];
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentCenter;
            if (propData.useflag == 1) {
                
                
                if (propData.type != 0 && !self.lastProData)//初始化一个默认值
                {
                    propData.useflag = 0;
                    self.lastProData = propData;
                    self.LastIndex = nIndex;
                    
                    
                }
                
                if (self.isSelfUserInfo) {
                    
//                    control2.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.3];
                    label.text = @"使用中";
                    label.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
                    [buttonIcon setImage:[UIImage imageNamed:@"xuanzhong.png"] ];
                    button.userInteractionEnabled = NO;
                }else{
//                     control2.image = [UIImage imageNamed:@"xuxian.png"];
                }
              
                
            } else {
                if (self.isSelfUserInfo) {
                    label.text = @"未使用";
//                      label.textColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
                    label.textColor = [UIColor lightGrayColor];
                }
//                control2.image = [UIImage imageNamed:@"xuxian.png"];
            }
                control2.image = [UIImage imageNamed:@"xuxian.png"];
            label.tag = 1;
            
            
            [self addSubview:control1];
            [control1 addSubview:control2];
            [control2 addSubview:button];
            [button addSubview:buttonIcon];
            
            [control1 addSubview:label];
         
            
         
                    [self.cellMArray addObject:control1];
            
            
        }
    }
    
}

- (void)layoutSubviews
{
    NSInteger nBtnCount = [self.cellMArray count];
    
    if (nBtnCount > 0)
    {
        for (int nIndex = 0; nIndex < nBtnCount; nIndex++)
        {
            UIControl *button = [self.cellMArray objectAtIndex:nIndex];
            int nX = (nIndex % 4) * 70 + (nIndex % 4)* (SCREEN_WIDTH-280)/5+(SCREEN_WIDTH-280)/5;
            int nY = nIndex/4 * 50 + nIndex/4 * 20;
            button.frame = CGRectMake(nX, nY + 10, 70, 50);
        }
    }
}

//- (void)OnAdd
//{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(buyVip)])
//    {
//        [self.delegate buyVip];
//    }
//}

- (void)OnTouch:(UIButton*)sender
{
    sender.userInteractionEnabled = NO;
    
//    if (self.lastProData) {
//        [self.dataMArray  replaceObjectAtIndex:self.LastIndex withObject:self.lastProData];
//    }
    PropData *propData = [self.dataMArray  objectAtIndex:sender.tag-100];
    
    if (propData.useflag == 1) {
        propData.useflag = 0;
    } else {
        propData.useflag = 1;
        
    }
    if (self.isHaveVIP) {
        self.LastIndex =1;
    }else{
        self.LastIndex = 0;
    }
    
  
//    [self.dataMArray   replaceObjectAtIndex:sender.tag-100 withObject:propData];
    
    
    
    
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",propData.carID],@"carid", nil];
    BaseHttpModel *model = [[BaseHttpModel alloc] init];
    [model requestDataWithMethod:@"usercenter/buyprops/useCar" params:dict success:^(id object)
     {
         if (model.result == 0)
         {
             
             self.isChanged = YES;
                 sender.userInteractionEnabled = YES;
             [self setDataMArray:self.dataMArray ];
             if (propData.useflag == 1) {
                 propData.useflag = 0;
             } else {
                 propData.useflag = 1;
                 
             }
             self.lastProData = propData;
             
             
             if (self.delegate && [self.delegate respondsToSelector:@selector(propDidTouch:)]) {
                 [self.delegate propDidTouch:@"1"];
                 
             }
             
             
         }else{
             
             
             if (self.delegate && [self.delegate respondsToSelector:@selector(propDidTouch:)]) {
                 if (model.code==403) {
                     [self.delegate propDidTouch:@"3"]; 
                 }else{
                 
                 [self.delegate propDidTouch:@"2"];
                 }
                 
             }
         }
     } fail:^(id object)
     {
           [self.delegate propDidTouch:@"2"];
     }];
    
    
    
    
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
