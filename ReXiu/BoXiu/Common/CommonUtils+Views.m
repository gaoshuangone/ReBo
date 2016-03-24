//
//  CommonUtils+Views.m
//  CommonUtils
//
//  Created by gs on 15/1/22.
//  Copyright (c) 2015年 gaos. All rights reserved.
//

#import "CommonUtils+Views.h"

@implementation CommonUtils (Views)


//############################设置颜色转换##############################

+(NSString *)stringNoNetwork
{
    return @"获取信息失败，请检查你的网络是否已连接";
}
+(NSString *)stringNoFormat
{
    return @"获取数据失败，请重试！";
}
+(UIColor *) getColor:(NSString *) string
{
    if([string length]!=7) return nil; //必须为7位 #ff0000;
    NSString *res=[string uppercaseString];//转成大写
    
    int red = 0, green = 0,blue = 0;
    const char *hex_char1=[res UTF8String];
    for(int i=1,k=0;k<3;i++,k++)
    {
        if(k==0)
        {
            red=[self numColor:hex_char1[i] num:2];
            red+=[self numColor:hex_char1[++i] num:1];
        }
        else if(k==1)
        {
            green=[self numColor:hex_char1[i] num:2];
            green+=[self numColor:hex_char1[++i] num:1];
        }
        else if(k==2)
        {
            blue=[self numColor:hex_char1[i] num:2];
            blue+=[self numColor:hex_char1[++i] num:1];
        }
        
    }
    
    UIColor *color=[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    return color;
}

//1为个位,2为十位
+(int) numColor:(char)c num:(int)num
{
    int int_ch1;
    //如果为个位
    if(num==1)
    {
        if(c >= '0' && c <='9')
            int_ch1 = c-48;   //// 0 的Ascll - 48
        else if(c >= 'A' && c <='F')
            int_ch1 = c-55; //// A 的Ascll - 65
        else
            return -1;
    }
    else if(num==2)
    {
        if(c >= '0' && c <='9')
            int_ch1 = (c-48)*16;   //// 0 的Ascll - 48
        else if(c >= 'A' && c <='F')
            int_ch1 = (c-55)*16; //// A 的Ascll - 65
        else
            return 0;
    }
    return int_ch1;
}
//############################设置图片###############################
//等比例缩放图片
+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

//获取图片
+(UIImageView *) getViewImage:(CGFloat)left top:(CGFloat)top imgSrc:(NSString *)imgSrc
{
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(left, top, 0, 0)];
    imgView.image=[UIImage imageNamed:imgSrc];
    [imgView sizeToFit];
    return imgView;
}

//获取图片
+(UIImageView *) getViewImage:(CGFloat)left top:(CGFloat)top imgSrc:(NSString *)imgSrc trans:(double) trans
{
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(left, top, 0, 0)];
    UIImage *image=[UIImage imageNamed:imgSrc];
    imgView.image=[self scaleImage:image toScale:trans];
    [imgView sizeToFit];
    return imgView;
    
    // imgView.transform=CGAffineTransformMakeScale(trans,trans);
    
}

//设置图片
+(void) setViewImage:(UIView *)view left:(CGFloat)left top:(CGFloat)top imgSrc:(NSString *)imgSrc
{
    [view addSubview:[self getViewImage:left top:top imgSrc:imgSrc]];
}

//############################设置UIButton#############################################################################################

/*
 UIBarButtonItem返回
 */

+(UIBarButtonItem*)commonButtonItemWithTarget:(id)target withAction:(SEL)action withImageNameIndex:(NSInteger)index{
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (index==0) {
            [button setImage:[UIImage imageNamed:@"memu_home_n.png"] forState:UIControlStateNormal];
         button.frame = CGRectMake(0, 0, 20, 20);
    }
   else if (index==1) {
        [button setImage:[UIImage imageNamed:@"navigation_returnback.png"] forState:UIControlStateNormal];
           button.frame = CGRectMake(0, 0, 20, 20);
   }else{
       
   }


    
    UIBarButtonItem* leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return leftBarItem;

}
//############################设置UIView#############################################################################################

/*
 返回一条线，主要用作填充tableView上的颜色
 */
+(UIView*)CommonViewLineWithFrame:(CGRect)frame{
    UIView* view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.35;
    return view;
}

/*
 隐藏的button，主要用作点击响应
 */
+(UIButton*)commonButtonWithFrame:(CGRect)frame withTarget:(id)target withAction:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom]; //创建button
    [btn setFrame:frame]; //设置button的frame
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
/*
 固定尺寸的button
 */
+(UIButton*)commonButNormalWithFrame:(CGRect)frame withBounds:(CGSize)bounds withOriginX:(CGFloat)x withOriginY:(CGFloat)y isRelativeCoordinate:(BOOL)isRC withTarget:(id)target withAction:(SEL)action{
    
    UIButton* button = [CommonUtils commonButtonWithFrame:frame withTarget:target withAction:action];
    
    button.bounds = CGRectMake(0, 0, bounds.width, bounds.height);
    if (isRC) {
        button.center = CGPointMake(x+button.bounds.size.width/2, y+button.bounds.size.height/2);
    }else{
        button.center = CGPointMake(x,y);
    }

    return button;
    
}
/*
 调整button属性
 */
+(void)commonButSetWithButton:(UIButton*)button WithImageName:(NSString*)imageName withTitle:(NSString*)title withFontSize:(NSInteger)size withColor:(UIColor*)color{
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        return;
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (size) {
        button.titleLabel.font =[UIFont systemFontOfSize:size];
    }
    if (color) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
}

//############################设置图片###############################
+(UIImageView*)commonImageViewWithFrame:(CGRect)frame withImageName:(NSString*)imageName{
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image=[UIImage imageNamed:imageName];
    return imageView;
    
    
}


//############################设置文字###############################
/*
 只返回一行的label
 isRelativeCoordinate：是否是相对坐标（即加上自身的Wide，Hight的一半）
 */
+(UILabel *)commonSignleLabelWithText:(NSString*)text withFontSize:(CGFloat)fontSize withOriginX:(CGFloat)x withOriginY:(CGFloat)y isRelativeCoordinate:(BOOL)isRC{
    UILabel* label =[[UILabel alloc]init];
    label.text =text;
    label.font = [UIFont systemFontOfSize:fontSize];
    [label sizeToFit];
    if (isRC) {
        label.center = CGPointMake(x+label.bounds.size.width/2, y+label.bounds.size.height/2);
    }else{
        label.center = CGPointMake(x,y);
    }
    return label;
    
}
/*
 返回多行的label
 相对坐标（即加上自身的Wide，Hight的一半）
 */
+(UILabel *)commonMoreLabelWithText:(NSString*)text withFontSize:(CGFloat)fontSize withBoundsWide:(CGFloat)boundsWide withOriginX:(CGFloat)x withOriginY:(CGFloat)y{
    UILabel* label =[[UILabel alloc]init];
    label.text =text;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.bounds = CGRectMake(0, 0, boundsWide, MAXFLOAT);
    [label sizeToFit];
    label.center = CGPointMake(x+label.bounds.size.width/2, y+label.bounds.size.height/2);
    
    return label;
    
}








//获取文字的高度
+(float)getLabelHeight:(NSString *)text width:(float)width font:(UIFont *)font
{
//    CGSize size=CGSizeMake(width, 2000);
//    CGSize labelSize=[text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:text
     attributes:@
     {
     NSFontAttributeName: font
     }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, 2000}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize labelSize = rect.size;
    
    return labelSize.height;
}
@end


