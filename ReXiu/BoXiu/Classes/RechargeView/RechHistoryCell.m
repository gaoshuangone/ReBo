//
//  RechHistoryCell.m
//  BoXiu
//
//  Created by andy on 15/9/1.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "RechHistoryCell.h"

@implementation RechHistoryCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ]) {
        
    }
    return  self;
}
-(void)initViewWithData:(BuyHistory*)buyHistory{
    
    NSString* strPayType= nil;
    if ([buyHistory.strPaytype isEqualToString:@"1"]) {
        strPayType =@"支付宝充值";
    }else if ([buyHistory.strPaytype isEqualToString:@"30"]){
        strPayType =@"网银充值";

    }else if ([buyHistory.strPaytype isEqualToString:@"31"]){
        strPayType =@"网银充值";
        
    }
    else if ([buyHistory.strPaytype isEqualToString:@"32"]){
        strPayType =@"网银充值";
        
    }
    else if ([buyHistory.strPaytype isEqualToString:@"40"]){
        strPayType =@"苹果官方充值";
        
    }
    else if ([buyHistory.strPaytype isEqualToString:@"50"]){
        strPayType =@"微信充值";
        
    }else if ([buyHistory.strPaytype isEqualToString:@"6"]){
        strPayType =@"手机卡充值";
        
    }
    
    UILabel* labelPayType = [CommonUtils commonSignleLabelWithText:strPayType withFontSize:15 withOriginX:15 withOriginY:15 isRelativeCoordinate:YES];
    labelPayType.textColor = [CommonFuction colorFromHexRGB:@"6f6f6f"];
    [self.contentView addSubview:labelPayType];
    
    
    UILabel* labelTime= [CommonUtils commonSignleLabelWithText:[CommonUtils getDateForStringTime:buyHistory.strDateTime withFormat:@"MM月dd日 HH:mm"] withFontSize:11 withOriginX:15 withOriginY:CGRectGetMaxY(labelPayType.frame)+8 isRelativeCoordinate:YES];
    labelTime.textColor = [CommonFuction colorFromHexRGB:@"aaaaaa"];
    [self.contentView addSubview:labelTime];
    
    UILabel* labelIconTitelFront= [CommonUtils commonSignleLabelWithText:@"+" withFontSize:18 withOriginX:self.center.x-35 withOriginY:65/2 isRelativeCoordinate:NO];
    labelIconTitelFront.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    [self.contentView addSubview:labelIconTitelFront];
    
    
    NSString* strIcon = nil;
    NSString* strIconTitle = nil;
    if (buyHistory.strCoin.length>=5) {
        
        strIcon =[NSString stringWithFormat:@"%.2f ",[buyHistory.strCoin floatValue]/10000];
      strIconTitle = @"万热币";
    }else{
        strIcon =buyHistory.strCoin;
        strIconTitle =@"热币";
    }
    
    
    UILabel* labelIcon= [CommonUtils commonSignleLabelWithText:strIcon withFontSize:18 withOriginX:CGRectGetMaxX(labelIconTitelFront.frame)+5 withOriginY:65/2 isRelativeCoordinate:NO];
    labelIcon.center = CGPointMake(CGRectGetMaxX(labelIconTitelFront.frame)+labelIcon.frameWidth/2+5, 65/2);
    labelIcon.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    [self.contentView addSubview:labelIcon];
    
    UILabel* labelIconTitel= [CommonUtils commonSignleLabelWithText:strIconTitle withFontSize:11 withOriginX:CGRectGetMaxX(labelIcon.frame)+15 withOriginY:65/2+3 isRelativeCoordinate:NO];
    labelIconTitel.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    [self.contentView addSubview:labelIconTitel];
    
  
    
    
    
    NSString* strIcon1 = nil;
    NSString* strIconTitle1 = nil;
    if (buyHistory.strCostmoney.length>=5) {
        
        strIcon1 =[NSString stringWithFormat:@"%.2f ",[buyHistory.strCostmoney floatValue]/10000];
        strIconTitle1 = @"万元";
    }else{
        strIcon1 =buyHistory.strCostmoney;
        strIconTitle1 =@"元";
    }
    
    
  
    
    UILabel* labelTotolIcon= [CommonUtils commonSignleLabelWithText:strIcon1 withFontSize:19 withOriginX:CGRectGetMaxX(labelIconTitelFront.frame)+5 withOriginY:65/2+1 isRelativeCoordinate:NO];
    labelTotolIcon.center = CGPointMake(SCREEN_WIDTH-(labelTotolIcon.frameWidth/2+26), labelPayType.center.y);
    labelTotolIcon.font = [UIFont boldSystemFontOfSize:17.0f];
    labelTotolIcon.textColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    [self.contentView addSubview:labelTotolIcon];
    
    UILabel* labelTotolIconTitel= [CommonUtils commonSignleLabelWithText:strIconTitle1 withFontSize:11 withOriginX:CGRectGetMaxX(labelTotolIcon.frame)+6 withOriginY:labelPayType.center.y+1 isRelativeCoordinate:NO];
    labelTotolIconTitel.font = [UIFont systemFontOfSize:10.0f];
    labelTotolIconTitel.textColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    [self.contentView addSubview:labelTotolIconTitel];
    
    NSString* strPayStatus= nil;
    
    UIColor* color = nil;
    if ([buyHistory.strStatus isEqualToString:@"1"]) {
        strPayStatus =@"交易未完成";
        color =[CommonFuction colorFromHexRGB:@"959596"];
    }else if ([buyHistory.strStatus isEqualToString:@"2"]){
        strPayStatus =@"交易完成";
         color =[CommonFuction colorFromHexRGB:@"454a4d"];
        
    }
    
    UILabel* labelStatus = [CommonUtils commonSignleLabelWithText:strPayStatus withFontSize:12 withOriginX:15 withOriginY:15 isRelativeCoordinate:YES];
    labelStatus.textColor =color;
    
      labelStatus.center = CGPointMake(CGRectGetMaxX(labelTotolIconTitel.frame)-labelStatus.frameWidth/2, labelTime.center.y-2);
    [self.contentView addSubview:labelStatus];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)addLine{
    UIView* viewLine =[CommonUtils  CommonViewLineWithFrame:CGRectMake(11, 64, SCREEN_WIDTH-22, 0.5)];
    viewLine.backgroundColor =[UIColor lightGrayColor];
    viewLine.alpha = 0.15;
    [self addSubview:viewLine];
}
@end
