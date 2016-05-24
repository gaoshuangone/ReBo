//
//  PageQueryTableViewCell.m
//  BoXiu
//
//  Created by andy on 15/12/1.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "PageQueryTableViewCell.h"

@implementation PageQueryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ]) {
        
    }
    return  self;
}
-(void)initViewWithData:(TakeBack*)buyHistory{
    
//     NSDecimalNumber* total = [[NSDecimalNumber alloc]initWithString:[[_dictData valueForKey:@"maxmoney"] toString]] ;
    
    UILabel* labelTime1= [CommonUtils commonSignleLabelWithText:[CommonUtils getDateForStringTime:buyHistory.strDatetime withFormat:@"yyyy/MM/dd"] withFontSize:13 withOriginX:15 withOriginY:11 isRelativeCoordinate:YES];
    labelTime1.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [self.contentView addSubview:labelTime1];
    
    UILabel* labelTime2= [CommonUtils commonSignleLabelWithText:[CommonUtils getDateForStringTime:buyHistory.strDatetime withFormat:@"HH:mm:ss"] withFontSize:11 withOriginX:15 withOriginY:33 isRelativeCoordinate:YES];
    labelTime2.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    [self.contentView addSubview:labelTime2];
    
    UILabel* labelTotolIcon= [CommonUtils commonSignleLabelWithText:@"元" withFontSize:10 withOriginX:SCREEN_WIDTH-15 withOriginY:15 isRelativeCoordinate:NO];
    labelTotolIcon.center = CGPointMake(SCREEN_WIDTH-(labelTotolIcon.boundsWide/2+15), 15+labelTotolIcon.boundsHeight/2);
    labelTotolIcon.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    [self.contentView addSubview:labelTotolIcon];
    
    UILabel* labelTotolIconTitel= [CommonUtils commonSignleLabelWithText:[NSString stringWithFormat:@"%.2f",[buyHistory.strMoney floatValue]] withFontSize:17 withOriginX:0 withOriginY:0 isRelativeCoordinate:NO];
    labelTotolIconTitel.font = [UIFont boldSystemFontOfSize:17];
    [labelTotolIconTitel sizeToFit];
    labelTotolIconTitel.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    labelTotolIconTitel.center = CGPointMake(SCREEN_WIDTH-(labelTotolIcon.boundsWide+15)-labelTotolIconTitel.boundsWide/2, labelTime1.center.y);
    [self.contentView addSubview:labelTotolIconTitel];
    
    NSString* strStatus = nil;
    UIColor* colorStatus = nil;
    if ([buyHistory.strStatus isEqualToString:@"1"]) {
        strStatus = @"处理中";
        colorStatus = [CommonUtils colorFromHexRGB:@"454a4d"];
        
        
    }else if ([buyHistory.strStatus isEqualToString:@"2"]){
        strStatus = @"提现成功";
        colorStatus = [CommonUtils colorFromHexRGB:@"f7c250"];
        
        
    }else if ([buyHistory.strStatus isEqualToString:@"3"]){
        strStatus = @"提现失败";
        colorStatus = [CommonUtils colorFromHexRGB:@"cbcbcb"];
        
        labelTotolIcon.textColor =[CommonUtils colorFromHexRGB:@"cbcbcb"];
        labelTotolIconTitel.textColor =[CommonUtils colorFromHexRGB:@"cbcbcb"];
        
        
        
    }else if ([buyHistory.strStatus isEqualToString:@"4"]){
        strStatus = @"已发放";//暂时不用
        colorStatus = [CommonUtils colorFromHexRGB:@"454a4d"];
        
        
        
    }else if ([buyHistory.strStatus isEqualToString:@"5"]){
        strStatus = @"已发放";
        colorStatus = [CommonUtils colorFromHexRGB:@"454a4d"];
        
        
    }else if ([buyHistory.strStatus isEqualToString:@"6"]){
        strStatus = @"提现成功";
        colorStatus = [CommonUtils colorFromHexRGB:@"f7c250"];
    }
    
    else{
        strStatus = @"提现失败";
        colorStatus = [CommonUtils colorFromHexRGB:@"cbcbcb"];
        
        labelTotolIcon.textColor =[CommonUtils colorFromHexRGB:@"cbcbcb"];
        labelTotolIconTitel.textColor =[CommonUtils colorFromHexRGB:@"cbcbcb"];
    }

    UILabel* labelStatus = [CommonUtils commonSignleLabelWithText:strStatus withFontSize:11 withOriginX:15 withOriginY:15 isRelativeCoordinate:YES];
    labelStatus.textColor =colorStatus;
    labelStatus.center = CGPointMake(SCREEN_WIDTH-(labelStatus.boundsWide/2+15), labelTime2.center.y);
    [self.contentView addSubview:labelStatus];
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)addLine{
    UIView* viewLine =[CommonUtils  CommonViewLineWithFrame:CGRectMake(11, 59, SCREEN_WIDTH-22, 0.5)];
    viewLine.backgroundColor =[UIColor lightGrayColor];
    viewLine.alpha = 0.15;
    [self.contentView addSubview:viewLine];
}
-(void)addLineheader{
    UIView* viewLine =[CommonUtils  CommonViewLineWithFrame:CGRectMake(11, 0, SCREEN_WIDTH-22, 0.5)];
    viewLine.backgroundColor =[UIColor lightGrayColor];
    viewLine.alpha = 0.15;
    [self.contentView addSubview:viewLine];
}
@end
